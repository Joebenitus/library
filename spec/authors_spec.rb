require "spec_helper"

describe('#Authors') do
  describe('.all') do
    it('returns a list of all authors') do
      expect(Author.all).to(eq([]))
    end
  end

  describe('#==') do
    it('is equal if two author instances have the same attributes') do
      auth1 = Author.new({ author: 'J. R. R. Tolkien', id: 5})
      auth2 = Author.new({ author: 'J. R. R. Tolkien', id: 5})
      expect(auth1).to(eq(auth2))
    end
  end

  describe('#save') do
    it('saves an author to the database') do
      author1 = Author.new({author: 'JK Rowling', id:4})
      author1.save
      expect(Author.all).to(eq([author1]))
    end
  end

  describe('#delete') do
    it('deletes an author from the database') do
      author1 = Author.new({author: 'JK Rowling', id:4})
      author1.save
      author1.delete()
      expect(Author.all).to(eq([]))
    end
  end

  describe('.find') do
    it('finds a author by id') do
      author1 = Author.new({ author: 'J. R. R. Tolkien', id: 4})
      author1.save
      author2 = Author.new({author: 'Dr. Seuss', id: 3})
      author2.save
      expect(Author.find(author1.id)).to(eq(author1))
    end
  end

  describe('#update') do
    it('updates an author in the database') do
      author1 = Author.new({author: 'JK Rowling', id:4})
      author1.save
      author1.update("Tim Jones")
      expect(author1.author).to(eq("Tim Jones"))
    end
  end
end