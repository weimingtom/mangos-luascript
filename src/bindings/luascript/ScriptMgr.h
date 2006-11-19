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

#ifndef SCRIPTMGR_H
#define SCRIPTMGR_H

#include "Player.h"
#include "GameObject.h"
#include "SharedDefines.h"
#include "GossipDef.h"
#include "QuestDef.h"
#include "WorldSession.h"
#include "CreatureAI.h"

#define MAX_SCRIPTS 1000

#define VISIBLE_RANGE (26.46f)

struct MANGOS_DLL_DECL ScriptedAI : public CreatureAI
{
    ScriptedAI(Creature* creature) : m_creature(creature) {}
    ~ScriptedAI() {}

    // Called if IsVisible(Unit *who) is true at each *who move
    void MoveInLineOfSight(Unit *) {}

    // Called at each attack of m_creature by any victim
    void AttackStart(Unit *) {}

    // Called at stoping attack by any attacker
    void AttackStop(Unit *);

    // Called at any heal cast/item used (call non implemented in mangos)
    void HealBy(Unit *healer, uint32 amount_healed) {}

    // Called at any Damage from any attacker
    void DamageInflict(Unit *healer, uint32 amount_healed) {}

    // Is unit visibale for MoveInLineOfSight
    bool IsVisible(Unit *who) const
    {
        return !who->isStealth() && m_creature->GetDistanceSq(who) <= VISIBLE_RANGE;
    }

    // Called at World update tick
    void UpdateAI(const uint32);

    Creature* m_creature;

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
    void DoSay(char const* text, uint32 language)
    {
        m_creature->Say(text,language);
    }

    void DoGoHome();
};
#endif
