# encoding: utf-8

require 'spec_helper'

describe CapeCod do
  it 'has a version' do
    expect(CapeCod::VERSION).to be_a(String)
  end

  it 'generates proper escape sequences' do
    expect(CapeCod.reset).to eq("\e[0m")
  end

  context 'when using singleton methods' do
    context 'no params given' do
      it 'returns the escape sequence' do
        expect(CapeCod.red).to    eq("\e[31m")
        expect(CapeCod.on_red).to eq("\e[41m")
        expect(CapeCod.bold).to   eq("\e[1m")
      end
    end

    context 'when object param given' do
      it 'prepends the escape sequence and append a reset' do
        obj = ['foo', 10, :bar]
        expect(CapeCod.red(obj)).to    eq("\e[31m#{obj.to_s}\e[0m")
        expect(CapeCod.on_red(obj)).to eq("\e[41m#{obj.to_s}\e[0m")
        expect(CapeCod.bold(obj)).to   eq("\e[1m#{obj.to_s}\e[0m")
      end
    end
  end

  context 'when using instance methods' do
    before { class String; include CapeCod end }

    let(:string) { 'foo bar baz' }

    it 'returns a new string with the proper escape codes applied' do

      expect(string.red).to_not eql(string)

      expect(string.red).to    eql("\e[31mfoo bar baz\e[0m")
      expect(string.on_red).to eql("\e[41mfoo bar baz\e[0m")
      expect(string.bold).to   eql("\e[1mfoo bar baz\e[0m")

      expect(string.red.on_yellow).to \
                                    eql("\e[43m\e[31mfoo bar baz\e[0m\e[0m")
      expect(string.red.on_yellow.bold).to \
                          eql("\e[1m\e[43m\e[31mfoo bar baz\e[0m\e[0m\e[0m")
    end
  end
end
