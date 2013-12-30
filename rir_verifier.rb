require 'digest'

class RirVerifier
  
  FILENAMES = %w(delegated-apnic-latest delegated-ripencc-latest) 

  def initialize dir_path
	@dir_path = dir_path
  end

  def verify
	FILENAMES.each do |f|
	  file_content = File.open(File.join @dir_path, "#{f}.md5").read
	  checksum = file_content.match(/([a-z0-9]{32})$/).captures.first
	  file_checksum = Digest::MD5.file(File.join(@dir_path, f)).hexdigest
	  raise "File '#{f}' has invalid checksum" if checksum != file_checksum
	end
	true
  end
end
