client = Awscr::S3::Client.new(
  "minio",
  "minioadmin",
  "minioadmin",
  endpoint: "http://localhost:9000"
)

Shrine.configure do |config|
  config.storages["store"] = Shrine::Storage::S3.new(bucket: "day", client: client)
end