require 'aws-sdk'

require 's3_streamer/downstream'
require 's3_streamer/upstream'

module S3Streamer
  class Client
    attr_reader :client

    def initialize(options)
      @client = Aws::S3::Client.new(options)
    end

    def stream(source_uri, bucket, destination_file)
      upstream = Upstream.new @client, bucket, destination_file

      Downstream.new(URI(source_uri)).each do |chunk|
        upstream.upload chunk
      end

      upstream.complete
    end
  end
end
