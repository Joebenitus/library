class People
  attr_accessor(:name)
  attr_reader(:id)
  
  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_people = DB.exec("SELECT * FROM people;")
    allpeople = []
    returned_people.each() do |item|
      name = item.fetch("name")
      id = item.fetch("id").to_i
      allpeople.push(People.new({:name => name, :id => id}))
    end
    allpeople
  end

  def ==(people_to_compare)
    (self.name() == people_to_compare.name()) && (self.id() == people_to_compare.id())
  end

  def save
    result = DB.exec("INSERT INTO people (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def delete()
    DB.exec("DELETE FROM people WHERE id = #{@id};")
  end

  def self.find(id)
    returned_person = DB.exec("SELECT * FROM people WHERE id = #{id};").first
    if returned_person
      name = returned_person.fetch('name')
      id = returned_person.fetch('id').to_i
      People.new({ name: name, id: id })
    else
      nil
    end
  end

  def update(name)
    @name = name
    DB.exec("UPDATE people SET name = '#{@name}' WHERE id = #{@id};")
  end
end