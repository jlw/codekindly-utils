# encoding: UTF-8
require 'spec_helper'

RSpec.describe CodeKindly::Utils::Boolean do
  describe :from do
    it "knows truthy values" do
      [
        true,
        "true",
        "TrUe",
        "t",
        1,
        "1",
        "y",
        "YeS",
        "on"
      ].each do |value|
        expect( CodeKindly::Utils::Boolean.from(value) ).to be( true ), "for #{value.inspect} (#{value.class.name})"
      end
    end

    it "knows falsey values" do
      [
        false,
        "false",
        "FaLsE",
        "f",
        0,
        "0",
        "n",
        "No",
        "ofF"
      ].each do |value|
        expect( CodeKindly::Utils::Boolean.from(value) ).to be( false ), "for #{value.inspect} (#{value.class.name})"
      end
    end
  end
end
