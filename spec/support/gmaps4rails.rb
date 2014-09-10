RSpec.configure do |config|
  config.before(:each) do |example|
    unless self.class.metadata[:geocode] == true
      Gmaps4rails::ModelHandler.any_instance.stub(:prevent_geocoding?) do
        true
      end
    end
  end
end
