require 'net/http'
require 'uri/common'

class Lookup::Definition
  def self.lookup(word)
    word = URI.escape(word)
    xml = Net::HTTP.get(URI("http://services.aonaware.com/DictService/DictService.asmx/DefineInDict?dictId=wn&word=#{word}"))
    hash = Hash.from_xml(xml)
    hash['WordDefinition']['Definitions']['Definition']['WordDefinition']
  rescue Exception => e
    Rails.logger.error("Failed to retrieve definition for '#{word}'. #{e.message}")
  end
end