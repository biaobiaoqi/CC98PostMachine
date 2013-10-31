require './PostMachine.rb'

	tboard = TargetBoard.new('182', '4273572', '4273572')
	cc98_post_machine = PostMachine.new('www.cc98.org', tboard)
	cc98_post_machine.send_posts
