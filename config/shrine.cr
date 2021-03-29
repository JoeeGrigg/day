# class Shrine
#   module Storage
#     class S3 < Storage::Base
#       def url(id : String, **options) : String
#         presigned_options = Awscr::S3::Presigned::Url::Options.new(
#           aws_access_key: client.@aws_access_key,
#           aws_secret_key: client.@aws_secret_key,
#           region: client.@region,
#           object: "/#{object_key(id)}",
#           bucket: bucket,
#           host_name: client.@endpoint
#         )

#         url = Awscr::S3::Presigned::Url.new(presigned_options)
#         url.for(:get)
#       end
#     end
#   end
# end

# module Awscr
#   module S3
#     module Presigned
#       class Url
#         def for(method : Symbol)
#           raise S3::Exception.new("unsupported method #{method}") unless allowed_methods.includes?(method)

#           request = build_request(method.to_s.upcase)

#           @options.additional_options.each do |k, v|
#             request.query_params.add(k, v)
#           end

#           presign_request(request)

#           "#{request.headers["Host"]}#{request.resource}"
#         end
#       end
#     end
#   end
# end

client = Awscr::S3::Client.new(
  "minio",
  "minioadmin",
  "minioadmin",
  endpoint: "http://localhost:9000"
)

Shrine.configure do |config|
  config.storages["store"] = Shrine::Storage::S3.new(bucket: "day", client: client)
end