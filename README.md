cape-cod
========

[![Gem Version](https://badge.fury.io/rb/cape-cod.png)]
(http://badge.fury.io/rb/cape-cod)
[![Build Status](https://travis-ci.org/fuadsaud/cape-cod.png?branch=master)]
(https://travis-ci.org/fuadsaud/cape-cod)

cape-cod makes it easy for you to append ANSI es<strong>cape-cod</strong>es -
HAR! bet you didn't see that coming; I know, I know, I'm a genius - to your
strings.

### *Hey, but don't we have a plenty of gems that do exactly the same thing?*

**YES**. We can cite [colored](http://github.com/defunkt/colored),
[colorize](http://github.com/fazibear/colorize),
[term-ansicolor](http://github.com/flori/term-ansicolor),
[ANSI](http://github.com/rubyworks/ANSI) and so on...
They are really nice gems, and they solve the escape code problem in different
manners but they're all kind of abandoned, with a lot of lingering issues...

My point with this gem is to implement many of the possible ways of appending
ANSI escape codes to strings (monkey patching, blocks, etc) and let the user
choose whatever he likes. I for instance prefer the colored's monkey patch
approach, but for some people it doesn't suit, so other options should be
offered.

Please contribute!

## Installation

Add this line to your applications's gemfile:

```gem 'cape-cod'```

then run:

```bundle```

or simply:

```gem install cape-cod```

## Usage

```require 'cap-cod'```

You can include cape-cod in you String class:

```
class String; include CapeCod end

puts "Praise R'hlor, for the night is dark and full of terrors".red

puts 'This is BOLD'.bold

puts 'and this is ITALIC'.fx(:italic) # You should probably avoid italics :\

puts 'Black n white'.fg(:black).on_white

puts 'Magenta background'.bg(:magenta)
```

or use it like this:

```puts CapeCod.yellow('We all live in a yellow submarine!')```

All the public instance methods are available as module methods.

## Contributing

Check the guidelines at [CONTRIBUTING.md](CONTRIBUTING.md).

## License

Please refer to [LICENSE.md](LICENSE.md).
