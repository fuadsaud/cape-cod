# encoding: utf-8

require 'spec_helper'

describe CapeCod do
  describe CapeCod::Color do
    context 'instantiated with valid args' do
      context 'passed a three integer RGB representation' do
        it 'produces proper color representation' do
          expect(
            CapeCod::Color.new(255, 255, 0, :foreground).ansi_code
          ).to eql '38;5;210'
        end
      end

      context 'passed an RGB integer representation' do
        it 'produces proper color representation' do
          expect(
            CapeCod::Color.new(0xffff00, :foreground).ansi_code
          ).to eql '38;5;210'
        end
      end

      context 'passed a color name' do
        it 'produces proper color representation' do
          expect(
            CapeCod::Color.new(:yellow, :foreground).ansi_code
          ).to eql '33'
        end
      end
    end

    context 'instantiated with invalid args' do
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
