class Player
    attr_reader :username, :token
	 def initialize(token)
	 	@token = token
	 end
	 def set_name(str)
	    @username = str
	 end
end