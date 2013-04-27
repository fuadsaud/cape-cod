cape-cod
========

cape-cod makes it easy for you to append ANSI es<strong>CAPE-COD</strong>es - HAR! bet you didn't see
that coming; I know, I know, I'm a genius - to you strings.

### *Hey, but don't we have a plenty of gems that do exactly the same thing?*

**YES**. We can cite [colored](http://github.com/defunkt/colored) - by @defunkt -,
[colorize](http://github.com/fazibear/colorize) - by @fazibear -,
[term-ansicolor](http://github.com/flori/term-ansicolor), and so on...
They are really nice gems, and they solve the escape code problem in different manners
but they're all abandoned, some accumulating 3 years old issues.

My point with this gem is to implement many of the possible ways of appending ANSI escape
codes to strings (monkey patching, blocks, etc) and let the user choose whatever he likes.
I for instance prefer the colored's monkey patch approach, but for some people it
doesn't suit, so other options should be offered.

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

  puts 'Praise R'hlor, for the night is dark and full of terrors'.red
```

or use it like this:

```
  puts CapeCod.yellow('We all live in a yellow submarine!')
```


## Contributing

Check the guidelines at [CONTRIBUTING.md](CONTRIBUTING.md).

## License

Please refer to [LICENSE.md](LICENSE.md).
