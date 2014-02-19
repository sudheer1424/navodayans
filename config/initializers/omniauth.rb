OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '415467711930716', 'f9873bed860cc06ebdfdbf0508044b38'
end