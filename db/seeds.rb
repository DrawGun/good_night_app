require_relative '../config/environment'

Following.dataset.destroy
SleepPeriod.dataset.destroy
User.dataset.destroy

%w(Bob Joahn Nik).each do |name|
  User.create(name: name)
end
