#encoding=UTF-8
require 'net/http'
require 'uri'
	puts ARGV.size

	if (ARGV[0].to_i < 1000) and  ARGV[1].to_i == 0
		puts ARGV[0]
	end

	puts ARGV[1]



	# http = Net::HTTP.new('www.cc98.org', 80)

	# cookie = 'ASPSESSIONIDSCSRCCSC=MGNCIBGAEEPGLIAAECLCLDDM; BoardList=BoardID=Show; aspsky=username=JvsDot&usercookies=3&userhidden=2&password=730d9f35de7ac538&userid=451804&useranony=; upNum=0; autoplay=True'

	# path = '/SaveReAnnounce.asp?method=fastreply&BoardID=135'

	# data = 'followup=4273435&RootID=4273435&star=4&UserName=JvsDot&passwd=730d9f35de7ac538&anony=1&Expression=face7.gif&Content=' + URI.escape('哈哈')+'&signflag=yes'

	# headers = {
	# 	'Content-Length' => '212',
	#   	'POST' => '/SaveReAnnounce.asp?method=fastreply&BoardID=135 HTTP/1.1',
	# 	'Host' =>  'www.cc98.org',
	# 	'Connection' => 'keep-alive',
	# 	'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
	# 	'Origin' => 'http://www.cc98.org',
	# 	'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.69 Safari/537.36',
	# 	'Content-Type' => 'application/x-www-form-urlencoded',
	# 	'Referer' => 'http://www.cc98.org/dispbbs.asp?boardid=182&id=4273243&star=5',
	# 	'Accept-Encoding' => 'gzip,deflate,sdch',
	# 	'Accept-Language' => 'zh-CN,zh;q=0.8',
	# 	'Cookie' => cookie
	# }

	# response = http.post(path, data,headers)

	# puts response.body