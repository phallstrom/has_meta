# HasMeta

[![Gem Version](https://badge.fury.io/rb/has_meta.png)](http://badge.fury.io/rb/has_meta)

Adds convenience methods to extract "meta" (as in http meta) strings from
models by using existing fields or lambda/Procs for source data. Result is stripped of html
tags and truncated to length (default 255). If the meta is 'keywords' the result will take extra
steps to strip white space and remove blank elements (ie. multiple commas)

## Installation

Add this line to your application's Gemfile:

    gem 'has_meta'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install has_meta

## Configuration

By default has\_meta will truncate results at 255 characters.
You can change this globally by creating an initializer file with the following contents:

HasMeta::OPTIONS[:truncate] = 999

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

    bp.meta_keywords == bp.keywords

    # if short_description is not blank and less than 255 characters then
    bp.meta_description == bp.short_description

    # if short_description is blank then
    bp.meta_description == bp.content.slice(0,255)

    # blocks will be passed an instance of the object itself
    bp.meta_foo == "Feb 27, 4:36:00 PM" # for example
    sleep 1
    bp.meta_foo == "Feb 27, 4:36:01 PM" # one second later

    # 'keywords' gets extra special treatment.
    bp.short_description = ',one  two,  ,three, '
    bp.meta_description == ',one  two,  ,three, '

    bp.keywords = ',one  two,  ,three, '
    bp.meta_keywords == 'one,two,three'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
