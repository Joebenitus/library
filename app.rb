require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('./lib/song')
require('pry')
also_reload('lib/**/*.rb')
require('pg')
require 'dotenv/load'

DB = PG.connect({:dbname => 'library', :password => ENV['PG_PASS']})