# An adapter for the 'srx-english' gem, which segments
# texts into sentences based on a set of rules written
# by Marcin Milkowski.
#
# Original paper: Marcin Miłkowski, Jarosław Lipski, 
# 2009. Using SRX standard for sentence segmentation 
# in LanguageTool, in: Human Language Technologies 
# as a Challenge for Computer Science and Linguistics, 
# ed. by Zygmunt Vetulani, Poznań: Wydawnictwo Poznańskie, 
# Fundacja Uniwersytetu im. A. Mickiewicza, p. 556-560.
module Treat::Workers::Processors::Segmenters::SRX
  
  # Require the srx-english library.
  require 'srx-english'

  # Segment a text using the SRX algorithm
  def self.segment(entity, options = {})
    
    entity.check_hasnt_children
    text = entity.to_s
    escape_floats!(text)
    
    SRX::English::SentenceSplitter.new(text)
    
    @@segmenter.each do |sentence|
      unescape_floats!(sentence)
      entity << Treat::Entities::Phrase.
      from_string(sentence)
    end
    
    entity
    
  end

end