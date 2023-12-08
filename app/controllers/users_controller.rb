require 'sinatra/base'
require 'json'
require_relative '../models/user'

class UsersController < Sinatra::Base
  before do
    content_type :json
  end

  get '/users' do
    @users = User.all
    @users.to_json
  end

  get '/users/:cpf' do
    @user = User.find_by_cpf(params['cpf'])
    if @user
      @user.to_json
    else
      status 404
      { message: 'User not found' }.to_json
    end
  end

  post '/users' do
    user = User.new(params['name'], params['cpf'], params['zip_code'])
    user.save
    status 201
    { message: 'User created successfully' }.to_json
  end

  put '/users/:cpf' do
    @user = User.find_by_cpf(params['cpf'])
    if @user
      @user.name = params['name']
      @user.zip_code = params['zip_code']
      @user.save
      { message: 'User updated successfully' }.to_json
    else
      status 404
      { message: 'User not found' }.to_json
    end
  end

  delete '/users/:cpf' do
    @user = User.find_by_cpf(params['cpf'])
    if @user
      @user.delete
      { message: 'User deleted successfully' }.to_json
    else
      status 404
      { message: 'User not found' }.to_json
    end
  end
end
