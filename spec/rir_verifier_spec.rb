require_relative '../rir_verifier'

describe "Checksum Verifier" do

  it "returns true for dir with files with valid checksums" do
	verifier = RirVerifier.new(File.join(File.dirname(__FILE__), "data", "valid_checksums"))
	expect(verifier.verify).to be
  end

  it "raise errors for dir with files with invalid checksums" do
	verifier = RirVerifier.new(File.join(File.dirname(__FILE__), "data", "invalid_checksums"))
	expect{verifier.verify}.to raise_error(/delegated-ripencc-latest/)
  end

end
