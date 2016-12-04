function GetServerTime()
	return os.time()
end

function GetClock()
	return os.clock()
end

function GetTime()
	return SocketHelp.gettime()
end


function Sleep(second)
   SocketHelp.select(nil, nil, second)
end