#--
# Ruby Whois
#
# An intelligent pure Ruby WHOIS client and parser.
#
# Copyright (c) 2009-2012 Simone Carletti <weppos@weppos.net>
#++


require 'whois/record/parser/base'


module Whois
  class Record
    class Parser

      # Parser for the whois.co.ug server.
      #
      # @note This parser is just a stub and provides only a few basic methods
      #   to check for domain availability and get domain status.
      #   Please consider to contribute implementing missing methods.
      # 
      # @see Whois::Record::Parser::Example
      #   The Example parser for the list of all available methods.
      #
      # @author Simone Carletti <weppos@weppos.net>
      # @author Moritz Heidkamp <moritz.heidkamp@bevuta.com>
      #
      class WhoisCoUg < Base

        property_supported :status do
          if content_for_scanner =~ /^Status:\s+(.+?)\n/
            case $1.downcase
            when 'active'
              :registered
            else
              Whois.bug!(ParserError, "Unknown status `#{$1}'.")
            end
          else
            :available
          end
        end

        property_supported :available? do
          !!(content_for_scanner =~ /^% No entries found for the selected source/)
        end

        property_supported :registered? do
          !available?
        end


        property_supported :created_on do
          if content_for_scanner =~ /Registered:\s+(.+)$/
            Time.parse($1)
          end
        end

        property_supported :updated_on do
          if content_for_scanner =~ /Updated:\s+(.+)$/
            DateTime.strptime($1, '%d/%m/%Y %H:%M:%S').to_time
          end
        end

        property_supported :expires_on do
          if content_for_scanner =~ /Expiry:\s(.+)$/
            Time.parse($1)
          end
        end


        property_supported :nameservers do
          content_for_scanner.scan(/Nameserver:\s+(.+)\n/).flatten.map do |name|
            Record::Nameserver.new(:name => name.downcase)
          end
        end

      end

    end
  end
end
