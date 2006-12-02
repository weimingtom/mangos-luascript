-- This is the MasterScript

-- Simple printf function
function printf(...) io.write(string.format(unpack(arg))) end

-- log in Debug log-level
function log(...) log_debug(string.format(unpack(arg))) end

-- this function is used for logging errors
function logerror(...) log_error(string.format(unpack(arg))) end

-- this includes file
function include(file)
	printf("LuaScript: Loading file : %s\n", file )
	assert(loadfile(file))()
end

printf("\n")
printf("Loading the Mangos-Lua scripting library for MaNGOS Server by the FreedomTeam...\n")
printf("\n")
printf("\n")
-- First load required libraries
printf("\n")
printf("LuaScript: Loading libraries...\n")
printf("\n")

include ('LuaScript/defines.lua')
include ('LuaScript/ScriptMgr.lua')
include ('LuaScript/AI.lua')
include ('LuaScript/CallBacks.lua')
-- Load the Mango Utility Libraries
include ('LuaScript/Mango.lua')	-- Mango object
include ('LuaScript/Mango/Mango.IO.lua')	-- Mango IO Library
include ('LuaScript/Mango/Mango.DataStore.lua')	-- Mango IO Library

-- Then load the scripts
printf("\n")
printf("LuaScript: Loading scripts...\n")
printf("\n")

--
--
--Here you can include your script files :)  , have a look at sc_default.lua on info how to script
-- 
--
include ('LuaScript: LuaScript/example.lua')
include ('LuaScript: LuaScript/sc_default.lua')
include ('LuaScript: LuaScript/guards/sc_guard_stormwind.lua')
include ('LuaScript: LuaScript/guards/sc_guard_undercity.lua')
include ('LuaScript: LuaScript/guards/sc_guard_orgrimmar.lua')



