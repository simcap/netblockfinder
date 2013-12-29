require_relative '../rir_parser'

describe "Regional Internet Registry Parser" do

  let(:test_file_path) { File.join(File.dirname(__FILE__), "test_rir_data") }

  it "parses sample rir file" do
	content = File.open(test_file_path)
	results = RirParser.new(content).parse
	expect(results.size).to eq(11)
	expect(results.first['registry']).to eq('apnic')
	expect(results.first['country_code']).to eq('JP')
	expect(results.last['registry']).to eq('ripencc')
  end	

  it "parses asn type" do
	line = StringIO.new("apnic|JP|asn|173|1|20020801|allocated")
	result = RirParser.new(line).parse
    expect(result.first['registry']).to eq('apnic')	
  end
end
