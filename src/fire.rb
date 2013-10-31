require './PostMachine.rb'
	#ARGV[0] is boardID, ARGV[1] is postID
	if (ARGV.size == 2 or ARGV.size == 3) and ARGV[0].to_i < 1000	
		tboard = TargetBoard.new(ARGV[0], ARGV[1], ARGV[1])
		cc98_post_machine = PostMachine.new('www.cc98.org', tboard, ARGV[2])
		cc98_post_machine.send_posts
	else
		puts 'Usage: ruby  $PATH/fire.rb  boardid  postid [speed]'
		puts '	#boardid and postid can be find in the url of certain post, and boardid is a number less than 1000'
		puts '	#speed is the time gap unit between two posts, it may be 10(s)'
	end