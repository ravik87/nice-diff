# Nice::Diff

Nice diff generates the tabular readable diff of two JSON or XML files. A file object reference to corresponding JSON or XML files needs to be passed along with the format type being expressed.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nice-diff'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nice-diff

## Usage

To use nice-diff you can

	require 'nice/diff'

Now you can pass reference to JSON or XML files

	obj = Nice::Diff.new("JSON", <file_reference_to_expected_json_file>, <file_reference_to_actual_json_file>).print
	obj.print

	obj = Nice::Diff.new("XML", <file_reference_to_expected_xml_file>, <file_reference_to_actual_xml_file>)
	obj.print

## Contributing

1. Fork it ( https://github.com/[my-github-username]/nice-diff/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
