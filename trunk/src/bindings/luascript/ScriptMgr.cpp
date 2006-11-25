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
// Include from mangos - so we can expose it
#include "Player.h"
#include "GameObject.h"
#include "SharedDefines.h"
#include "GossipDef.h"
#include "QuestDef.h"
#include "WorldSession.h"
#include "CreatureAI.h"
// Inlude the LUA class frontends
#include "LUA_Engine.h"
#include "LUA_Player.h"
#include "Lua_Unit.h"
#include "Lua_uint64.h"
#include "Lua_Creature.h"
#include "Lua_exports.h"

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
	
    return 0;
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

    lb_init(LuaVM);
    
    // -- Load the Masterscript --
	if (LUA_CheckStatus(luaL_loadfile(LuaVM, "Masterscript.lua") || lua_pcall(LuaVM, 0, 0, 0))){
		ScriptsFree(); // Error - Fail, but cleanup! =(
		return;
	}

}

MANGOS_DLL_EXPORT
bool GossipHello ( Player * player, Creature *_Creature )
{

try {
if(!*_Creature->GetCreatureInfo()->ScriptName) return false;
   
   player->PlayerTalkClass->ClearMenus();

if(LuaVM)
   return ( luabind::call_function<int>(LuaVM, "GossipHello",
                                                                        boost::ref<Player>(*player),
																		boost::ref<Creature>(*_Creature)
																		) != -1);

	} catch(luabind::error& e)
	{
	error_log("[LUA] error in GossipHello : %s ",e.what() );
	}
catch(...)
	{
	error_log("[LUA] unhandled error in GossipHello");
	}

return false;
}

MANGOS_DLL_EXPORT
bool GossipSelect( Player *player, Creature *_Creature,uint32 sender, uint32 action )
{

try {
if(!*_Creature->GetCreatureInfo()->ScriptName) return false;

    player->PlayerTalkClass->ClearMenus();

if(LuaVM)
   return ( luabind::call_function<int>(LuaVM, "GossipSelect", 
                                                                         boost::ref<Player>(*player),
																		 boost::ref<Creature>(*_Creature) ,
																		 sender,
																		 action 
																		 )  !=  -1);

	} catch(luabind::error& e)
	{
	error_log("[LUA] error in GossipSelect : %s ",e.what() );
	}
catch(...)
	{
	error_log("[LUA] unhandled error in GossipSelect");
	}

return false;
}

MANGOS_DLL_EXPORT
bool GossipSelectWithCode( Player *player, Creature *_Creature, uint32 sender, uint32 action, char* sCode )
{
 
try {
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

	} catch(luabind::error& e)
	{
	error_log("[LUA] error in GossipSelectWithCode : %s ",e.what() );
	}
catch(...)
	{
	error_log("[LUA] unhandled error in GossipSelectWithCode");
	}

return false;
}

MANGOS_DLL_EXPORT
bool QuestAccept( Player *player, Creature *_Creature, Quest *_Quest )
{

try {
if(!*_Creature->GetCreatureInfo()->ScriptName) return false;

    player->PlayerTalkClass->ClearMenus();

if(LuaVM)
return ( luabind::call_function<int>(LuaVM, "QuestAccept",
		                                                              boost::ref<Player>(*player), 
		                                                              boost::ref<Creature>(*_Creature) ,
						                							  boost::ref<Quest>(*_Quest)  
											                          ) !=  -1);

	} catch(luabind::error& e)
	{
	error_log("[LUA] error in QuestAccept : %s ",e.what() );
	}
catch(...)
	{
	error_log("[LUA] unhandled error in QuestAccept");
	}

return false;
}

MANGOS_DLL_EXPORT
bool QuestSelect( Player *player, Creature *_Creature, Quest *_Quest )
{

try {
if(!*_Creature->GetCreatureInfo()->ScriptName) return false;

    player->PlayerTalkClass->ClearMenus();

if(LuaVM)
   return ( luabind::call_function<int>(LuaVM, "QuestSelect", 
                                                       boost::ref<Player>(*player),
													   boost::ref<Creature>(*_Creature),
													   boost::ref<Quest>(*_Quest) 
													   ) != -1);

	} catch(luabind::error& e)
	{
	error_log("[LUA] error in QuestSelect : %s ",e.what() );
	}
catch(...)
	{
	error_log("[LUA] unhandled error in QuestSelect");
	}

return false;
}

