-- This files defines 'core' functions, extending the basic LUA engine
-- To emulate w*w's RunScript :)
function RunScript(script)
	loadstring (script)();
end
