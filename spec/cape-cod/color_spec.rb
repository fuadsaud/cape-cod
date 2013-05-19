# encoding: utf-8

require 'spec_helper'

describe CapeCod do
  describe CapeCod::Color do
    context 'when instantiated with valid args' do
      it 'produces proper color representation' do
        color_from_symbol = CapeCod::Color.new(:yellow, :foreground).ansi_code
        color_from_hex = CapeCod::Color.new(0xffff00, :foreground).ansi_code
        color_from_rgb = CapeCod::Color.new(255, 255, 0, :foreground).ansi_code

        expect(color_from_symbol).to eql '33'
        expect(color_from_hex).to eql '38;5;210'
        expect(color_from_rgb).to eql '38;5;210'
      end
    end

    context 'when instantiated with invalid args' do
      it 'fails initialization' do
        expect {
          CapeCod::Color.new(:not_a_color, :foreground).ansi_code
        }.to raise_error(ArgumentError)

        expect {
          CapeCod::Color.new(:yellow, :not_a_ground).ansi_code
        }.to raise_error(ArgumentError)

        expect {
          CapeCod::Color.new(155, 155, :foreground).ansi_code
        }.to raise_error(ArgumentError)
      end
    end
  end
end
