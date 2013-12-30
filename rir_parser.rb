require 'ipaddress'

class Assignment

  attr_reader :source, :country_code, :type, :start, :value

  def initialize attributes
	@source = attributes['registry']
	@country_code = attributes['country_code']
	@type = attributes['type']
	@start = attributes['start']
	@value = attributes['value']
  end

  def start_num
	return start.to_i if type == 'asn'
	return IPAddress.parse(start).to_i if type == 'ipv4'
	return IPAddress.parse("#{start}/#{value}").network.to_i if type == 'ipv6'
  end

  def end_num
	return start.to_i if type == 'asn'
	return (start_num + value.to_i - 1) if type == 'ipv4'
	return IPAddress.parse("#{start}/#{value}").broadcast_u128 if type == 'ipv6'
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
	  assign = Assignment.new Hash[KEYS.zip(line.chomp.split('|'))]
	end.compact.reject {|a| a.invalid?}
  end

end


