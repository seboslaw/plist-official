require 'plist'

module Plist
  autoload :PlistResponder, 'plist/responder'
  
  if defined? Rails::Railtie
    require 'rails'
    class Railtie < Rails::Railtie
      initializer 'plist.add_plist_responder' do
        ActiveSupport.on_load :active_record do
          Plist::Railtie.insert
        end
      end
    end
  end

  class Railtie
    def self.insert
      Mime::Type.register 'application/xml', :plist
      
      ActionController::Renderers.add :plist do |data, options|
        data = data.as_json(options)
      
        self.content_type ||= Mime::PLIST
        self.response_body = Plist::Emit.dump(data)
      end
    end
  end
end
