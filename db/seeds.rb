require_relative '../models/user'

User.destroy_all

%w(Bob Joahn Nik).each do |name|
  User.create(name: name)
end
