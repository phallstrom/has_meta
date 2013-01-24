require 'rubygems'
require 'test/unit'
require 'active_support'
require 'active_model'
require 'action_controller'
require 'has_meta'

class Widget
  include ActiveModel::AttributeMethods
  include HasMeta::Extensions
  attr_accessor :short_description, :content, :keywords
  has_meta :description => [:short_description, :content], :keywords => :keywords
end

################################################################################


class HasMetaTest < Test::Unit::TestCase
  def setup
    @widget = Widget.new
    @widget.short_description = 'Short Description'
    @widget.content = 'Long Description'
    @widget.keywords = ''
  end

  def test_knows_its_meta_description
    assert_equal 'Short Description', @widget.meta_description
  end

  def test_knows_its_meta_description_when_first_option_blank
    @widget.short_description = nil
    assert_equal 'Long Description', @widget.meta_description
  end

  def test_knows_its_truncated_meta_description
    assert_equal 'Short...', @widget.meta_description(8)
  end

  def test_strip_tags
    @widget.short_description = "<i>ital</i> <b>bold</b> <a href='http://pjkh.com'>pjkh.com</a> the end"
    assert_equal 'ital bold pjkh.com the end', @widget.meta_description
  end

  def test_knows_its_meta_keywords
    assert_equal nil, @widget.meta_keywords
  end

end
