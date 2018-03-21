require "fileutils"

RSpec.describe MoreHoliday::Cache::File do
  def cache_base_path; ::File.join("tmp", "cache") end
  def test_path; ::File.join(cache_base_path, "rspec") end
  def test_file_path; ::File.join(test_path, "file") end

  let(:test_data) { ["Test", "Array"] }

  before(:each) do
    FileUtils.mkdir_p(test_path)
  end

  after(:each) do
    FileUtils.rm_rf(test_path)
  end

  describe "#read" do
    subject { described_class.new(file_name: "file", folder_path: "rspec").read }

    context "when file does not exist in cache" do
      it { is_expected.to be(nil) }
    end

    context "when file exist but is not valid anymore" do
      it {
        allow_any_instance_of(described_class).to receive(:still_valid?).and_return(false)
        is_expected.to be(nil)
      }
    end

    context "when file exist in cache" do
      it "should read content" do
        FileUtils.mkdir_p(test_path)
        File.write(test_file_path, test_data)
        is_expected.to eq(test_data)
      end
    end

    context "when file exist in cache and is not readable" do
      it do
        FileUtils.mkdir_p(test_path)
        File.write(test_file_path, "123IOI/)(")
        expect{ subject }.to raise_error(described_class::FileCacheReadError)
      end
    end
  end

  describe "#write" do
    subject { described_class.new(file_name: "file", folder_path: "rspec").write(test_data) }

    context "when data need to be written to cache" do
      it { is_expected.to be(true) }
    end
  end

  describe "#exist?" do
    subject { described_class.new(file_name: "file", folder_path: "rspec").exist? }

    context "when file exist in cache and is valid" do
      it do
        File.write(test_file_path, test_data)
        allow_any_instance_of(described_class).to receive(:still_valid?).and_return(true)
        is_expected.to be(true)
      end
    end

    context "when file exist in cache and is not valid anymore" do
      it do
        File.write(test_file_path, test_data)
        allow_any_instance_of(described_class).to receive(:still_valid?).and_return(false)
        is_expected.to be(false)
      end
    end

    context "when file does not exist in cache" do
      it { is_expected.to be(false) }
    end
  end

  describe "#resolve" do
    let(:resolve) { described_class.new(file_name: "file", folder_path: "rspec").resolve(Proc.new{test_data}) }

    context "when file doesn't exist" do
      it "should create file and return data" do
        expect_any_instance_of(described_class).not_to receive(:read)
        expect_any_instance_of(described_class).to receive(:write)
        expect_any_instance_of(described_class).to receive(:data)
        resolve
      end
    end

    context "when file does exist" do
      it "should read from file and return data" do
        expect_any_instance_of(described_class).to receive(:read)
        expect_any_instance_of(described_class).not_to receive(:write)
        expect_any_instance_of(described_class).not_to receive(:data)
        File.write(test_file_path, test_data)
        resolve
      end
    end
  end

  describe "#clear!" do
    subject { described_class.new(file_name: "file", folder_path: "rspec").clear! }

    context "when cache contains files and get successfully removed" do
      before(:each) { File.write(test_file_path, test_data) }
      it "should remove whole cache folder" do
        is_expected.to be(true)
        expect(File.exist?(test_file_path)).to be(false)
      end
    end
  end
end
