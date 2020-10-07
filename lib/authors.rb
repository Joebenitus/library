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
      authors.push(Author.new({:author => author, :id => nil}))

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

  def update(author)
    @author = author
    DB.exec("UPDATE authors SET author = '#{@author}' WHERE id = #{@id};")
  end
end
