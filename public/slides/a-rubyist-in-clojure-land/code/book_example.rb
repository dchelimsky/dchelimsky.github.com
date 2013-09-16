def translate(text, lang)
  "Mundo de Maravilhas"
end


Book = Struct.new(:title, :author)
books = []
books << Book.new("World of Wonders", "Robertson Davies")
translated_books = books.each do |book|
 # book.title = translate(book.title, "Portuguese")
end

# meanwhile, in another part of the system ...
p books.first.title
# => "Mundo de Maravilhas"
