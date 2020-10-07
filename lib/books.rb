class Book
  attr_accessor(:title, :author)
  attr_reader(:id)
  def initialize(attributes)
    @author = attributes.fetch(:author)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end
end