MANGOS_DLL_EXPORT
bool QuestComplete( Player *player, Creature *_Creature, Quest *_Quest )
{

try {
if(!*_Creature->GetCreatureInfo()->ScriptName) return false;

    player->PlayerTalkClass->ClearMenus();

if(LuaVM)
   return ( luabind::call_function<int>(LuaVM, "QuestComplete", 
                                                       boost::ref<Player>(*player),
													   boost::ref<Creature>(*_Creature),
													   boost::ref<Quest>(*_Quest) 
													   ) != -1);

	} catch(luabind::error& e)
	{
	error_log("[LUA] error in QuestComplete : %s ",e.what() );
	}
catch(...)
	{
	error_log("[LUA] unhandled error in QuestComplete");
	}

return false;
}

MANGOS_DLL_EXPORT
bool ChooseReward( Player *player, Creature *_Creature, Quest *_Quest, uint32 opt )
{

try {
if(!*_Creature->GetCreatureInfo()->ScriptName) return false;

    player->PlayerTalkClass->ClearMenus();

if(LuaVM)
   return ( luabind::call_function<int>(LuaVM, "ChooseReward", 
                                                       boost::ref<Player>(*player),
													   boost::ref<Creature>(*_Creature),
													   boost::ref<Quest>(*_Quest) ,
													   opt 
													   ) != -1);

	} catch(luabind::error& e)
	{
	error_log("[LUA] error in ChooseReward : %s ",e.what() );
	}
catch(...)
	{
	error_log("[LUA] unhandled error in ChooseReward");
	}

return false;
}

MANGOS_DLL_EXPORT
uint32 NPCDialogStatus( Player *player, Creature *_Creature )
{

try {
if(!*_Creature->GetCreatureInfo()->ScriptName) return 100;

    player->PlayerTalkClass->ClearMenus();

if(LuaVM)
   return  luabind::call_function<uint32>(LuaVM, "NPCDialogStatus",
                                                               boost::ref<Player>(*player), 
															   boost::ref<Creature>(*_Creature)) ;

	} catch(luabind::error& e)
	{
	error_log("[LUA] error in NPCDialogStatus : %s ",e.what() );
	}
catch(...)
	{
	error_log("[LUA] unhandled error in NPCDialogStatus");
	}

return 100;
}

MANGOS_DLL_EXPORT
bool ItemHello( Player *player, Item *_Item, Quest *_Quest )
{

try {
if(!*_Item->GetProto()->ScriptName) return false;

    player->PlayerTalkClass->ClearMenus();

if(LuaVM)
   return ( luabind::call_function<int>(LuaVM, "ItemHello",
                                                               boost::ref<Player>(*player), 
															   boost::ref<Item>(*_Item) ,
															   boost::ref<Quest>(*_Quest)
															   ) != -1);

	} catch(luabind::error& e)
	{
	error_log("[LUA] error in ItemHello : %s ",e.what() );
	}
catch(...)
	{
	error_log("[LUA] unhandled error in ItemHello");
	}

return false;
}

MANGOS_DLL_EXPORT
bool ItemQuestAccept( Player *player, Item *_Item, Quest *_Quest )
{

try {
if(!*_Item->GetProto()->ScriptName) return false;

    player->PlayerTalkClass->ClearMenus();

if(LuaVM)
   return ( luabind::call_function<int>(LuaVM, "ItemQuestAccept",
                                                               boost::ref<Player>(*player), 
															   boost::ref<Item>(*_Item) ,
															   boost::ref<Quest>(*_Quest)
															   ) != -1);

	} catch(luabind::error& e)
	{
	error_log("[LUA] error in ItemQuestAccept : %s ",e.what() );
	}
catch(...)
	{
	error_log("[LUA] unhandled error in ItemQuestAccept");
	}

return false;
}

MANGOS_DLL_EXPORT
bool GOHello( Player *player, GameObject *_GO )
{

try {
if(!*_GO->GetGOInfo()->ScriptName) return false;

    player->PlayerTalkClass->ClearMenus();

if(LuaVM)
   return ( luabind::call_function<int>(LuaVM, "GOHello",
                                                               boost::ref<Player>(*player), 
															   boost::ref<GameObject>(*_GO) 
															   ) != -1);

	} catch(luabind::error& e)
	{
	error_log("[LUA] error in GOHello : %s ",e.what() );
	}
catch(...)
	{
	error_log("[LUA] unhandled error in GOHello");
	}

return false;
}

