require 'net/http'
require_relative 'downstream/chunk_buffer'

class Downstream
  def initialize(uri)
    @uri = uri
  end

  def each
    Net::HTTP.start(@uri.host) do |http|
      http.request(Net::HTTP::Get.new @uri) do |response|
        ChunkBuffer.new(response).each do |chunk|
          yield chunk
        end
      end
    end
  end
end
