require_relative 'config/environment'

map '/' do
  run SleepPeriodRoutes
  run UserRoutes
end
