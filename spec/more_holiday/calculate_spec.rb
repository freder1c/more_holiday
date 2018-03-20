RSpec.describe MoreHoliday::Calculate do
  describe "#holidays" do
    before(:each) do
      allow_any_instance_of(MoreHoliday::Connector).to receive(:source).and_return("connector_source")
      allow_any_instance_of(MoreHoliday::Connector).to receive(:list).and_return([])
      allow_any_instance_of(MoreHoliday::Reader).to receive(:list).and_return([])
    end

    context "when initialized without officials_file_path" do
      subject { described_class.new(state: "Berlin").holidays }

      it "should return 'connector_source' as officials_source" do
        is_expected.to include({ info: { state: "Berlin", officials_source: "connector_source" } })
      end

      it "should initialize Connector and call #list" do
        expect_any_instance_of(MoreHoliday::Connector).to receive(:list)
        subject
      end
    end

    context "when initialized with officials_file_path" do
      subject { described_class.new(state: "Berlin", officials_file_path: "path/to/file").holidays }

      it "should return 'file' as officials_source" do
        is_expected.to include({ info: { state: "Berlin", officials_source: "file" } })
      end

      it "should initialize Connector and call #list" do
        expect_any_instance_of(MoreHoliday::Reader).to receive(:list)
        subject
      end
    end
  end
end
