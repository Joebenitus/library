require "spec_helper"

describe('#Book') do
  describe('.all') do
    it('returns a list of all books') do
      expect(Book.all).to(eq([]))
    end
  end

  describe('#==') do
    it('is equal if two book instances have the same attributes') do
      book1 = Book.new({ title: 'Lord of the Rings', author: 'J. R. R. Tolkien', id: 5})
      book2 = Book.new({ title: 'Lord of the Rings', author: 'J. R. R. Tolkien', id: 5})
      expect(book1).to(eq(book2))
    end
  end

  describe('#save') do
    it('saves a book to the database') do
      book1 = Book.new({ title: 'Lord of the Rings', author: 'J. R. R. Tolkien', id: 5})
      book1.save
      expect(Book.all).to(eq([book1]))
    end
  end

  describe('.find') do
    it('finds a book by id') do
      book1 = Book.new({ title: 'Lord of the Rings', author: 'J. R. R. Tolkien', id: nil})
      book1.save
      book2 = Book.new({ title: 'Green Eggs and Ham', author: 'Dr. Seuss', id: nil})
      book2.save
      expect(Book.find(book1.id)).to(eq(book1))
    end
  end

  describe('#delete') do
    it('deletes a book from the database') do
      book1 = Book.new({title: 'Harry Potter', author: 'JK Rowling', id: 4})
      book1.save
      book1.delete()
      expect(Book.all).to(eq([]))
    end
  end

  describe('#update') do
    it('updates a book in the database') do
      book1 = Book.new({title: 'harry potter', author: 'JK Rowling', id:4})
      book1.save
      book1.update('harry potter 2')
      expect(book1.title).to(eq("harry potter 2"))
    end
  end
end