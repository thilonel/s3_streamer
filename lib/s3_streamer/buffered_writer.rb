module S3Streamer
  class BufferedWriter
    attr_reader :options, :buffer

    def initialize(options, &block)
      @options = options
      @block = block
      clear
    end

    def push(chunk)
      @buffer << chunk
      write if @buffer.size > min_part_size
    end

    def finish
      write if @buffer.size > 0
    end

    private

    def write
      @block.call buffer
      clear
    end

    def min_part_size
      options[:min_part_size] || 1024
    end

    def clear
      @buffer = ""
    end
  end
end
