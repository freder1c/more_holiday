RSpec.describe MoreHoliday::Importer do
  let(:ical_path) { File.join("spec", "fixtures", "reader", "ical.ics") }
  let(:bin_path) { File.join("spec", "fixtures", "reader", "bin") }

  describe "#from_file" do
    context "when file is ical" do
      subject { described_class.new.from_file(ical_path) }
      it { is_expected.to be_a_kind_of(Array) }
    end

    context "when file could not be found" do
      subject { described_class.new.from_file("invalid/path/") }
      it { expect{ subject }.to raise_error(Errno::ENOENT) }
    end

    context "when file type is not supported" do
      subject { described_class.new.from_file(bin_path) }
      it { expect{ subject }.to raise_error(LoadError) }
    end
  end

  describe "#from_stream" do
    context "when stream is ical" do
      subject { described_class.new.from_stream(File.read(ical_path)) }
      it { is_expected.to be_a_kind_of(Array) }
    end

    context "when stream content type cannot be detected" do
      subject { described_class.new.from_stream("!§$&//") }
      it { expect{ subject }.to raise_error(described_class::StreamContentTypeError) }
    end
  end
end
