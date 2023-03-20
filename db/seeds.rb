require_relative '../models/ad'

User.destroy_all

%w(Bob Joahn Nik).each do |name|
  User.create(name: name)
end
