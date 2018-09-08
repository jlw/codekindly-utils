# frozen_string_literal: true

require 'spec_helper'

module CodeKindly
  RSpec.describe Utils do
    it 'has a version number' do
      expect(Utils::VERSION).not_to be nil
    end

    it 'is frozen' do
      expect(Utils::VERSION.frozen?).to be true
    end
  end
end
