cape-cod
========

[![Gem Version](https://badge.fury.io/rb/cape-cod.png)]
               (http://badge.fury.io/rb/cape-cod)
[![Build Status](https://travis-ci.org/fuadsaud/cape-cod.png?branch=master)]
                (https://travis-ci.org/fuadsaud/cape-cod)
[![Code Climate](https://codeclimate.com/github/fuadsaud/cape-cod.png)]
                (https://codeclimate.com/github/fuadsaud/cape-cod)

cape-cod makes it easy for you to append ANSI es<strong>cape-cod</strong>es -
HAR! bet you didn't see that coming - to your strings.

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

```bundle install```

or simply:

```gem install cape-cod```

## Usage

```require 'cape-cod'```

You can include cape-cod in you String class:

    require 'cape-cod/string'

    class String
      include CapeCod::String
    end

    puts "OHAI".red

    puts 'This is BOLD'.bold

    puts 'and this is ITALIC'.fx(:italic) # You're not using this, right?

    puts 'Black n white'.fg(:black).on_white

    puts 'Magenta background'.bg(:magenta)

    puts 'ZOMG THERE'S RGB AS WELL' background'.bg(220, 112, 234).fg(0xa30fd4)

or use it like this:

    puts CapeCod.yellow('We all live in a yellow submarine!')

    puts CapeCod.fx :bold, 'BOOM!'

    puts CapeCod.fg(255, 0, 255, 'Super magenta!')

All the public instance methods are available as module methods.

## License

Please refer to [LICENSE.md](LICENSE.md).

## Contributing

Check the guidelines at [CONTRIBUTING.md](CONTRIBUTING.md).

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/fuadsaud/cape-cod/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
