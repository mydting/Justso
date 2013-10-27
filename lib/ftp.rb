# coding: utf-8
require 'net/ftp'
require 'uri'

class Movielist

    attr_writer :path, :name
    def initialize
        @index = Word_index.new
    end

    def index_currdir(ftp)
        str = ftp.getdir()
        str = str.force_encoding("gb2312")
        str = str.encode("utf-8")
        @path = str
        ftp.nlst.each do |movie|
            str_movie = movie
            str_movie = str_movie.force_encoding("gb2312")
            str_movie = str_movie.encode("utf-8")
            @name = str_movie
            @index.add_to_index(@name, @path)
         end
    end

    #def createindex
    #    @index.add_to_index(@name, @path)
    #end
    
    def moviesearch(key)
        @index.index_search(key)
    end 
end

