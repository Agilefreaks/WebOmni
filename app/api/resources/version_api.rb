module WebOmni
  class Resources::VersionAPI < Grape::API
    resource :version do
      get do
        Configuration.app_version
      end
    end
  end
end
