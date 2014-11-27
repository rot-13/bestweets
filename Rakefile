require 'coffee-script'
require 'sass'

namespace :js do

  desc "compile coffee-scripts from ./src/coffee to ./public/javascripts"
  task :compile do
    source = "#{File.dirname(__FILE__)}/src/coffee/"
    javascripts = "#{File.dirname(__FILE__)}/public/javascripts/"

    Dir.foreach(source) do |cf|
      unless cf == '.' || cf == '..'
        js = CoffeeScript.compile File.read("#{source}#{cf}")
        open "#{javascripts}#{cf.gsub('.coffee', '.js')}", 'w' do |f|
          f.puts js
        end
      end
    end
  end

end

namespace :css do

  desc "compile sass from ./src/sass to ./public/stylesheets"
  task :compile do
    source = "#{File.dirname(__FILE__)}/src/sass/"
    stylesheets = "#{File.dirname(__FILE__)}/public/stylesheets/"

    Dir.foreach(source) do |cf|
      unless cf == '.' || cf == '..'
        css = Sass::Engine.new(File.read("#{source}#{cf}")).render
        open "#{stylesheets}#{cf.gsub('.sass', '.css')}", 'w' do |f|
          f.puts css
        end
      end
    end
  end

end

task js: ['js:compile']
task css: ['css:compile']
task default: [:css, :js]
