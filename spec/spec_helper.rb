
require "rspec"
require "pg"
require "books"
require "people"
require "authors"
require "pry"
require "dotenv/load"

DB = PG.connect({:dbname => "library_test", :password => ENV['PG_PASS']})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM books *;")
    DB.exec("DELETE FROM people *;")
    DB.exec("DELETE FROM authors *;")
  end
end
