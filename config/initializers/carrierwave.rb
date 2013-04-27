CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => "AWS",                          # required
    :aws_access_key_id      => ENV["AWS_ACCESS_KEY_ID"],       # required
    :aws_secret_access_key  => ENV["AWS_SECRET_ACCESS_KEY"],   # required
    :region                 => ENV["AWS_REGION"]               # optional, defaults to 'us-east-1'
  }
  config.fog_directory  =  ENV["AWS_BUCKET"] # required

  config.max_file_size     = 100.megabytes        # defaults to 5.megabytes
  # see https://github.com/jnicklas/carrierwave#using-amazon-s3
  # for more optional configuration
end

