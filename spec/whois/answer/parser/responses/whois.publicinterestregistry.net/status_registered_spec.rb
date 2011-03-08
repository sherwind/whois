# encoding: utf-8

# This file is autogenerated. Do not edit it manually.
# If you want change the content of this file, edit
#
#   /spec/whois/answer/parser/responses/whois.publicinterestregistry.net/status_registered_spec.rb
#
# and regenerate the tests with the following rake task
#
#   $ rake genspec:parsers
#

require 'spec_helper'
require 'whois/answer/parser/whois.publicinterestregistry.net'

describe Whois::Answer::Parser::WhoisPublicinterestregistryNet, "status_registered.expected" do

  before(:each) do
    file = fixture("responses", "whois.publicinterestregistry.net/status_registered.txt")
    part = Whois::Answer::Part.new(:body => File.read(file))
    @parser = klass.new(part)
  end

  context "#response_throttled?" do
    it do
      @parser.response_throttled?.should == false
    end
  end
end
