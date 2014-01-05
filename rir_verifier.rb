require 'digest'

class RirVerifier
  
  FILENAMES = %w(delegated-apnic-latest delegated-ripencc-latest) 

  def initialize dir_path
	@dir_path = dir_path
  end

  def verify
	FILENAMES.each do |f|
	  raise "File '#{f}' has invalid checksum" if original_checksum(f) != file_checksum(f)
	end
	true
  end

  def original_checksum filename
	file_content = File.open(File.join @dir_path, "#{filename}.md5").read
	file_content.match(/([a-z0-9]{32})$/).captures.first
  end

  def file_checksum filename
	Digest::MD5.file(File.join @dir_path, filename).hexdigest
  end

end
