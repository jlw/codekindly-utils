# encoding: UTF-8
require 'spec_helper'

RSpec.describe CodeKindly::Utils do
  it "has a version number" do
    expect(CodeKindly::Utils::VERSION).not_to be nil
  end

  it "is frozen" do
    expect(CodeKindly::Utils::VERSION.frozen?).to be true
  end
end
