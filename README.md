# HasMeta

[![Gem Version](https://badge.fury.io/rb/has_meta.png)](http://badge.fury.io/rb/has_meta)

Adds convenience methods to extract "meta" (as in http meta) strings from
models by using existing fields or lambda/Procs for source data. Result is stripped of html
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
      has_meta :keywords => :keywords, 
               :description => [:short_description, :content],
               :foo => lambda {|o| o.some_instance_method }

      def some_instance_method
        Time.now
      end
    end

    bp = BlogPost.new(...)

    bp.meta_keywords == bp.meta_keywords

    # if short_description is not blank and less than 255 characters then
    bp.meta_description == bp.short_description

    # if short_description is blank then
    bp.meta_description == bp.content.slice(0,255)

    # blocks will be passed an instance of the object itself
    bp.meta_foo == "Feb 27, 4:36:00 PM" # for example
    sleep 1
    bp.meta_foo == "Feb 27, 4:36:01 PM" # one second later

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
