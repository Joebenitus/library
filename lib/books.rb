class Book
  attr_accessor(:title, :author)
  attr_reader(:id)
  def initialize(attributes)
    @author = attributes.fetch(:author)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def ==(book_to_compare)
    (self.title() == book_to_compare.title()) && (self.author() == book_to_compare.author())
  end

  def self.all
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each() do |item|
      title = item.fetch("title")
      author = item.fetch("author")
      id = item.fetch("id")
      books.push(Book.new({:author => author, :title => title, :id => nil}))
    end
    books
  end

  def save
    result = DB.exec("INSERT INTO books (title,author) VALUES ('#{@title}', '#{@author}') RETURNING id")
    @id = result.first().fetch("id").to_i
  end

  def delete()
    DB.exec("DELETE FROM books WHERE id = #{@id};")
  end

  def self.find(id)
    returned_book = DB.exec("SELECT * FROM books WHERE id = #{id};").first
    if returned_book
      title = returned_book.fetch('title')
      author = returned_book.fetch('author')
      id = returned_book.fetch('id').to_i
      Book.new({ title: title, author: author, id: id })
    else
      nil
    end
  end

  def update(title)
    @title = title
    DB.exec("UPDATE books SET title = '#{@title}' WHERE id = #{@id};")
  end
end