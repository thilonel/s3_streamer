require 'net/http'
require 's3_streamer/buffered_writer'

module S3Streamer
  class Downstream
    DEFAULT_PART_SIZE = 10 * 1024 * 1024

    attr_reader :uri

    def initialize(uri, options={})
      @uri = uri
      @options = options
    end

    def each
      Net::HTTP.start(uri.host, uri.port, use_ssl: use_ssl) do |http|
        http.request get_uri do |response|
          buffer = BufferedWriter.new(min_part_size: part_size) do |part|
            yield part
          end

          response.read_body { |chunk| buffer.push chunk }

          buffer.finish
        end
      end
    end

    private

    def use_ssl
      uri.scheme == 'https'
    end

    def get_uri
      Net::HTTP::Get.new uri
    end

    def part_size
      @options[:part_size] || DEFAULT_PART_SIZE
    end
  end
end
