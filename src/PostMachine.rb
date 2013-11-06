#encoding=UTF-8
require 'net/http'
require 'yaml'
require 'uri'
require 'logger'

$LOG = Logger.new('log_file.log') 
$LOG.formatter = proc do |severity, datetime, progname, msg|
   "#{datetime}: #{msg}\n"
end


class TargetBoard
	def initialize(url)
		url = (url.split "?")[1]
		paras = url.split "&"
		@boardId = (paras[0].split "=")[1]
		@postId = (paras[1].split "=")[1]
	end
	
	attr_accessor:boardId, :postId

	def to_s
		@boardId + ' ' + @postId
	end
end


class PostMachine
	def initialize(url, tboard, sp = 10)
		@url, @target_board, @speed = url, tboard, sp.to_i

		@contents = IO.readlines("./comments.txt")
		@users = YAML.load(File.open("water_army.yml"))
		@users = shuffleArray @users['users']
	end

	def shuffleArray(arr)
		i = 0
		while i < arr.size do 
			r = rand(arr.size - i)
			tmp = arr[i]
			arr[i] = arr[i + r]
			arr[i + r] = tmp
			i += 1
		end
		arr
	end

	def sleep_time
		rand(@speed) + @speed
	end

	def send_posts
		count = 0
		ci = 0
		for user in @users
			if ci == @contents.size
				ci = 0
			end
			send_post user, @contents[ci]
			count += 1
			ci += 1
			puts '任务进度: ' + count.to_s + '/' + @users.size.to_s 

			sleep sleep_time
		end
		puts '任务完成!'
	end

	def send_post(user, content)
		http = Net::HTTP.new(@url, 80)

		cookie = 'ASPSESSIONIDSCSRCCSC=MGNCIBGAEEPGLIAAECLCLDDM; BoardList=BoardID=Show; aspsky=username=' + user['username'].to_s + '&usercookies=3&userhidden=2&password=' + user['password'].to_s + '&userid=' + user['userid'].to_s + '&useranony=; upNum=0; autoplay=True'
		path = '/SaveReAnnounce.asp?method=fastreply&BoardID=' + @target_board.boardId.to_s 
		data = 'followup=' + @target_board.postId.to_s + '&RootID=' + @target_board.postId.to_s + '&star=4&UserName=' + user['username'].to_s + '&passwd=' + user['password'].to_s + '&anony=1&Expression=face7.gif&Content=' + URI.escape(content)+'&signflag=yes'
		headers = {
			'Content-Length' => '212',
		  	'POST' => '/SaveReAnnounce.asp?method=fastreply&BoardID=182 HTTP/1.1',
			'Host' =>  'www.cc98.org',
			'Connection' => 'keep-alive',
			'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
			'Origin' => 'http://www.cc98.org',
			'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.69 Safari/537.36',
			'Content-Type' => 'application/x-www-form-urlencoded',
			'Referer' => 'http://www.cc98.org/dispbbs.asp?boardid=182&id=4273243&star=5',
			'Accept-Encoding' => 'gzip,deflate,sdch',
			'Accept-Language' => 'zh-CN,zh;q=0.8',
			'Cookie' => cookie
		}

		response = http.post(path, data,headers)

		$LOG.debug(response.body)
		# 如何判断是否成功？ 直接匹配字符串，有编码问题如何解决
		# if response.body.to_s.include? ''
		# 	puts user['username'] + ' 发送成功'
		# else
		# 	puts response.body
		# end
		
	end
end


if  ARGV.size != 1 && ARGV.size != 2
	puts 'Usage: $CC98POSTMACHINE/src/ruby  PostMachine.rb  POST_URL [SPEED].'
	puts '	#POST_URL is the url address of target post.'
	puts '	#SPEED is the time gap unit between two posts, it may be 1(s), 10(s) or any other number.'
else 

	tboard = TargetBoard.new(ARGV[0])
	if ARGV.size == 1
		cc98_post_machine = PostMachine.new('www.cc98.org', tboard, 1)
	else
		cc98_post_machine = PostMachine.new('www.cc98.org', tboard, ARGV[1])
	end
	cc98_post_machine.send_posts

end