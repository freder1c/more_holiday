RSpec.describe MoreHoliday::Calculate do
  describe "#holidays" do
    subject { described_class.new(state: "Berlin", days_count: 24).holidays }

    context "when holidays get calculated correctly" do
      it {
        is_expected.to eq({
          holidays: [],
          officials: []
        })
      }
    end
  end
end
