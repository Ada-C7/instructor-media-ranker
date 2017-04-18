OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV["GITHUB_CLIENT_ID"], ENV["GITHUB_CLIENT_SECRET"], scope: "user:email" #only email will be requested.
  provider :google_oauth2, 'ricecakemonster', 'Vp9GA6gX-lyg_V2S8Cri_3FK', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
