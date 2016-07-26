require 'net/http'
require_relative 'downstream/chunk_buffer'

class Downstream
  DEFAULT_PART_SIZE = 10 * 1024 * 1024

  def initialize(uri, options={})
    @uri = uri
    @options = options
  end

  def each
    Net::HTTP.start(@uri.host) do |http|
      http.request(Net::HTTP::Get.new @uri) do |response|
        buffer = BufferedWriter.new(min_part_size: part_size) do |part|
          yield part
        end

        response.read_body { |chunk| buffer.push chunk }

        buffer.finish
      end
    end
  end

  private

  def part_size
    @options[:part_size] || DEFAULT_PART_SIZE
  end
end
