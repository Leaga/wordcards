require 'uri/common'

class Lookup::Example
  def self.lookup(word)
    word = URI.escape(word)
    example_text = ''
    Mechanize.new.get("http://sentence.yourdictionary.com/#{word}") do |page|
      example_text = page.search("ul.example li").text
    end

    sentences = example_text.gsub!(/\n/m, ' ').split(/\.|\?|!/)

    #Remove short sentences (if possible)
    long_sentences = sentences.clone.delete_if {|s| s.split(' ').length < 4}
    sentences = long_sentences if long_sentences.length > 1

    #Keep sentences that start with target word (if possible)
    straight_sentences = sentences.clone.keep_if {|s| (s =~ Regexp.new(word, Regexp::IGNORECASE)) == 0}
    sentences = straight_sentences if straight_sentences.length > 1

    sentences
  rescue Exception => e
    Rails.logger.error("Failed to retrieve example for '#{word}'. #{e.message}")
  end

end