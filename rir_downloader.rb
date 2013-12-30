require 'open-uri'

class RirDownloader
  def initialize
	@cache_dir_path = File.join Dir.home, ".netblockfinder"
	Dir.mkdir(@cache_dir_path) unless Dir.exists? @cache_dir_path
  end

  def download urls
	urls.each do |url|
	  filename = url.split('/').last
	  content = open(url)
	  File.open File.join(@cache_dir_path, filename), 'w' do |f|
		f.write content
	  end
	end
  end
end
