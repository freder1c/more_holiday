RSpec.describe MoreHoliday::Holiday do
  before(:each) do
    allow_any_instance_of(MoreHoliday::Connector).to receive(:holidays).and_return([])
    allow_any_instance_of(MoreHoliday::Connector).to receive(:state).and_return("state")
    allow_any_instance_of(MoreHoliday::Connector).to receive(:source).and_return("source")
    allow_any_instance_of(MoreHoliday::Calculator).to receive(:suggestions).and_return([])
  end

  describe "#make_more_out_of_may_holidays!" do
    it {
      expect_any_instance_of(described_class).to receive(:suggestions)
      described_class.new("state").make_more_out_of_may_holidays!
    }
  end

  describe "#suggestions" do
    subject { described_class.new("state").suggestions }
    it do
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
end
