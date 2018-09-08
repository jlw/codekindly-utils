# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CK do
  it 'is aliased from CodeKindly::Utils' do
    expect(CK::VERSION).to eq CodeKindly::Utils::VERSION
  end
end
