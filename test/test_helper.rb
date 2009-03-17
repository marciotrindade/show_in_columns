require 'rubygems'
require 'test/unit'
require 'active_support'
require 'action_view'
require 'active_support/test_case'
require 'shoulda'
require File.join(File.dirname(__FILE__),'..','init')

class ActiveSupport::TestCase
  def assert_equal_html(expected, actual)
    assert_equal(expected.gsub(/\n|\t|\s/, ''), actual.gsub(/\n|\t|\s/, ''))
  end
end

Someone = Struct.new(:name) # Hack ?