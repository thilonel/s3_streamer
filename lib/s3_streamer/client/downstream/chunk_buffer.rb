class ChunkBuffer
  def initialize(response, chunks_per_buffer = 10240)
    @response = response
    @chunks_per_buffer = chunks_per_buffer
  end

  def each
    buffer = []
    @response.read_body do |chunk|
      buffer << chunk
      if buffer.size >= @chunks_per_buffer
        yield buffer.join
        buffer = []
      end
    end
    yield buffer.join if buffer.size > 0
  end
end
