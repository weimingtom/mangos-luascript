printf("LuaScript: Loading Mango DataStore library...\n")
-- Mango Input/Output Library
Mango.DataStore = {
	local m_DataStore = {}

	get = function (...)
		current_script ~= nil
		if (Mango.m_DataStore[string.format(unpack(arg))] == nil) then
			Mango.m_DataStore[string.format(unpack(arg))] = {}
		end

		return Mango.m_DataStore[string.format(unpack(arg))]		
	end

	clear = function (...)
		Mango.m_DataStore[string.format(unpack(arg))] = {}
	end	
	
}
printf("LuaScript: Loaded Mango DataStore library!\n")