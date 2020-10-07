require "spec_helper"

describe('#People') do
  describe('.all') do
    it('returns a list of all books') do
      expect(People.all).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a person to the database') do
      person1 = People.new({name: 'JK Rowling', id: 4})
      person1.save
      expect(People.all).to(eq([person1]))
    end
  end

  describe('#delete') do
    it('deletes an author from the database') do
      people1 = People.new({name: 'JK Rowling', id:4})
      people1.save
      people1.delete()
      expect(People.all).to(eq([]))
    end
  end

  describe('.find') do
    it('finds a person by id') do
      person1 = People.new({name: 'JK Rowling', id: nil})
      person1.save
      person2 = People.new({name: 'Joe', id: nil})
      person2.save
      expect(People.find(person1.id)).to(eq(person1))
    end
  end

  describe('#update') do
    it('updates a person in the database') do
      person1 = People.new({name: 'JK Rowling', id:4})
      person1.save
      person1.update("Tim Jones")
      expect(person1.name).to(eq("Tim Jones"))
    end
  end
end