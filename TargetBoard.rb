class TargetBoard
	def initialize(bid, fu, rid)
		@boardId, @followup, @RootID = bid, fu, rid
	end
	
	attr_accessor:boardId, :followup, :RootID

	def to_s
		@boardId + ' ' + @followup + ' ' + @RootID
	end
end