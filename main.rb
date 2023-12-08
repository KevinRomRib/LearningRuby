require 'sinatra'
require_relative 'app/controllers/users_controller'

use UsersController

before '/users/*' do
  content_type :json
end

get '/users' do
  UsersController.new.index.to_json
end

get '/users/:cpf' do
  UsersController.new.show(params).to_json
end

post '/users' do
  UsersController.new.create(params).to_json
end

put '/users/:cpf' do
  UsersController.new.update(params).to_json
end

delete '/users/:cpf' do
  UsersController.new.delete(params).to_json
end
