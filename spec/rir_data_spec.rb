require_relative '../rir_parser'

describe "Regional Internet Registry Parser" do

  let(:test_file_path) { File.join(File.dirname(__FILE__), "test_rir_data") }

  it "parses sample rir file" do
	content = File.open(test_file_path)
	results = RirParser.new(content).parse
	expect(results.size).to eq(11)
	expect(results.first.source).to eq('apnic')
	expect(results.first.country_code).to eq('JP')
	expect(results.last.source).to eq('ripencc')
  end	

  it "parses asn type" do
	line = 'apnic|JP|asn|173|1|20020801|allocated'
	result = RirParser.new(line).parse
    expect(result.first.source).to eq('apnic')	
    expect(result.first.country_code).to eq('JP')	
    expect(result.first.start_num).to eq(173)	
	expect(result.first.end_num).to eq(173)	
  end

  it "parses ipv4 type" do
	line = 'apnic|MM|ipv4|203.81.64.0|8192|20100504|assigned'
	result = RirParser.new(line).parse
    expect(result.first.source).to eq('apnic')	
    expect(result.first.country_code).to eq('MM')	
    expect(result.first.type).to eq('ipv4')	
	expect(result.first.start_num).to eq(3411099648)
	expect(result.first.end_num).to eq(3411107839)	
  end

  it "parses ipv6 type" do
	line = 'apnic|JP|ipv6|2001:200::|35|19990813|allocated'
	result = RirParser.new(line).parse
    expect(result.first.source).to eq('apnic')	
    expect(result.first.country_code).to eq('JP')	
    expect(result.first.type).to eq('ipv6')	
	expect(result.first.start_num).to eq(42540528726795050063891204319802818560)
	expect(result.first.end_num).to eq(42540528736698570378174246518995812351)	
  end

end
