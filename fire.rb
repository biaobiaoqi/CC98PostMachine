require './PostMachine.rb'

	tboard = TargetBoard.new('100', '4273163', '4273163')
	cc98_post_machine = PostMachine.new('www.cc98.org', tboard)
	cc98_post_machine.send_posts
