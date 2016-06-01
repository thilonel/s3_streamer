require 'spec_helper'

describe S3Streamer do
  it 'streams from an URL to a bucket' do
    client = S3Streamer::Client.new(access_key_id: ENV['ACCESS_KEY_ID'],
                                    secret_access_key: ENV['SECRET_ACCESS_KEY'],
                                    region: ENV['REGION'])

    destination_file_name = "test_#{Time.now.to_i}"
    client.stream URI(ENV['SOURCE_URL']), ENV['BUCKET'], destination_file_name
  end
end
