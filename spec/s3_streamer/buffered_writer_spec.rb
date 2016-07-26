require 's3_streamer/buffered_writer'

module S3Streamer
  describe BufferedWriter do
    subject { described_class.new options, &block }
    let(:options) { { min_part_size: 16 } }
    let(:block) { ->(part) { @writed_parts << part } }

    before { @writed_parts = [] }

    describe "#push" do
      it "adds a chunk to buffer" do
        expect { subject.push "something" }
          .to change { subject.buffer }.from("").to "something"
      end

      it "adds multiple chunk in order" do
        subject.push "hello"
        subject.push "world"

        expect(subject.buffer).to eq "helloworld"
      end

      it "writes buffer if it reaches the min part size" do
        subject.push "hello"
        subject.push "world"
        subject.push "something"

        expect(@writed_parts).to eq ["helloworldsomething"]
      end

      it "empty the buffer after write out" do
        subject.push "hello"
        subject.push "world"
        subject.push "something"

        expect(subject.buffer).to eq ""
      end
    end

    describe "#finish" do
      it "writes out the actual content" do
        subject.push "hello"

        subject.finish

        expect(@writed_parts).to eq ["hello"]
      end

      it "do nothing if the buffer is empty" do
        subject.finish

        expect(@writed_parts).to eq []
      end
    end
  end
end
