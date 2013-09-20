# encoding: utf-8

module CapeCod
  class Color

    #
    # The ANSI color codes.
    #
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

    #
    # Initializes a the color.
    #
    # +color+ may be either a single Integer representation of a RGB
    # color, a Symbol with the color name (valid color names are listed
    # in the COLORS hash), or three integers representing the RGB channels.
    # +ground+ is either :background or :foreground.
    #
    def initialize(*color, ground)
      with_valid_color_and_ground *color, ground do |*c, g|
        if c.size == 3
          c = [(c[0] << 16) | (c[1] << 8) | c[2]]
        end

        @ground = ground
        @color  = c.first
      end
    end

    #
    # Returns a string representing the ANSI escape code for this color.
    #
    def ansi_code
      case @color
      when Symbol  then code_from_name
      when Integer then code_from_hex
      end
    end

    private

    def code_from_name
      CODES[@color].+(@ground == :foreground ? 30 : 40).to_s
    end

    def code_from_hex
      ground_code = @ground == :foreground ? 38 : 48
      color_code  = self.class.hex_to_ansi(@color)

      "#{ground_code};5;#{color_code}"
    end

    #
    # Returns the ANSI domain code for the given RGB color packed
    # into an Integer.
    #
    def self.hex_to_ansi(hex)
      (6 * ((hex >> 16 & 0xff).quo(256))).to_i * 36 +
      (6 * ((hex >>  8 & 0xff).quo(256))).to_i *  6 +
      (6 * ((hex       & 0xff).quo(256))).to_i
    end

    def with_valid_color_and_ground(*color, ground)
      validate_color!(*color) and
        validate_ground!(ground) and yield *color, ground
    end

    def validate_color!(*color)
      if color.empty? || color.size > 3 || color.size == 2
        fail ArgumentError,
              "wrong number of arguments (#{color.size + 1} for 2|4)."
      elsif color.first.is_a?(Integer) && color.first < 0
        fail ArgumentError, 'hex code must be positive.'
      elsif color.first.is_a?(Symbol) && !CODES.has_key?(color.first)
        fail ArgumentError, %(invalid color name "#{color.first}".)
      else
        color
      end
    end

    def validate_ground!(ground)
      if [:foreground, :background].include? ground
        ground
      else
        fail ArgumentError, 'ground must be either foreground or background.'
      end
    end
  end
end
