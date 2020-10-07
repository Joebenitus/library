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
  @authors = Author.all
  @patron = People.all
  erb(:main)
end

get('/new_book') do
  erb(:new_book)
end

post('/new_book') do
  title = params[:book_title]
  author = params[:book_author]
  book = Book.new({ title: title, author: author, id: nil })
  newauthor = Author.new({author: author, id: nil })
  book.save
  newauthor.save
  redirect to('/main')
end

post('/people') do
name = params[:person_name]
libraryuser = People.new({name: name, id: nil })
libraryuser.save()
redirect to ('/main')
end 

get('/book/:id') do
  @book = Book.find(params[:id].to_i())
  #@author_id = Author.find(params[])
  erb(:book)
end

get('/book/:id/edit') do
  erb(:book_edit)
end
