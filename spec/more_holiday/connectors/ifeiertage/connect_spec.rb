require "more_holiday/connectors/ifeiertage/ifeiertage"

RSpec.describe MoreHoliday::Ifeiertage::Connect do
  let(:response_body) { File.read(File.join("spec", "fixtures", "reader", "ical.ics")) }

  describe ".get" do
    subject { described_class.get("Berlin") }

    context "when connection to provider via get" do
      before(:each) do
        stub_request(:get, /ifeiertage.de/).
        with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(status: 200, body: response_body, headers: {})
      end

      it "should respond with ical data" do
        is_expected.to eq(response_body)
      end
    end
  end
end
