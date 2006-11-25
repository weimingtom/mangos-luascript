AM_CXXFLAGS = @COMPILER_OPTIONS@ @EXTRA_COMPILER_OPTIONS@

SUBDIRS = lua

INCLUDES += -I./../../../src/shared -I./../../../src/framework -I./../../../dep/include -I./ -I./lua/include -I./../../dep/include -I./lua/src -I./../../../src/mangosd -I./../../../src/game
pkglibdir = $(libdir)

lib_LTLIBRARIES = libMaNGOSScript.la

libMaNGOSScript_la_LIBADD=./lua/lib/liblua.a ./lua/lib/liblualib.a
libMaNGOSScript_la_LDFLAGS= -module -export-dynamic

libMaNGOSScript_la_SOURCES = \
LUA_Engine.cpp \
LUA_Player.cpp \
Lua_Creature.cpp \
Lua_Unit.cpp \
Lua_exports.cpp \
Lua_uint64.cpp \
ScriptMgr.cpp \
sc_defines.cpp \
system.cpp \
luabind/class.cpp \
luabind/class_info.cpp \
luabind/class_registry.cpp \
luabind/class_rep.cpp \
luabind/create_class.cpp \
luabind/error.cpp \
luabind/find_best_match.cpp \
luabind/function.cpp \
luabind/implicit_cast.cpp \
luabind/link_compatibility.cpp \
luabind/object_rep.cpp \
luabind/open.cpp \
luabind/overload_rep.cpp \
luabind/pcall.cpp \
luabind/ref.cpp \
luabind/scope.cpp \
luabind/stack_content_by_name.cpp \
luabind/weak_ref.cpp \
luabind/wrapper_base.cpp


