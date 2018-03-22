RSpec.describe MoreHoliday::Importers::ICal do
  let(:ical_path) { File.join("spec", "fixtures", "reader", "ical.ics") }

  describe "#serialize" do
    context "when serializing file correctly" do
      it "should return all events from 2018" do
        expect(described_class.new(File.read(ical_path), year: 2018).serialize).to eq([
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
        ])
      end

      it "should return no events" do
        expect(described_class.new(File.read(ical_path), year: 1970).serialize).to eq([])
      end
    end
  end
end
