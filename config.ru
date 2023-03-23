require_relative 'config/environment'

use Rack::Runtime
use Rack::Deflater
use Rack::RequestId
use Rack::Ougai::LogRequests, Application.logger

map '/v1/sleep_periods' do
  run SleepPeriodRoutes
end

map '/v1/users' do
  run UserRoutes
end
