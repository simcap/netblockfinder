require 'ipaddress'

module Converter

  def self.address_boundaries(type, start, value = nil)
    if type == 'asn'
	  return [start.to_i, start.to_i] 
	elsif type == 'ipv4'
      start_num = IPAddress.parse(start).to_i 
	  end_num = (start_num + value.to_i - 1) 
	  return [start_num, end_num]
	elsif type == 'ipv6'  
      start_num = IPAddress.parse("#{start}/#{value}").network.to_i
	  end_num = IPAddress.parse("#{start}/#{value}").broadcast_u128
	  return [start_num, end_num]
	else
	  raise "Unknown type '#{type}' for conversion"
	end
  end

end

class Assignment
  
  attr_reader :start_num, :end_num, :num_type, :country_code, :source_type, :source_name

  def initialize(start_num, end_num, num_type, country, source_type, source_name)
  	@source_type, @source_name = source_type, source_name
  	@country_code = country
  	@num_type = num_type
  	@start_num = start_num
	@end_num = end_num
  end

end

class AssignmentLine

  attr_reader :source, :country_code, :type, :start, :value

  def initialize attributes
	@source = attributes['registry']
	@country_code = attributes['country_code']
	@type = attributes['type']
	@start = attributes['start']
	@value = attributes['value']
  end

  def invalid_line?
	country_code == '*' || source.delete('.') =~ /\d/
  end

  def to_assignment
	start_num, end_num = Converter.address_boundaries(type, start, value)
	Assignment.new start_num, end_num + 1, type, country_code, 'rir', source
  end

end


class RirParser

  KEYS = %w(registry country_code type start value date status)

  def self.from_file filepath
	new File.open(filepath).read
  end

  def initialize lines
	@lines = lines
  end

  def parse
	assignments = @lines.each_line.map do |line| 
	  next if line.start_with? '#'
	  assign = AssignmentLine.new Hash[KEYS.zip(line.chomp.split('|'))]
	end.compact.reject {|a| a.invalid_line?}.map(&:to_assignment)

	assignments.each do |a|
	  Repository.instance.insert a
	end

  end

end


