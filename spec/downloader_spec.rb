require_relative '../downloader'
require 'fileutils'

describe 'Downloader', slow: true do

  let(:cache_dir_path) { File.join(Dir.home, ".netblockfinder") }

  before do
	FileUtils.remove_dir cache_dir_path if Dir.exists? cache_dir_path 
  end

  after do
	FileUtils.remove_dir cache_dir_path if Dir.exists? cache_dir_path 
  end

  it "creates cache dir if do not exists" do
	expect(Dir.exists? cache_dir_path).to_not be
	Downloader.new
	expect(Dir.new cache_dir_path).to be
  end

  it "download a rir file from url" do
	urls = ["ftp://ftp.arin.net/pub/stats/arin/delegated-arin-extended-latest"]
	Downloader.new.download urls
	expect(File.new File.join(cache_dir_path, "delegated-arin-extended-latest")).to be
  end
end
