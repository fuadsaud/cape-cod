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

  context 'when using singleton method' do
    context 'no params given' do
      it 'should return the escape sequence' do
        expect(CapeCod.red).to eq("\e[31m")
      end
    end

    context 'when object param given' do
      it 'should prepend the escape sequence and append a reset' do
        obj = ['foo', 10, :bar]
        expect(CapeCod.red(obj)).to eq("\e[31m#{obj.to_s}\e[0m")
      end
    end

    context 'when block given' do
      it 'should prepend the escape sequence and append a reset' do
        expect(CapeCod.red { 'some text' }).to eq("\e[31msome text\e[0m")
      end
    end

    context 'when object and block given' do
      it 'should concatenate them and apply proper sequences' do
        expect(CapeCod.red('some') { ' text' }).to eq("\e[31msome text\e[0m")
      end
    end
  end
end
