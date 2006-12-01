
#ifndef LUA_AI_H
#define LUA_AI_H

#include "Player.h"
#include "GameObject.h"
#include "SharedDefines.h"
#include "GossipDef.h"
#include "QuestDef.h"
#include "WorldSession.h"
#include "CreatureAI.h"
#include "luainc.h"

//goind to implement FSM , as it is faster and easyer for exporting to scripting.

#define PRINT_LUA_OBJECT_ERROR error_log("Invalid object in Lua AI system in %s #i" __FILE__ , __LINE__ )

int lb_Export_AI(lua_State* L);

bool IsValidLuaAIState(const luabind::adl::object& ob);

#define VISIBLE_RANGE (26.46f)

class MANGOS_DLL_DECL LuaAI : public CreatureAI
  {
  private:
    luabind::object m_CurrentState;

    Creature* m_creature;

  public:
    LuaAI(Creature* creature) : m_creature(creature)
    {}
    ~LuaAI()
    {}

    void SetCurrentState(const luabind::object& s);

    //this method makes sure the current state object is valid before calling
    // the Execute function of the Lua table it represents
    void UpdateScriptedStateMachine();

    //change to a new state
    void ChangeState(const luabind::object& new_state);

    //retrieve the current state
    const luabind::object& CurrentState()const
      {
        return m_CurrentState;
      }

    // Called if IsVisible(Unit *who) is true at each *who move
    void MoveInLineOfSight(Unit *)
    {}

    // Called at each attack of m_creature by any victim
    void AttackStart(Unit *)
    {}

    // Called at stoping attack by any attacker
    void AttackStop(Unit *);

    // Called at any heal cast/item used (call non implemented in mangos)
    void HealBy(Unit *healer, uint32 amount_healed)
    {}

    // Called at any Damage from any attacker
    void DamageInflict(Unit *healer, uint32 amount_healed)
    {}

    // Is unit visibale for MoveInLineOfSight
    bool IsVisible(Unit *who) const
      {
        debug_log( "LuaAI::IsVisible not implemented" );
        return false; /*!who->isStealth() && m_creature->GetDistanceSq(who) <= VISIBLE_RANGE;*/
      }

    // Called at World update tick
    void UpdateAI(const uint32);

    // Check condition for attack stop
    virtual bool needToStop() const;

    //= Some useful helpers =========================

    // Start attack of victim and go to him
    void DoStartAttack(Unit* victim);

    // Stop attack of current victim
    void DoStopAttack();

    // Cast spell
    void DoCast(Unit* victim, uint32 spelId)
    {
      m_creature->CastSpell(victim,spelId,true);
    }

    void DoCastSpell(Unit* who,SpellEntry *spellInfo)
    {
      m_creature->CastSpell(who,spellInfo,true);
    }

    void DoSay(char const* text, uint32 language)
    {
      m_creature->MonsterSay(text,language, m_creature->GetGUID());
    }

    void DoGoHome();
  };


#endif //LUA_AI_H
