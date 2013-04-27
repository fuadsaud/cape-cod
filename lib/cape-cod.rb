# encoding: utf-8

$LOAD_PATH.unshift File.expand_path(
  File.join(File.dirname(__FILE__), '../lib'))

module CapeCod

  require 'cape-cod/version'

  ESCAPE_CODES = {
    reset:          0,
    bold:           1,
    dark:           2,
    italic:         3,
    underline:      4,
    blink:          5,
    rapid_blink:    6,
    negative:       7,
    concealed:      8,
    strikethrough:  9,

    # Foreground color
    black:         30,
    red:           31,
    green:         32,
    yellow:        33,
    blue:          34,
    magenta:       35,
    cyan:          36,
    white:         37,

    # Background color
    on_black:      40,
    on_red:        41,
    on_green:      42,
    on_yellow:     43,
    on_blue:       44,
    on_magenta:    45,
    on_cyan:       46,
    on_white:      47,
  }.freeze

  ESCAPE_CODES.each do |code, _|
    define_method code do
      CapeCod.apply_escape_sequence(code, self)
    end

    define_singleton_method code do |string|
       CapeCod.apply_escape_sequence(code, string.to_s)
    end
  end

  private

  def self.escape_sequence_for(code)
    "\e[#{ESCAPE_CODES.fetch(code)}m"
  end

  def self.apply_escape_sequence(code, string)
    sequence = escape_sequence_for(code)

    return sequence unless string

    sequence << string << escape_sequence_for(:reset)
  end
end
