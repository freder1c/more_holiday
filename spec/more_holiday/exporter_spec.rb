RSpec.describe MoreHoliday::Exporter do
  let(:path) { File.join("tmp", "rspec", "exporter") }
  let(:filename) { "MoreHoliday" }

  before(:each) do
    FileUtils.mkdir_p(File.join("tmp", "rspec"))
  end

  after(:each) do
    FileUtils.rm_rf(File.join("tmp", "rspec"))
  end

  describe "#to_file" do
    context "when type is set to ical" do
      subject { described_class.new([]).to_file(path, type: "ical") }

      it "should return output patch" do
        is_expected.to eq(File.join(path, "#{filename}.ics"))
      end

      it "should successfully write ical file" do
        subject; expect(File.exist?(File.join(path, "#{filename}.ics"))).to be(true)
      end
    end

    context "when type is not supported" do
      it { expect{ described_class.new([]).to_file(path, type: "not_supported") }.to raise_error(described_class::NotSupportedError) }
    end
  end

  describe "#to_stream" do
    context "when type is set to ical" do
      it "should return ical output stream" do
        expect(described_class.new([]).to_stream("ical").start_with?("BEGIN:VCALENDAR")).to be(true)
      end
    end
  end
end
