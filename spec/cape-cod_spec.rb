# encoding: utf-8

require 'spec_helper'

describe CapeCod do
  it 'should have a version' do
    expect(CapeCod::VERSION).to be_a(String)
  end

  it 'should generate proper escape sequences' do
    expect(CapeCod.reset).to eq("\e[0m")
  end

  it 'should have methods for all defined escape codes' do
    methods = CapeCod.instance_methods

    CapeCod::ESCAPE_CODES.each do |method, _|
      expect(methods).to include(method)
    end
  end

  it %(should prepend the color code and append reset when string
       is given as param).squeeze(' ') do
    expect(CapeCod.red('some text')).to eq("\e[31msome text\e[0m")
  end
end
