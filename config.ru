require_relative 'config/environment'

use Rack::Runtime
use Rack::Deflater
use Rack::RequestId
use Rack::Ougai::LogRequests, Application.logger

run Application
