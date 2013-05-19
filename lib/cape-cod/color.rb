# encoding: utf-8

module CapeCod
  class Color

    CODES = {
      black:    0,
      red:      1,
      green:    2,
      yellow:   3,
      blue:     4,
      magenta:  5,
      cyan:     6,
      white:    7,
    }.freeze

    def initialize(*color, ground)
      unless [:foreground, :background].include? ground
        raise ArgumentError, 'color must be either foreground or background.'
      end

      if color.empty? || color.size > 3 || color.size == 2
        raise ArgumentError,
                      "wrong number of arguments (#{color.size + 1} for 2|4)."
      elsif color.size == 3
        color = [(color[0] << 16) | (color[1] << 8) | color[2]]
      elsif color.first.is_a?(Integer) && color.first < 0
        raise ArgumentError, 'hex code must be positive.'
      elsif color.first.is_a?(Symbol) && !CODES.has_key?(color.first)
        raise ArgumentError, %(invalid color name "#{color.first}".)
      end

      @ground = ground
      @color  = color.first
    end

    def ansi_code
      case @color
      when Symbol  then code_from_name
      when Integer then code_from_hex
      end
    end

    def code_from_name
      CODES[@color].+(@ground == :foreground ? 30 : 40).to_s
    end

    def code_from_hex
      ground_code = @ground == :foreground ? 38 : 48
      color_code  = self.class.hex_to_ansi(@color)

      "#{ground_code};5;#{color_code}"
    end

    def self.hex_to_ansi(hex)
      (6 * ((hex >> 16 & 0xff) / 256.0)).to_i * 36 +
      (6 * ((hex >>  8 & 0xff) / 256.0)).to_i *  6 +
      (6 * ((hex       & 0xff) / 256.0)).to_i
    end
  end
end
