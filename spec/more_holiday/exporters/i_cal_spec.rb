RSpec.describe MoreHoliday::Exporters::ICal do
  let(:content) {[
    ["2018-01-01", "Neujahr"],
    ["2018-03-30", "Karfreitag"],
    ["2018-04-01", "Ostersonntag"],
    ["2018-04-02", "Ostermontag"],
    ["2018-05-01", "Tag der Arbeit"],
    ["2018-05-10", "Christi Himmelfahrt"],
    ["2018-05-20", "Pfingstsonntag"],
    ["2018-05-21", "Pfingstmontag"],
    ["2018-10-03", "Tag der Deutschen Einheit"],
    ["2018-12-25", "1. Weihnachtsfeiertag"],
    ["2018-12-26", "2. Weihnachtsfeiertag"]
  ]}

  describe "#serialize" do
    context "when serializing file correctly" do
      it "should return valid ical stream" do
        expect(described_class.new(content).serialize.start_with?("BEGIN:VCALENDAR")).to be(true)
      end
    end
  end
end
