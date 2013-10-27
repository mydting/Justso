#!/usr/bin/env ruby
# encoding: utf-8
$LOAD_PATH.unshift('~/ruby/lib/')

require 'ftp'
require 'word_index'

list = Movielist.new
uri = URI.parse('ftp://ftp.hrbeu.edu.cn')

#Net::FTP.open(uri.host) do |ftp|
   # ftp.passive = true
   # ftp.login
   # puts "#{ftp.system}"
   # ftp.chdir("/影视/电影/高清".encode("gb2312"))
   # str = ftp.getdir()
   # str = str.force_encoding('gb2312')
   # str = str.encode('utf-8')
   # list.path = str
   # puts "当前目录为 :#{str}，存在以下文件："
   # puts '*'*60
   # ftp.nlst.each do |movie|
    #    str_movie = movie
    #    str_movie = str_movie.force_encoding('gb2312')
    #    str_movie = str_movie.encode("utf-8")
    #    puts str_movie
    #    list.name = str_movie
    #    list.createindex
    #end
    #ftp.close
#end

ftp = Net::FTP.open(uri.host)
ftp.passive = true
ftp.login
puts "*" * 60
puts "欢迎使用哈工程FTP开源搜索引擎"
puts "版本：0.1"
puts "作者：mydting"
puts "邮件：mydting@gmail.com"
puts "#当前服务器系统为：#{ftp.system}"
puts "*" * 60
puts "正在建立索引..."
ftp.chdir("/影视/电影/高清".encode("gb2312"))
list.index_currdir(ftp)
ftp.chdir("/影视/体育".encode("gb2312"))
list.index_currdir(ftp)
ftp.chdir("/影视/电影/精选全集".encode("gb2312"))
list.index_currdir(ftp)
ftp.chdir("/影视/电影/恐怖片".encode("gb2312"))
list.index_currdir(ftp)
ftp.chdir("/影视/电视剧/日韩".encode("gb2312"))
list.index_currdir(ftp)
ftp.close

ARGV.each { |key|
    puts "\033[33mSearching for #{key}...\033[m"
    puts "*" * 60
    list.moviesearch(key)
}
