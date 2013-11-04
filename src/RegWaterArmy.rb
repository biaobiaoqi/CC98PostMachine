#encoding=UTF-8
require 'digest/md5'
require 'net/http'
require 'uri'
require 'yaml'


class RegWaterArmy
	def initialize
		@url = "www.cc98.org"
	end

	def get_users
		accounts = IO.readlines("./pre_water_army.txt")
		accounts.each do |user|
			user = user.split " "
			uname = user[0]
			pwd = user[1]
			new_user = get_user uname, pwd

			users_yml = "water_army.yml"
			data = YAML.load(File.open(users_yml))

			is_new_user = true
			data["users"].each do | user|
				if user["username"] == new_user["username"]
					is_new_user = false
				end
			end

			if is_new_user
				data['users'] << new_user
			end

			File.open(users_yml, "w") {|f| YAML.dump(data, f)}
		end
	end

	def get_user(username, passwd)
		username = URI.escape(username)
		http = Net::HTTP.new(@url, 80)

		cookie = 'ASPSESSIONIDSCTTCDTC=GLIMCBJDCMIMLBLEMLPDBJHF; BoardList=BoardID=Show; autoplay=True; upNum=0'
		data = "a=i&u=" + username + "&p=" + Digest::MD5.hexdigest(passwd)+ "&userhidden=2"
		path = "/sign.asp"
		headers = {
			'Content-Length' => '71',
		  	'POST' => '/sign.asp HTTP/1.1',
			'Host' =>  'www.cc98.org',
			'Connection' => 'keep-alive',
			'Accept' => 'text/javascript, text/html, application/xml, text/xml, */*',
			'Origin' => 'http://www.cc98.org',
			'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.69 Safari/537.36',
			'Content-Type' => 'application/x-www-form-urlencoded; charset=UTF-8',
			'Referer' => 'http://www.cc98.org/login.asp',
			'Accept-Encoding' => 'gzip,deflate,sdch',
			'Accept-Language' => 'zh-CN,zh;q=0.8',
			'Cookie' => cookie,
			'X-Requested-With' => 'XMLHttpRequest'
		}

		response = http.post(path, data, headers)
		
		#get userid&password from cookie
		cookie = response['set-cookie']
		tmp = cookie.split ";"
		cookie = tmp[0]
		keys = cookie.split "&"
		userid = nil;
		password = nil;

		keys.each do |item|
			if item.include? "userid"
				items = item.split "="
				userid = items[1]
			end
			if item.include? "password"
				items = item.split "="
				password = items[1]
			end
		end

		{"username" => username, "userid" => userid, "password" => password}
	end
end


reg = RegWaterArmy.new

reg.get_users
