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
      let(:obj) { ['foo', 10, :bar] }

      it 'prepends the escape sequence and append a reset' do

        expect(CapeCod.red(obj)).to    eq("\e[31m#{obj.to_s}\e[0m")
        expect(CapeCod.on_red(obj)).to eq("\e[41m#{obj.to_s}\e[0m")
        expect(CapeCod.bold(obj)).to   eq("\e[1m#{obj.to_s}\e[0m")
      end
    end
  end

  context 'when using instance methods' do
    before { class String; include CapeCod end }

    let(:string)    { 'foo bar baz' }
    let(:bold)      { "\e[1m#{string}\e[0m" }
    let(:red)       { "\e[31m#{string}\e[0m" }
    let(:on_yellow) { "\e[43m#{string}\e[0m" }
    let(:r_on_y)    { "\e[43m\e[31mfoo bar baz\e[0m\e[0m" }
    let(:r_on_y_b)  { "\e[1m\e[43m\e[31mfoo bar baz\e[0m\e[0m\e[0m" }


    it 'returns a new string with the proper escape codes applied' do

      expect(string.bold).to_not eql(string)

      expect(string.bold).to      eql(bold)
      expect(string.red).to       eql(red)
      expect(string.on_yellow).to eql(on_yellow)

      expect(string.effect(:bold)).to       eql(bold)
      expect(string.foreground(:red)).to    eql(red)
      expect(string.background(:yellow)).to eql(on_yellow)
      expect(string.fx(:bold)).to           eql(bold)
      expect(string.fg(:red)).to            eql(red)
      expect(string.bg(:yellow)).to         eql(on_yellow)

      expect(string.red.on_yellow).to eql(r_on_y)
      expect(string.fg(:red).bg(:yellow)).to eql(r_on_y)

      expect(string.red.on_yellow.bold).to eql(r_on_y_b)
      expect(string.fg(:red).bg(:yellow).effect(:bold)).to eql(r_on_y_b)
    end
  end
end
