require "nokogiri"
io = File.open(File.expand_path('../../public/raw_bibles/kjvgenesis.xml', __FILE__))
doc = Nokogiri::XML(io)
io.close

doc.css("div[type='book']").each_with_index do |book, index|
  b = Book.find_by_ordinal(index)
  b.update_attributes osis: book["osisID"]
end

#doc.css("verse").each do |verse|
#  if verse["osisID"]
#    osis = verse["osisID"].split(".")
#    book_permalink = osis.first
#    chapter_number = osis[1]
#    verse_number = osis.last
#    verse_body = verse.to_s
#  
#    puts "#{book_permalink} #{chapter_number}:#{verse_number} - #{verse_body}"
#  end
#end