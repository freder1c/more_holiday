RSpec.describe MoreHoliday::Connector do
  let(:file_path) { "path/to/file" }
  let(:initialize_without_file) { described_class.new("Berlin") }
  let(:initialize_with_file) { described_class.new("Berlin", file_path: file_path) }

  describe "#holidays" do
    context "when only state param is given" do
      it "should connect to third party provider" do
        expect_any_instance_of(described_class).to receive(:connect)
        expect_any_instance_of(MoreHoliday::Reader).not_to receive(:list)
        initialize_without_file.holidays
      end
    end

    context "when file path param is given" do
      it "should connect to file reader" do
        expect_any_instance_of(described_class).not_to receive(:connect)
        expect_any_instance_of(MoreHoliday::Reader).to receive(:list)
        initialize_with_file.holidays
      end
    end
  end

  describe "#connect" do
    subject{ expect(initialize_without_file.connect).to eq([]) }

    context "when data is already cached" do
      it "read data from cache" do
        allow_any_instance_of(MoreHoliday::Cache::File).to receive(:exist?).and_return(true)
        allow_any_instance_of(MoreHoliday::Cache::File).to receive(:read).and_return([])
        subject
      end
    end

    context "when data is not cached" do
      it "write data to cache" do
        allow_any_instance_of(MoreHoliday::Cache::File).to receive(:resolve).and_return([])
        subject
      end
    end
  end

  describe "#source" do
    context "when file_path param is given" do
      it "should return file as source" do
        expect(initialize_with_file.source).to eq("file")
      end
    end

    context "when only state param is given" do
      it "should return service source" do
        allow_any_instance_of(described_class).to receive(:country).and_return("de")
        stub_const("#{described_class}::SOURCE", "connector_source")
        expect(initialize_without_file.source).to eq("connector_source")
      end
    end

    context "when invalid state param is given" do
      it do
        allow_any_instance_of(described_class).to receive(:country).and_return("invalid")
        expect{ initialize_without_file.source }.to raise_error(described_class::NotProvidedError)
      end
    end
  end
end
