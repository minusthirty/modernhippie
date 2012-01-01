if Rails.env.production? || Rails.env.staging?
  PAPERCLIP_STORAGE_OPTIONS = {  :storage   => :s3, 
                                 :bucket    => ENV['S3_BUCKET'],
                                 :path      => ':class/:attachment/:id/:style.:extension',
                                 :s3_credentials => { :access_key_id     => ENV['S3_KEY'], 
                                                      :secret_access_key => ENV['S3_SECRET'] } 
                              }
else
  PAPERCLIP_STORAGE_OPTIONS = {}
end