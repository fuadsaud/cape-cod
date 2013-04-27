# encoding: utf-8

$LOAD_PATH.unshift File.expand_path(
  File.join(File.dirname(__FILE__), '../lib'))

module CapeCod

  require 'cape-cod/version'

  EFFECTS = {
    reset:         0,
    bold:          1,
    dark:          2,
    italic:        3,
    underline:     4,
    blink:         5,
    rapid_blink:   6,
    negative:      7,
    concealed:     8,
    strikethrough: 9
  }.freeze

  COLORS = {
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
  # Define helper methods for applying the escape codes.
  #
  COLORS.each do |color, _|

    #
    # Instance methods for background and foreground colors.
    #
    define_method color do
      CapeCod.foreground(color, self)
    end

    define_method "on_#{color}".to_s do
      CapeCod.background(color, self)
    end

    #
    # Singleton methods for background and foreground colors.
    #
    define_singleton_method color do |obj = ''|
      string = obj.to_s
      code = color_code_for(color, :foreground)

      return escape_sequence_for(code) if string.empty?

      foreground(color, string)
    end

    define_singleton_method "on_#{color}" do |obj = ''|
      string = obj.to_s
      code = color_code_for(color, :background)

      return escape_sequence_for(code) if string.empty?

      background(color, string)
    end
  end

  EFFECTS.each do |effect, _|

    #
    # Instance methods for effects.
    #
    define_method effect do
      CapeCod.effect(effect, self)
    end

    #
    # Singleton methods for effects.
    #
    define_singleton_method effect do |obj = ''|
      string = obj.to_s
      code = effect_code_for(effect)

      return escape_sequence_for(code) if string.empty?

      apply_escape_sequence(code, string)
    end
  end

  class << self
    def foreground(color, target)
      apply_escape_sequence(color_code_for(color, :foreground), target)
    end

    def background(color, target)
      apply_escape_sequence(color_code_for(color, :background), target)
    end

    def effect(effect, target)
      apply_escape_sequence(effect_code_for(effect), target)
    end

    alias_method :color, :foreground
    alias_method :fg,    :foreground
    alias_method :bg,    :background

    protected

    def color_code_for(color, ground)
      COLORS.fetch(color) + (ground == :foreground ? 30 : 40)
    end

    def effect_code_for(effect)
      EFFECTS.fetch(effect)
    end

    private

    #
    # Returns the ANSI escape sequence for a given escape +code+.
    #
    def escape_sequence_for(code)
      "\e[#{code}m"
    end

    #
    # Prepends the given +string+ with the ANSI escape sequence for the given
    # escape +code+ and append a reset sequence.
    #
    def apply_escape_sequence(code, string)
      sequence = escape_sequence_for(code)

      return sequence unless string

      sequence << string << escape_sequence_for(effect_code_for(:reset))
    end
  end
end
