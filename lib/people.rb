class People
  attr_accessor(:name)
  attr_reader(:id)
  def initalize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end
end