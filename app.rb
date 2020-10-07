require('sinatra')
require('sinatra/reloader')
require('./lib/people')
require('./lib/authors')
require('./lib/books')
require('pry')
also_reload('lib/**/*.rb')
require('pg')
require 'dotenv/load'

DB = PG.connect({:dbname => 'library_test', :password => ENV['PG_PASS']})

get('/')do
  redirect to('/main')
end

get('/main')do
  @books = Book.all
  erb(:main)
end

get('/new_book') do
  erb(:new_book)
end

post('/new_book') do
  title = params[:book_title]
  author = params[:book_author]
  book = Book.new({ title: title, author: author, id: nil })
  book.save
  redirect to('/main')
end

get('people') do
  'what it does'
end
