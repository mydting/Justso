# encoding: utf-8
require 'rubygems'
require 'rmmseg'
require 'rmmseg/ferret'

class Word_index

def initialize
    RMMSeg::Dictionary.load_dictionaries

    analyzer = RMMSeg::Ferret::Analyzer.new do |tokenizer|
        Ferret::Analysis::LowerCaseFilter.new(tokenizer)
    end

    @index = Ferret::Index::Index.new(:analyzer => analyzer)
end

def add_to_index(name, path)
    @index << {
        :name => name,
        :path => path
    }
end

def index_search(key)
    @index.search_each(%Q!name:"#{key}"!) do |id, score|
        puts "搜索路径为："
        puts "\"#{@index[id][:path]}\""
        puts "找到以下文件:"
        puts "\"#{@index[id][:name]}\"" 
        #puts "***  movie \"#{@index[id][:name]}\" in the dictory \"#{@index[id][:path]}\" was founded，with a score:#{score}"
        puts "*" * 60
    end
end
end
