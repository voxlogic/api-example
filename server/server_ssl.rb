require 'webrick/https'

module Sinatra
  class Application
    def self.run!
      server_options = {
        Host: bind,
        Port: port,
        SSLEnable: true,
        SSLCertName: [['CN', 'localhost', OpenSSL::ASN1::PRINTABLESTRING]]
      }

      Rack::Handler::WEBrick.run self, server_options do |server|
        [:INT, :TERM].each { |sig| trap(sig) { server.stop } }
        server.threaded = settings.threaded if server.respond_to? :threaded=
        set :running, true
      end
    end
  end
end
