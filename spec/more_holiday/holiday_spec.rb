RSpec.describe MoreHoliday::Holiday do
  before(:each) do
    allow_any_instance_of(MoreHoliday::Connector).to receive(:holidays).and_return([])
    allow_any_instance_of(MoreHoliday::Connector).to receive(:state).and_return("state")
    allow_any_instance_of(MoreHoliday::Connector).to receive(:source).and_return("source")
  end

  describe "#calculate" do
    subject { described_class.new("state").calculate }
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
