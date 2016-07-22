require 'spec_helper'

describe S3Streamer do
  let(:bucket_name) { ENV['BUCKET'] }
  let(:source_url) { URI(ENV['SOURCE_URL']) }
  let(:destination_file_name) { "test_#{Time.now.to_i}" }
  let(:streamer) do
    S3Streamer::Client.new access_key_id: ENV['ACCESS_KEY_ID'],
                           secret_access_key: ENV['SECRET_ACCESS_KEY'],
                           region: ENV['REGION']
  end

  after { streamer.client.delete_object bucket: bucket_name, key: destination_file_name }

  it 'streams from an URL to a bucket' do
    expect { streamer.stream source_url, bucket_name, destination_file_name }
      .to change { objects_list }.by [destination_file_name]
  end

  def objects_list
    streamer.client.list_objects(bucket: bucket_name).contents.map(&:key)
  end
end
