class Upstream
  def initialize(client, bucket, destination_file)
    @client = client
    @bucket = bucket
    @destination_file = destination_file
    @parts = []
    @part_number = 1
    @upload_id = create
  end

  def upload(chunk)
    uploaded_part = @client.upload_part(body: chunk,
                                        bucket: @bucket,
                                        key: @destination_file,
                                        part_number: @part_number,
                                        upload_id: @upload_id)

    @parts << {etag: uploaded_part.etag, part_number: @part_number}

    @part_number += 1
  end

  def complete
    @client.complete_multipart_upload(bucket: @bucket,
                                      key: @destination_file,
                                      upload_id: @upload_id,
                                      multipart_upload: {parts: @parts})
  end

  private

  def create
    @client.create_multipart_upload(bucket: @bucket, key: @destination_file).upload_id
  end
end
