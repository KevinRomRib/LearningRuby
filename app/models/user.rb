require 'psych'

class User
  attr_accessor :name, :cpf, :zip_code

  def initialize(name, cpf, zip_code)
    @name = name
    @cpf = cpf
    @zip_code = zip_code
  end

  def to_hash
    { 'name' => @name, 'cpf' => @cpf, 'zip_code' => @zip_code }
  end

  def to_json(*_args)
    to_hash.to_json
  end

  def save
    users = User.all
    users << to_hash
    File.open('db/users.yml', 'w') { |file| file.write(Psych.dump(users)) }
  end

  def self.all
    if File.exist?('db/users.yml')
      users_data = Psych.load_file('db/users.yml') || []
      users_data.map { |user_data| User.new(user_data['name'], user_data['cpf'], user_data['zip_code']) }
    else
      []
    end
  end

  def self.find_by_cpf(cpf)
    all.find { |user| user.cpf == cpf }
  end
end
