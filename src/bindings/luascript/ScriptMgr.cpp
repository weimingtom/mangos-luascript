/* 
 * Copyright (C) 2005,2006 MaNGOS <http://www.mangosproject.org/>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#include "config.h"
#include "ScriptMgr.h"
#include "TargetedMovementGenerator.h"
#include "luainc.h"
#include "Player.h"
#include "GameObject.h"
#include "SharedDefines.h"
#include "GossipDef.h"
#include "QuestDef.h"
#include "WorldSession.h"
#include "CreatureAI.h"
#include "LUA_Engine.h"
#include "LUA_Player.h"
#include "Lua_Unit.h"
#include "Lua_uint64.h"
#include "Lua_Creature.h"
#include "Lua_exports.h"
#include "Lua_AI.h"

lua_State *LuaVM = NULL;

int LUA_CheckStatus (int status)
{
  if(!LuaVM) return 0;
  if (status) {
	// LUA Error
	const char *msg = lua_tostring(LuaVM, -1);
	if (msg == NULL) msg = "(error with no message)";
	fprintf(stderr, "LUA ERROR: %s\n", msg);
	lua_pop(LuaVM, 1);
  }
  return status;
}

MANGOS_DLL_EXPORT
void ScriptsFree()
{                                                           // Free resources before library unload
	// Destroy LuaVM
	if (LuaVM){
		try {
		unload_ALLAIs();
        luabind::call_function<void>(LuaVM, "ScriptsFree" ); //Call Scripts free function for probably some dealocation
			} catch(luabind::error&) { } 
		lua_setgcthreshold(LuaVM, 0);  // Collect Garbage
		lua_close(LuaVM); // Close it
		LuaVM = NULL;
	}
}


int lb_init(lua_State* L)
{
    using namespace luabind;

    open(L);

	lb_export_Engine(L);
	//Classes
	lb_Export_uint64(L);
	lb_Export_Misc(L);
	lb_Export_Unit(L);
	lb_Export_Player(L);
	lb_Export_Creature(L);
	lb_Export_AI(L);
	
    return 0;
}

int lua_at_panic(lua_State *L)
	{
	// Destroy LuaVM
	if (LuaVM) {
		//we can not call scripts free function as luaVM is gone :(
		lua_setgcthreshold(LuaVM, 0);  // Collect Garbage
		lua_close(LuaVM); // Close it
		LuaVM = NULL;
	}

error_log("[LUA] Panic in Lua , please reloadscripts or restart server"); 

throw std::runtime_error("Luabind panic error");
	}

MANGOS_DLL_EXPORT
void ScriptsInit()
{
	// Load LUA
	LuaVM = lua_open();

	 //Load the libraries
	luaopen_base(LuaVM);
	luaopen_table(LuaVM);
	luaopen_io(LuaVM);
	luaopen_string(LuaVM);
	luaopen_math(LuaVM);
	luaopen_debug(LuaVM);

	lua_atpanic (LuaVM, (lua_CFunction )&lua_at_panic);

    lb_init(LuaVM);
    
    // -- Load the Masterscript --
	if (LUA_CheckStatus(luaL_loadfile(LuaVM, "Masterscript.lua") || lua_pcall(LuaVM, 0, 0, 0))){
		ScriptsFree(); // Error - Fail, but cleanup! =(
		return;
	}

load_AllAIs();  //going to reload all loaded AI`s if there are any at all
}

MANGOS_DLL_EXPORT
bool GossipHello ( Player * player, Creature *_Creature )
{
ML_TRY
if(!*_Creature->GetCreatureInfo()->ScriptName) return false;
   
   player->PlayerTalkClass->ClearMenus();

if(LuaVM)
   return ( luabind::call_function<int>(LuaVM, "GossipHello",
                                                                        boost::ref<Player>(*player),
																		boost::ref<Creature>(*_Creature)
																		) != -1);

ML_CATCH

return false;
}

MANGOS_DLL_EXPORT
bool GossipSelect( Player *player, Creature *_Creature,uint32 sender, uint32 action )
{
ML_TRY
if(!*_Creature->GetCreatureInfo()->ScriptName) return false;

    player->PlayerTalkClass->ClearMenus();

if(LuaVM)
   return ( luabind::call_function<int>(LuaVM, "GossipSelect", 
                                                                         boost::ref<Player>(*player),
																		 boost::ref<Creature>(*_Creature) ,
																		 sender,
																		 action 
																		 )  !=  -1);

ML_CATCH

return false;
}

MANGOS_DLL_EXPORT
bool GossipSelectWithCode( Player *player, Creature *_Creature, uint32 sender, uint32 action, char* sCode )
{
ML_TRY
if(!*_Creature->GetCreatureInfo()->ScriptName) return false;

    player->PlayerTalkClass->ClearMenus();

if(LuaVM)
   return ( luabind::call_function<int>(LuaVM, "GossipSelectWithCode", 
                                                                          boost::ref<Player>(*player), 
                                                                          boost::ref<Creature>(*_Creature) ,
																		  sender, 
																		  action,
																		  sCode
																		  ) != -1);

ML_CATCH

return false;
}

MANGOS_DLL_EXPORT
bool QuestAccept( Player *player, Creature *_Creature, Quest *_Quest )
{
ML_TRY
if(!*_Creature->GetCreatureInfo()->ScriptName) return false;

    player->PlayerTalkClass->ClearMenus();

if(LuaVM)
return ( luabind::call_function<int>(LuaVM, "QuestAccept",
		                                                              boost::ref<Player>(*player), 
		                                                              boost::ref<Creature>(*_Creature) ,
						                							  boost::ref<Quest>(*_Quest)  
											                          ) !=  -1);

ML_CATCH

return false;
}

MANGOS_DLL_EXPORT
bool QuestSelect( Player *player, Creature *_Creature, Quest *_Quest )
{
ML_TRY
if(!*_Creature->GetCreatureInfo()->ScriptName) return false;

    player->PlayerTalkClass->ClearMenus();

if(LuaVM)
   return ( luabind::call_function<int>(LuaVM, "QuestSelect", 
                                                       boost::ref<Player>(*player),
													   boost::ref<Creature>(*_Creature),
													   boost::ref<Quest>(*_Quest) 
													   ) != -1);

ML_CATCH

return false;
}

MANGOS_DLL_EXPORT
bool QuestComplete( Player *player, Creature *_Creature, Quest *_Quest )
{
ML_TRY
if(!*_Creature->GetCreatureInfo()->ScriptName) return false;

    player->PlayerTalkClass->ClearMenus();

if(LuaVM)
   return ( luabind::call_function<int>(LuaVM, "QuestComplete", 
                                                       boost::ref<Player>(*player),
													   boost::ref<Creature>(*_Creature),
													   boost::ref<Quest>(*_Quest) 
													   ) != -1);

ML_CATCH

return false;
}

MANGOS_DLL_EXPORT
bool ChooseReward( Player *player, Creature *_Creature, Quest *_Quest, uint32 opt )
{
ML_TRY
if(!*_Creature->GetCreatureInfo()->ScriptName) return false;

    player->PlayerTalkClass->ClearMenus();

if(LuaVM)
   return ( luabind::call_function<int>(LuaVM, "ChooseReward", 
                                                       boost::ref<Player>(*player),
													   boost::ref<Creature>(*_Creature),
													   boost::ref<Quest>(*_Quest) ,
													   opt 
													   ) != -1);

ML_CATCH

return false;
}

MANGOS_DLL_EXPORT
uint32 NPCDialogStatus( Player *player, Creature *_Creature )
{
ML_TRY
if(!*_Creature->GetCreatureInfo()->ScriptName) return 100;

    player->PlayerTalkClass->ClearMenus();

if(LuaVM)
   return  luabind::call_function<uint32>(LuaVM, "NPCDialogStatus",
                                                               boost::ref<Player>(*player), 
															   boost::ref<Creature>(*_Creature)) ;

ML_CATCH

return 100;
}

MANGOS_DLL_EXPORT
bool ItemHello( Player *player, Item *_Item, Quest *_Quest )
{
ML_TRY
if(!*_Item->GetProto()->ScriptName) return false;

    player->PlayerTalkClass->ClearMenus();

if(LuaVM)
   return ( luabind::call_function<int>(LuaVM, "ItemHello",
                                                               boost::ref<Player>(*player), 
															   boost::ref<Item>(*_Item) ,
															   boost::ref<Quest>(*_Quest)
															   ) != -1);

ML_CATCH

return false;
}

MANGOS_DLL_EXPORT
bool ItemQuestAccept( Player *player, Item *_Item, Quest *_Quest )
{
ML_TRY
if(!*_Item->GetProto()->ScriptName) return false;

    player->PlayerTalkClass->ClearMenus();

if(LuaVM)
   return ( luabind::call_function<int>(LuaVM, "ItemQuestAccept",
                                                               boost::ref<Player>(*player), 
															   boost::ref<Item>(*_Item) ,
															   boost::ref<Quest>(*_Quest)
															   ) != -1);

ML_CATCH

return false;
}

MANGOS_DLL_EXPORT
bool GOHello( Player *player, GameObject *_GO )
{
ML_TRY
if(!*_GO->GetGOInfo()->ScriptName) return false;

    player->PlayerTalkClass->ClearMenus();

if(LuaVM)
   return ( luabind::call_function<int>(LuaVM, "GOHello",
                                                               boost::ref<Player>(*player), 
															   boost::ref<GameObject>(*_GO) 
															   ) != -1);

ML_CATCH

return false;
}

MANGOS_DLL_EXPORT
bool GOQuestAccept( Player *player, GameObject *_GO, Quest *_Quest )
{
ML_TRY
if(!*_GO->GetGOInfo()->ScriptName) return false;

    player->PlayerTalkClass->ClearMenus();

if(LuaVM)
   return ( luabind::call_function<int>(LuaVM, "GOQuestAccept",
                                                               boost::ref<Player>(*player), 
															   boost::ref<GameObject>(*_GO) ,
															   boost::ref<Quest>(*_Quest)
															   ) != -1);

ML_CATCH

return false;
}

MANGOS_DLL_EXPORT
bool GOChooseReward( Player *player, GameObject *_GO, Quest *_Quest, uint32 opt )
{
ML_TRY
if(!*_GO->GetGOInfo()->ScriptName) return false;

    player->PlayerTalkClass->ClearMenus();

if(LuaVM)
   return ( luabind::call_function<int>(LuaVM, "GOChooseReward",
                                                               boost::ref<Player>(*player), 
															   boost::ref<GameObject>(*_GO) ,
															   boost::ref<Quest>(*_Quest),
															   opt
															   ) != -1);

ML_CATCH

return false;
}

MANGOS_DLL_EXPORT
bool AreaTrigger( Player *player, Quest *_Quest, uint32 triggerID )
{
ML_TRY

    player->PlayerTalkClass->ClearMenus();

if(LuaVM)
   return ( luabind::call_function<int>(LuaVM, "AreaTrigger",
                                                               boost::ref<Player>(*player), 
															   boost::ref<Quest>(*_Quest),
															   triggerID
															   ) != -1);

ML_CATCH

return false;
}

MANGOS_DLL_EXPORT
CreatureAI* GetAI(Creature *_Creature )
{
ML_TRY

if(!*_Creature->GetCreatureInfo()->ScriptName) return NULL;

if(!LuaVM) return NULL;

if( luabind::call_function<int>(LuaVM, "HasAI" , boost::ref<Creature>(*_Creature) ) == 0 ) return NULL;

luabind::adl::object start_state = luabind::call_function<luabind::adl::object>(LuaVM, 
																				                                                               "GetAI" , 
																																			   boost::ref<Creature>(*_Creature) 
																																			   );
if( !IsValidLuaAIState(start_state) ) return NULL;

LuaAI* ai = new LuaAI(_Creature);
ai->SetCurrentState(start_state);

luabind::adl::object ob = start_state["Init"]; 

luabind::call_function<void>(ob,boost::ref<LuaAI_Proxy>(*(ai->m_proxy))  );

return (CreatureAI*)ai;

ML_CATCH

return NULL;
}
