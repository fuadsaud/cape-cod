# encoding: utf-8

$LOAD_PATH.unshift File.expand_path(
  File.join(File.dirname(__FILE__), '../lib'))

module CapeCod

  require 'cape-cod/version'
  require 'cape-cod/color'

  @enabled = STDOUT.tty?

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

  #
  # Define helper methods for applying the escape codes.
  #
  Color::CODES.each do |color, _|

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

      foreground(color, string)
    end

    define_singleton_method "on_#{color}" do |obj = ''|
      string = obj.to_s

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

      effect(effect, string)
    end
  end

  def foreground(color) # :nodoc:
    CapeCod.foreground(color, self)
  end

  def background(color) # :nodoc:
    CapeCod.background(color, self)
  end

  def effect(effect)    # :nodoc:
    CapeCod.effect(effect, self)
  end

  alias_method :fg, :foreground
  alias_method :bg, :background
  alias_method :fx, :effect

  class << self

    attr_accessor :enabled
    alias_method  :enabled?, :enabled

    def foreground(color, target) # :nodoc:
      apply_escape_sequence(color_code_for(color, :foreground), target)
    end

    def background(color, target) # :nodoc:
      apply_escape_sequence(color_code_for(color, :background), target)
    end

    def effect(effect, target) # :nodoc:
      apply_escape_sequence(effect_code_for(effect), target)
    end

    alias_method :fg, :foreground
    alias_method :bg, :background
    alias_method :fx, :effect

    protected

    #
    # Returns the ANSI escape sequence for the given +color+.
    #
    def color_code_for(color, ground)
      Color.new(color, ground).ansi_code
    end

    #
    # Returns the ANSI escape sequence for the given +effect+.
    #
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
    # Prepends the given +target+ with the ANSI escape sequence for the
    # given escape +code+. In case string is not empty, also appends a
    # reset sequence.
    #
    def apply_escape_sequence(code, target)
      return target unless self.enabled

      string = target.to_s

      escape_sequence_for(code).tap do |s|
        unless string.nil? || string.empty?
          s << string << escape_sequence_for(effect_code_for(:reset))
        end
      end
    end
  end
end
