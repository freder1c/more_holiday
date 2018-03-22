RSpec.describe MoreHoliday::Holiday do
  before(:each) do
    allow_any_instance_of(MoreHoliday::Connector).to receive(:holidays).and_return([])
    allow_any_instance_of(MoreHoliday::Connector).to receive(:state).and_return("state")
    allow_any_instance_of(MoreHoliday::Connector).to receive(:source).and_return("source")
    allow_any_instance_of(MoreHoliday::Calculator).to receive(:suggestions).and_return([])
    allow_any_instance_of(MoreHoliday::Exporter).to receive(:to_file).and_return(path)
  end

  let(:path) { File.join("tmp", "rspec") }

  describe "#make_more_out_of_may_holidays!" do
    it "should call #suggestions" do
      expect_any_instance_of(described_class).to receive(:suggestions)
      described_class.new("state").make_more_out_of_may_holidays!
    end
  end

  describe "#suggestions" do
    subject { described_class.new("state").suggestions }
    it "should return structured suggestions" do
      is_expected.to eq({
        holidays_to_take: [],
        official_holidays: [],
        info: {
          state: "state",
          officials_source: "source"
        }
      })
    end
  end

  describe "#give_me_a_calender_file!" do
    it "should call #export_ical_file" do
      expect_any_instance_of(described_class).to receive(:export_ical_file).with(path)
      described_class.new("state").give_me_a_calender_file!(path)
    end
  end

  describe "#export_ical_file" do
    subject { described_class.new("state").export_ical_file(path) }
    it "should return output file path" do
      is_expected.to eq(path)
    end
  end
end
