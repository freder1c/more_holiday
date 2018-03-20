RSpec.describe MoreHoliday::Reader do
  let(:ical_path) { File.join("spec", "fixtures", "reader", "ical.ics") }
  let(:bin_path) { File.join("spec", "fixtures", "reader", "bin") }

  describe "#list" do
    context "when file is ical file" do
      subject { described_class.new(ical_path).list }
      it { is_expected.to be_a_kind_of(Array) }
    end

    context "when file could not be found" do
      subject { described_class.new("invalid/path/").list }
      it { expect{ subject }.to raise_error(Errno::ENOENT) }
    end

    context "when file type is not supported" do
      subject { described_class.new(bin_path).list }
      it { expect{ subject }.to raise_error(LoadError) }
    end
  end
end
