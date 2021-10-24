#spec/caesar_cipher_spec.rb
require './lib/caesar_cipher'

describe "#shift_character" do
  it "returns the shifted uppercase letter" do
    expect(shift_character('A', 1)).to eql('B')
  end

  it "returns the shifted lowercase letter" do
    expect(shift_character('a', 1)).to eql('b')
  end
  
  it "returns shifted letter and loops past uppercase Z" do
    expect(shift_character('X', 4)).to eql('B')
  end
  it "returns shifted letter and loops past lowercase z" do
    expect(shift_character('x', 4)).to eql('b')
  end
end

describe '#caesar_cipher' do
  it "ciphers all lowercase letters" do
    expect(caesar_cipher('welcome', 2)).to eql('ygneqog')
  end

  it "ciphers all uppercase letters" do
    expect(caesar_cipher('WELCOME', 2)).to eql('YGNEQOG')
  end

  it "ciphers lowercase and uppercase letters" do
    expect(caesar_cipher('WeLcoMe', 2)).to eql('YgNeqOg')
  end
end