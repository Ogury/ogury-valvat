# frozen_string_literal: true

require 'spec_helper'

describe Valvat::Lookup::VIES::Request do
  it 'returns Response on success' do
    response = described_class.new('IE6388047V', {}).perform
    expect(response).to be_a(Valvat::Lookup::VIES::Response)

    # Skip if VIES is down
    expect(response.to_hash[:name]).to eql('GOOGLE IRELAND LIMITED') unless response.is_a?(Valvat::Lookup::VIES::Fault)
  end

  it 'returns Fault on failure' do
    response = described_class.new('XC123123', {}).perform
    expect(response).to be_a(Valvat::Lookup::VIES::Fault)
    expect(response.to_hash).to eql({ valid: false })
  end
end
