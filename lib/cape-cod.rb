# encoding: utf-8

module CapeCod
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

  require_relative 'cape-cod/version'
  require_relative 'cape-cod/color'

  #
  # Define helper methods for applying the escape codes.
  #
  class << self
    attr_accessor :enabled
    alias_method  :enabled?, :enabled

    Color::CODES.keys.each do |color|
      define_method color do |target = ''|
        CapeCod.foreground(color, target)
      end

      define_method "on_#{color}".to_s do |target = ''|
        CapeCod.background(color, target)
      end
    end

    EFFECTS.keys.each do |effect|
      define_method effect do |target = ''|
        CapeCod.effect(effect, target)
      end
    end

    def foreground(*color, target) # :nodoc:
      apply_escape_sequence(color_code_for(*color, :foreground), target)
    end

    def background(*color, target) # :nodoc:
      apply_escape_sequence(color_code_for(*color, :background), target)
    end

    def effect(effect, target) # :nodoc:
      apply_escape_sequence(effect_code_for(effect), target)
    end

    alias_method :fg, :foreground
    alias_method :bg, :background
    alias_method :fx, :effect

    private

    #
    # Returns the ANSI escape sequence for the given +color+.
    #
    def color_code_for(*color, ground)
      Color.new(*color, ground).ansi_code
    end

    #
    # Returns the ANSI escape sequence for the given +effect+.
    #
    def effect_code_for(effect)
      EFFECTS.fetch(effect)
    end

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
      return target unless self.enabled?

      string = target.to_s

      escape_sequence_for(code).tap do |s|
        unless string.nil? || string.empty?
          s << string << escape_sequence_for(effect_code_for(:reset))
        end
      end
    end

    def ensure_windows_dependencies
      if RbConfig::CONFIG['host_os'] =~ /mswin|mingw/
        require 'Win32/Console/ANSI'
      end
    rescue LoadError
      self.enabled = false
    end

    def ensure_environment_conditions
      self.enabled = ENV['TERM'] != 'dumb' && (STDOUT.tty? && STDERR.tty?)
    end
  end

  ensure_windows_dependencies
  ensure_environment_conditions
end
