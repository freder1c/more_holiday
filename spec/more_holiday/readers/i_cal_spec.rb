RSpec.describe MoreHoliday::Readers::ICal do
  let(:ical_path) { File.join("spec", "fixtures", "reader", "ical.ics") }

  describe "#list" do
    subject { described_class.new(ical_path).serialize }

    context "when serializing file correctly" do
      it {
        is_expected.to eq([
          ["2018-01-01", "Neujahr"],
          ["2018-01-06", "Heilige Drei Könige"],
          ["2018-03-30", "Karfreitag"],
          ["2018-04-01", "Ostersonntag"],
          ["2018-04-02", "Ostermontag"],
          ["2018-05-01", "Tag der Arbeit"],
          ["2018-05-10", "Christi Himmelfahrt"],
          ["2018-05-20", "Pfingstsonntag"],
          ["2018-05-21", "Pfingstmontag"],
          ["2018-05-31", "Fronleichnam"],
          ["2018-08-15", "Mariä Himmelfahrt"],
          ["2018-10-03", "Tag der Deutschen Einheit"],
          ["2018-10-31", "Reformationstag"],
          ["2018-11-01", "Allerheiligen"],
          ["2018-11-21", "(Buß- und Bettag)"],
          ["2018-12-25", "1. Weihnachtsfeiertag"],
          ["2018-12-26", "2. Weihnachtsfeiertag"]
        ])
      }
    end
  end
end
