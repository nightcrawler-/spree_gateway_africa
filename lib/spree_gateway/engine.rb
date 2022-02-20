module SpreeGateway
  class Engine < Rails::Engine
    engine_name 'spree_gateway'

    config.autoload_paths += %W(#{config.root}/lib)

    initializer "spree.gateway.payment_methods", :after => "spree.register.payment_methods" do |app|
      app.config.spree.payment_methods << Spree::Gateway::FlutterwaveMpesa
      app.config.spree.payment_methods << Spree::Gateway::FlutterwaveZambiaMobileMoney
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/spree/*_decorator*.rb')) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/spree_gateway/*_decorator*.rb')) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/spree_gateway/admin/*_decorator*.rb')) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end

      if self.frontend_available?
        Dir.glob(File.join(File.dirname(__FILE__), '../../lib/spree_frontend/controllers/spree/*_decorator*.rb')) do |c|
          Rails.application.config.cache_classes ? require(c) : load(c)
        end
      end
    end

    def self.backend_available?
      @@backend_available ||= ::Rails::Engine.subclasses.map(&:instance).map{ |e| e.class.to_s }.include?('Spree::Backend::Engine')
    end

    def self.frontend_available?
      @@frontend_available ||= ::Rails::Engine.subclasses.map(&:instance).map{ |e| e.class.to_s }.include?('Spree::Frontend::Engine')
    end

    if self.backend_available?
      paths["app/views"] << "lib/views/backend"
    end

    paths['app/controllers'] << 'lib/controllers'

    if self.frontend_available?
      paths["app/controllers"] << "lib/spree_frontend/controllers"
      paths["app/views"] << "lib/views/frontend"
    end

    config.to_prepare &method(:activate).to_proc
  end
end
