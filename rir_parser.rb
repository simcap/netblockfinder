class Assignment

  attr_reader :source, :country_code

  def initialize attributes
	@source = attributes['registry']
	@country_code = attributes['country_code']
  end

  def invalid?
	country_code == '*' || source.delete('.') =~ /\d/
  end

end

class RirParser

  KEYS = %w(registry country_code type start value date status)

  def initialize lines
	@lines = lines
  end

  def parse
	@lines.each_line.map do |line| 
	  next if line.start_with? '#'
	  Assignment.new Hash[KEYS.zip(line.chomp.split('|'))]
	end.compact.reject {|a| a.invalid?}
  end

end


