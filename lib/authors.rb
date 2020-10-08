class Author
  attr_accessor(:author)
  attr_reader(:id)

  def initialize(attributes)
    @author = attributes.fetch(:author)
    @id = attributes.fetch(:id)
  end

  def ==(author_to_compare)
    self.author() == author_to_compare.author()
  end

  def self.all
    returned_authors = DB.exec("SELECT * FROM authors;")
    authors = []
    returned_authors.each() do |item|
      author = item.fetch("author")
      id = item.fetch("id")
      authors.push(Author.new({:author => author, :id => id}))

    end
    authors
  end

  def save
    result = DB.exec("INSERT INTO authors (author) VALUES ('#{@author}') RETURNING id")
    @id = result.first().fetch("id").to_i
  end

  def delete()
    DB.exec("DELETE FROM authors WHERE id = #{@id};")
  end

  def self.find(id)
    returned_author = DB.exec("SELECT * FROM authors WHERE id = #{id};").first
    if returned_author
      author = returned_author.fetch('author')
      id = returned_author.fetch('id').to_i
      Author.new({ author: author, id: id })
    else
      nil
    end
  end

  def update(attributes)
    if (attributes.has_key?(:author)) && (attributes.fetch(:author) != nil)
      @author = attributes.fetch(:author)
      DB.exec("UPDATE authors SET author = '#{@author}' WHERE id = #{@id};")
    elsif (attributes.has_key?(:book)) && (attributes.fetch(:book) != nil)
      book_title = attributes.fetch(:book)
      book = DB.exec("SELECT * FROM books WHERE lower(title)='#{book_title.downcase}';").first
      if book != nil
        DB.exec("INSERT INTO authors_books (author_id, book_id) VALUES (#{@id}, #{book['id'].to_i});")
      end
    end
  end

  def books
    books = []
    results = DB.exec("SELECT book_id FROM authors_books WHERE author_id = #{@id};")
    results.each do |result|
      book_id = result.fetch('book_id').to_i
      book = DB.exec("SELECT * FROM books WHERE id = #{book_id};")
      title = book.first.fetch('title')
      author = book.first.fetch('author')
      books.push(Book.new({title: title, id: book_id, author: author}))
    end
    books
  end
end
