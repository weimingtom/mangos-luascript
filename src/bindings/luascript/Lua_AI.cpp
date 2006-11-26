
#include "Lua_AI.h"

int lb_Export_AI(lua_State* L)
	{
	using namespace luabind;
module(L)
[
	class_<LuaAI>("LuaAI")
	.def("ChangeState", LuaAI::ChangeState)
	.def("SetCurrentState", LuaAI::SetCurrentState)
	.def("CurrentState", LuaAI::CurrentState)
];

	return 0;
	}

bool IsValidLuaAIState(const luabind::adl::object& ob)
	{
	if(!ob.is_valid()) return false;

	luabind::adl::object tobj = ob["Enter"];
	if(!tobj.is_valid()) return false;

	tobj = ob["Exit"];
	if(!tobj.is_valid()) return false;

	tobj = ob["Update"];
	if(!tobj.is_valid()) return false;


	return true;
	}

void LuaAI::UpdateAI(const uint32)
{
UpdateScriptedStateMachine();
/*
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
    }*/
}

void LuaAI::AttackStop(Unit *)
{
    if( m_creature->isAlive() )
        DoGoHome();
}

void LuaAI::DoStartAttack(Unit* victim)
{
    m_creature->Attack(victim);
//TODO    (*m_creature)->Mutate(new TargetedMovementGenerator(*victim));
}

void LuaAI::DoStopAttack()
{
    if( m_creature->getVictim() != NULL )
    {
        m_creature->AttackStop();
    }
}

void LuaAI::DoGoHome()
{
    if( !m_creature->getVictim() && m_creature->isAlive() )
	{
        (*m_creature)->TargetedHome();
	}
}

bool LuaAI::needToStop() const
{
    return ( !m_creature->getVictim()->isTargetableForAttack() || !m_creature->isAlive() );
}

void LuaAI::SetCurrentState(const luabind::object& s)  
{
		if(!s.is_valid()) PRINT_LUA_OBJECT_ERROR;
		m_CurrentState = s;
}

void LuaAI::UpdateScriptedStateMachine()
{
    //make sure the state is valid before calling its Execute "method"
    if (m_CurrentState.is_valid())
    {
	    luabind::adl::object ob = m_CurrentState["Update"];
	    if(ob.is_valid())
	        luabind::call_function<void>(ob,m_creature);
		else PRINT_LUA_OBJECT_ERROR;

	}
	else PRINT_LUA_OBJECT_ERROR;
}

void LuaAI::ChangeState(const luabind::object& new_state)
{

    if( !m_CurrentState.is_valid() || !new_state.is_valid() ) { PRINT_LUA_OBJECT_ERROR; return; }

    //call the Exit method of the existing state
    luabind::object ob = m_CurrentState["Exit"];
	if(ob.is_valid())
	        luabind::call_function<void>(ob,m_creature);
	else PRINT_LUA_OBJECT_ERROR;

    //change state to the new state
    m_CurrentState = new_state;

    //call the Entry method of the new state
    ob = m_CurrentState["Enter"];
	if(ob.is_valid())
	        luabind::call_function<void>(ob,m_creature);
	else PRINT_LUA_OBJECT_ERROR;

}












