class RirParser

  KEYS = %w(registry country_code type start value date status)

  def initialize content
	@content =  content
  end

  def parse
	@content.each_line.map do |line| 
	  next if line.start_with? '#'
	  assign = Hash[KEYS.zip(line.chomp.split('|'))]
	end.compact.reject {|a| a['country_code'] == '*' || a['registry'].delete('.') =~ /\d/}
  end

end


