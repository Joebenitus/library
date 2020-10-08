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
  newauthor.update({book: book.title})
  redirect to('/main')
end

post('/people') do
name = params[:person_name]
libraryuser = People.new({name: name, id: nil })
libraryuser.save()
redirect to('/main')
end 

get('/book/:id') do
  @book = Book.find(params[:id].to_i())
  #@author_id = Author.find(params[])
  erb(:book)
end

get('/book/:id/edit') do
  @book = Book.find(params[:id].to_i())
  erb(:book_edit)
end

patch('/book/:id')do
  title = params[:book_title]
  @book = Book.find(params[:id].to_i())
  if title != ''
    @book.update(title)
  end
  redirect to('/main')
end

delete('/book/:id') do
  @book = Book.find(params[:id].to_i())
  @book.delete
  redirect to('/main')
end

get('/author/:id') do
  @author = Author.find(params[:id].to_i())
  @bookbyauthor = @author.books()
  erb(:author)
end

get('/user/:id') do
  @user = People.find(params[:id].to_i())
  erb(:user)
end

get('/author/:id/edit') do
  @author = Author.find(params[:id].to_i())
  erb(:author_edit)
end

patch('/author/:id')do
  name = params[:author_name]
  @author = Author.find(params[:id].to_i())
  if name != ''
    @author.update({:author => name})
  end
  redirect to('/main')
end