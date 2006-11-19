--This is the MasterScript

-- Simple printf function , it logs in Debug log-level
function printf(...) log_debug(string.format(unpack(arg))) end

-- this function is used for logging errors
function printf_error(...) log_error(string.format(unpack(arg))) end

--this includes file
function include(file)
    printf("Loading file : %s ", file )
	assert(loadfile(file))()
end

printf(" ")
printf("Loading the Mangos-Lua scripting library for MaNGOS Server by FreedomTeam")
printf(" ")
printf(" ")

-- Include Files ,for initializing the system
include ('LuaScript/defines.lua')
include ('LuaScript/ScriptMgr.lua')
include ('LuaScript/Callbacks.lua')

printf(" ")
printf("Loading scriptfiles  ... ")
printf(" ")
--
--
--Here you can include your script files :)  , have a look at sc_default.lua on info how to script
-- 
--
include ('LuaScript/example.lua')
include ('LuaScript/sc_default.lua')
include('LuaScript/guards/sc_guard_stormwind.lua')
