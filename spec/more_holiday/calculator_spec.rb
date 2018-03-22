RSpec.describe MoreHoliday::Calculator do
  let(:initialize_described_class) { described_class.new(holidays, 15) }

  let(:holidays) {[
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

  let(:holiday_day_numbers) {[1, 89, 91, 92, 121, 130, 140, 141, 276, 359, 360]}
  let(:week_end_day_numbers) {[
    6, 7, 13, 14, 20, 21, 27, 28, 34, 35, 41, 42, 48, 49, 55, 56, 62, 63,
    69, 70, 76, 77, 83, 84, 90, 91, 97, 98, 104, 105, 111, 112, 118, 119,
    125, 126, 132, 133, 139, 140, 146, 147, 153, 154, 160, 161, 167, 168,
    174, 175, 181, 182, 188, 189, 195, 196, 202, 203, 209, 210, 216, 217,
    223, 224, 230, 231, 237, 238, 244, 245, 251, 252, 258, 259, 265, 266,
    272, 273, 279, 280, 286, 287, 293, 294, 300, 301, 307, 308, 314, 315,
    321, 322, 328, 329, 335, 336, 342, 343, 349, 350, 356, 357, 363, 364
  ]}
  let(:non_working_day_numbers){ (week_end_day_numbers + holiday_day_numbers).uniq.sort }


  describe "#suggestions" do
    subject { initialize_described_class.suggestions }
    it do
      is_expected.to eq([
        "2018-04-30",
        "2018-05-02",
        "2018-05-03",
        "2018-05-04",
        "2018-05-07",
        "2018-05-08",
        "2018-05-09",
        "2018-05-11",
        "2018-10-01",
        "2018-10-02",
        "2018-10-04",
        "2018-10-05",
        "2018-12-24",
        "2018-12-27",
        "2018-12-28"
      ])
    end
  end

  describe "#first_sunday_of_year" do
    subject { initialize_described_class.send("first_sunday_of_year") }
    it { is_expected.to eq(7) }
  end

  describe "#holiday_day_numbers" do
    subject { initialize_described_class.send("holiday_day_numbers") }
    it "should collect all day numbers of holidays" do
      is_expected.to eq(holiday_day_numbers)
    end
  end

  describe "#week_end_day_numbers" do
    subject { initialize_described_class.send("week_end_day_numbers") }
    it "should collect all day numbers of saturdays and sundays of specific year" do
      is_expected.to eq(week_end_day_numbers)
    end
  end

  describe "#find_bridges/1" do
    subject { initialize_described_class.send("find_bridges", non_working_day_numbers, 1) }
    it "should find correct bridges for size 1" do
      is_expected.to eq([120, 131, 358])
    end
  end

  describe "#find_bridges/2" do
    subject { initialize_described_class.send("find_bridges", non_working_day_numbers, 2) }
    it "should find correct bridges for size 2" do
      is_expected.to eq([274, 275, 277, 278, 361, 362])
    end
  end
end
