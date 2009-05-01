app = Rack::Builder.new { 
	use Rails::Rack::LogTailer unless options[:detach]
	use Rails::Rack::Debugger if options[:debugger]
	map "/" do
	  use Rails::Rack::Static
	  run ActionController::Dispatcher.new
	end
}.to_app