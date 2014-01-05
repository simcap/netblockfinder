require_relative '../repository'
require_relative '../rir_parser'

require 'ipaddress'

describe "Regional Internet Registry Parser" do

  let(:test_file_path) { File.join(File.dirname(__FILE__), "test_rir_data") }

  it "parses correct number of assignments from sample rir file" do
	results = RirParser.from_file(test_file_path).parse
	expect(Repository.instance.fetch_country_code 'ipv4', 'rir', IPAddress.parse('175.45.176.0').to_i).to  eq('KP')
	expect(Repository.instance.fetch_country_code 'ipv4', 'rir', IPAddress.parse('175.45.176.100').to_i).to  eq('KP')
	expect(Repository.instance.fetch_country_code 'ipv4', 'rir', IPAddress.parse('203.81.64.0').to_i).to  eq('MM')
	expect(Repository.instance.fetch_country_code 'ipv4', 'rir', IPAddress.parse('193.9.26.0').to_i).to  eq('HU')
	expect(Repository.instance.fetch_country_code 'ipv4', 'rir', IPAddress.parse('193.9.25.1').to_i).to  eq('PL')
	expect(Repository.instance.fetch_country_code 'ipv4', 'rir', IPAddress.parse('193.9.25.255').to_i).to  eq('PL')
  end	

end
