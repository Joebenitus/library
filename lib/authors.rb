class Author
  attr_accessor(:name)
  attr_reader(:id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end
end