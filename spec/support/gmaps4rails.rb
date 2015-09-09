RSpec.configure do |config|
  config.before(:each) do |example|
    unless self.class.metadata[:geocode] == true
      allow_any_instance_of(Gmaps4rails::ModelHandler).to receive(:prevent_geocoding?)
        .and_return(true)
    end
  end
end
