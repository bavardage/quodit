Rails.application.config.middleware.use OmniAuth::Builder do
  FB_APP_ID = '133081810117881'
  FB_APP_SECRET = '562d30b89c49f380bd7565f258ca3a92'
  provider :facebook, FB_APP_ID, FB_APP_SECRET, {
    :scope => 'publish_stream,offline_access,email',
    :client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}}
  
end
