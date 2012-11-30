class Lexicon < ActiveRecord::Base
  attr_accessible :code, :dictionary, :ipd_def, :orig_word, :part_of_speech, :phonetic, :st_def, :tdnt, :translit, :word_orig
end
