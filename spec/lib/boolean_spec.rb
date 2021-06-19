# frozen_string_literal: true

require_relative '../spec_helper'

module CodeKindly
  module Utils
    RSpec.describe Boolean do
      describe :from do
        it 'knows truthy values' do
          [
            true,
            'true',
            'TrUe',
            't',
            1,
            '1',
            'y',
            'YeS',
            'on'
          ].each do |value|
            expect(Boolean.from(value)).to be(true), "for #{value.inspect} (#{value.class.name})"
            expect(Boolean.true?(value)).to be(true), "for #{value.inspect} (#{value.class.name})"
          end
        end

        it 'knows falsey values' do
          [
            false,
            'false',
            'FaLsE',
            'f',
            0,
            '0',
            'n',
            'No',
            'ofF'
          ].each do |value|
            expect(Boolean.from(value)).to be(false), "for #{value.inspect} (#{value.class.name})"
            expect(Boolean.false?(value)).to be(true), "for #{value.inspect} (#{value.class.name})"
          end
        end
      end
    end
  end
end
