# HasMeta

[![Gem Version](https://badge.fury.io/rb/has_meta.png)](http://badge.fury.io/rb/has_meta)

Adds convenience methods to extract "meta" (as in http meta) strings from
models by using existing fields for source data. Strings are stripped of html
tags and truncated to length (default 255).

## Installation

Add this line to your application's Gemfile:

    gem 'has_meta'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install has_meta

## Usage

    class BlogPost < ActiveRecord::Base
      has_meta :keywords => :keywords, :description => [:short_description, :content]
    end

    bp = BlogPost.new(...)

    bp.meta_keywords == bp.meta_keywords

    # if short_description is not blank and less than 255 characters then
    bp.meta_description == bp.short_description

    # if short_description is blank then
    bp.meta_description == bp.content.slice(0,255)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
