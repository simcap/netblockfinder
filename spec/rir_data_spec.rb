class RirParser

  KEYS = %w(registry country_code type start value date status)

  def initialize filename
	@content = File.open(filename).read
  end

  def parse
	@content.each_line.map do |line| 
	  assign = Hash[KEYS.zip(line.chomp.split('|'))]
	end.reject {|a| a['country_code'] == '*' || a['registry'].delete('.') =~ /\d/}
  end


end
describe "Regional Internet Registry Parser" do
  it "parses sample rir file" do
	results = RirParser.new("test_rir_data").parse
	expect(results.size).to eq(11)
	expect(results[0]['registry']).to eq('apnic')
  end	
end