MANGOS_DLL_EXPORT
bool GOQuestAccept( Player *player, GameObject *_GO, Quest *_Quest )
{

try {
if(!*_GO->GetGOInfo()->ScriptName) return false;

    player->PlayerTalkClass->ClearMenus();

if(LuaVM)
   return ( luabind::call_function<int>(LuaVM, "GOQuestAccept",
                                                               boost::ref<Player>(*player), 
															   boost::ref<GameObject>(*_GO) ,
															   boost::ref<Quest>(*_Quest)
															   ) != -1);

	} catch(luabind::error& e)
	{
	error_log("[LUA] error in GOQuestAccept : %s ",e.what() );
	}
catch(...)
	{
	error_log("[LUA] unhandled error in GOQuestAccept");
	}

return false;
}

MANGOS_DLL_EXPORT
bool GOChooseReward( Player *player, GameObject *_GO, Quest *_Quest, uint32 opt )
{

try {
if(!*_GO->GetGOInfo()->ScriptName) return false;

    player->PlayerTalkClass->ClearMenus();

if(LuaVM)
   return ( luabind::call_function<int>(LuaVM, "GOChooseReward",
                                                               boost::ref<Player>(*player), 
															   boost::ref<GameObject>(*_GO) ,
															   boost::ref<Quest>(*_Quest),
															   opt
															   ) != -1);

	} catch(luabind::error& e)
	{
	error_log("[LUA] error in GOChooseReward : %s ",e.what() );
	}
catch(...)
	{
	error_log("[LUA] unhandled error in GOChooseReward");
	}

return false;
}

MANGOS_DLL_EXPORT
bool AreaTrigger( Player *player, Quest *_Quest, uint32 triggerID )
{

try {

    player->PlayerTalkClass->ClearMenus();

if(LuaVM)
   return ( luabind::call_function<int>(LuaVM, "AreaTrigger",
                                                               boost::ref<Player>(*player), 
															   boost::ref<Quest>(*_Quest),
															   triggerID
															   ) != -1);

	} catch(luabind::error& e)
	{
	error_log("[LUA] error in AreaTrigger : %s ",e.what() );
	}
catch(...)
	{
	error_log("[LUA] unhandled error in AreaTrigger");
	}

return false;
}

 // NOT  IMPLEMENTED
MANGOS_DLL_EXPORT
CreatureAI* GetAI(Creature *_Creature )
{
    //Script *tmpscript = GetScriptByName(_Creature->GetCreatureInfo()->ScriptName);
    //if(!tmpscript || !tmpscript->GetAI) return NULL;
    //return tmpscript->GetAI(_Creature);
return NULL;
}

void ScriptedAI::UpdateAI(const uint32)
{
    if( m_creature->getVictim() != NULL )
    {
        if( needToStop() )
        {
            DoStopAttack();
        }
        else if( m_creature->IsStopped() )
        {
            if( m_creature->isAttackReady() )
            {
                if(!m_creature->canReachWithAttack(m_creature->getVictim()))
                    return;
                m_creature->AttackerStateUpdate(m_creature->getVictim());
                m_creature->resetAttackTimer();

                if ( !m_creature->getVictim() )
                    return;

                if( needToStop() )
                    DoStopAttack();
            }
        }
    }
}

void ScriptedAI::AttackStop(Unit *)
{
    if( m_creature->isAlive() )
        DoGoHome();
}

void ScriptedAI::DoStartAttack(Unit* victim)
{
    m_creature->Attack(victim);
    (*m_creature)->Mutate(new TargetedMovementGenerator(*victim));
}

void ScriptedAI::DoStopAttack()
{
    if( m_creature->getVictim() != NULL )
    {
        m_creature->AttackStop();
    }
}

void ScriptedAI::DoGoHome()
{
    if( !m_creature->getVictim() && m_creature->isAlive() )
    {
        if( (*m_creature)->top()->GetMovementGeneratorType() == TARGETED_MOTION_TYPE )
            (*m_creature)->Mutate(new TargetedMovementGenerator(*m_creature));

//        static_cast<TargetedMovementGenerator *>((*m_creature)->top())->TargetedHome(*m_creature);
    }
}

bool ScriptedAI::needToStop() const
{
    return ( !m_creature->getVictim()->isTargetableForAttack() || !m_creature->isAlive() );
}
