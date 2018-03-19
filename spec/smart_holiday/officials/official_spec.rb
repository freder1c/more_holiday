RSpec.describe SmartHoliday::Official do
  describe "#list" do
    subject { described_class.new(state: "Berlin").list }

    context "when state is included" do
      it { is_expected.to eq([]) }
    end

    context "when service for specific country is not defined" do
      it {
        allow_any_instance_of(SmartHoliday::Official).to receive(:country).and_return(:xx)
        expect{ subject }.to raise_error(SmartHoliday::NotProvidedError)
      }
    end

    context "when state is not included" do
      subject { described_class.new(state: "NotIncludedState").list }
      it { expect{ subject }.to raise_error(SmartHoliday::InvalidStateError) }
    end
  end
end
