require 'net/http'
require 'uri/common'

class Lookup::Translation
  #def self.lookup(word)
  #  word = URI.escape(word)
  #  xml = Net::HTTP.get(URI("http://services.aonaware.com/DictService/DictService.asmx/DefineInDict?dictId=wn&word=#{word}"))
  #  hash = Hash.from_xml(xml)
  #  hash['WordDefinition']['Definitions']['Definition']['WordDefinition']
  #rescue Exception => e
  #  Rails.logger.error("Failed to retrieve definition for '#{word}'. #{e.message}")
  #end

  def self.lookup(word)
    lang = "fr"
    word = URI.escape(word)
    json_text = Net::HTTP.get(URI("http://translate.google.com/translate_a/t?client=t&text=#{word}&hl=en&sl=en&tl=#{lang}&multires=1&prev=btn&ssel=4&tsel=4&sc=1"))
    json_text.gsub!(/(,)+/, ',')
    json = JSON.parse(json_text)

    nouns_array = json[1][0]
    nouns = nouns_array[1] if nouns_array && nouns_array[0] == "noun" && nouns_array.length > 1
    nouns ||= []
    p nouns

    verbs_array = json[1][1]
    verbs = verbs_array[1] if verbs_array && verbs_array[0] == "verb" && verbs_array.length > 1
    verbs ||= []
    p verbs

    nouns + verbs

      #p json[1][0][1]
      #p json[1][1][1]
      #nouns = [1][0][1]
      #verbs = [1][1][1]

  rescue Exception => e
    Rails.logger.error("Failed to retrieve definition for '#{word}'. #{e.message}")
    p e.backtrace
  end

end