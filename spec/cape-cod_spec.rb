# encoding: utf-8

require 'spec_helper'

describe CapeCod do
  it 'has a version' do
    expect(CapeCod::VERSION).to be_a(String)
  end

  it 'generates proper escape sequences' do
    expect(CapeCod.reset).to eq("\e[0m")
  end

  it 'has methods for all defined escape codes' do
    methods = CapeCod.instance_methods

    CapeCod::ESCAPE_CODES.each do |method, _|
      expect(methods).to include(method)
    end
  end

  context 'when using singleton method' do
    context 'no params given' do
      it 'returns the escape sequence' do
        expect(CapeCod.red).to eq("\e[31m")
      end
    end

    context 'when object param given' do
      it 'prepends the escape sequence and append a reset' do
        obj = ['foo', 10, :bar]
        expect(CapeCod.red(obj)).to eq("\e[31m#{obj.to_s}\e[0m")
      end
    end
  end

  context 'when using instance methods' do
    before { class String; include CapeCod end }

    let(:string) { 'foo bar baz'}

    it 'returns a new string with the proper escape codes applied' do

      expect(string.red).to not_eql(string)
      expect(string.red).to eql("\e[31mfoo bar baz\e[0m")
    end
  end
end
