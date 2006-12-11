scriptname = "misc_bombay"
gossip_menu_id = 150000 -- Our first misc, we start it from 150000

-- SQL Updates:
-- UPDATE `creature_template` SET `ScriptName` = 'misc_bombay' WHERE `entry` = 10578
-- UPDATE `creature_template` SET `npcflag` = '65' WHERE `entry` =10578 LIMIT 1 ;

DisableCppScript( scriptname ) -- This script does not have a CPP equalivant or atleast not a 'stable' one

-- Work in progress for Bom'bay, Witch Doctor in Training 
-- Todo: 
-- Correct greeting message (SQL)
-- Correct menu layout
-- Check if all required quests are done, and if not, show correct greeting message

m_scripts[scriptname] = {}
m_scripts[scriptname]["GossipHello"] = function(player,_Creature)

	player:ADD_GOSSIP_ITEM( 0, "Low spirits"			, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1)
	player:ADD_GOSSIP_ITEM( 0, "Bad hang nail"			, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2)
	player:ADD_GOSSIP_ITEM( 0, "Feeling underpowered"			, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3)
	player:ADD_GOSSIP_ITEM( 0, "Jungle Fever"			, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4)
	player:ADD_GOSSIP_ITEM( 0, "Uni-brow"			, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5)
	player:ADD_GOSSIP_ITEM( 0, "Whiplash"			, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6)
	player:ADD_GOSSIP_ITEM( 0, "I don't want to go back to work"			, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7)

	player:SEND_GOSSIP_MENU(gossip_menu_id,_Creature:GetGUID());
	return RETURN_OK
end

function SendDefaultMenu_misc_bombay(player, _Creature, action)
	player:SEND_GOSSIP_MENU(gossip_menu_id,_Creature:GetGUID());
	return RETURN_OK
end

m_scripts[scriptname]["GossipSelect"] = function(player, _Creature, sender, action)
	-- Serving misc_bombay/main menu
	if sender == GOSSIP_SENDER_MAIN then
		SendDefaultMenu_misc_bombay(player, _Creature, action)
	end
return RETURN_OK
end

m_scripts[scriptname]["GossipSelectWithCode"] = function(player, _Creature, sender, action, sCode)

return RETURN_NOK
end

m_scripts[scriptname]["QuestAccept"] = function( player, _Creature, _Quest )

return RETURN_NOK
end

m_scripts[scriptname]["QuestSelect"] = function(player, _Creature, _Quest)

return RETURN_NOK
end

m_scripts[scriptname]["QuestComplete"] = function(player, _Creature, _Quest)

return RETURN_NOK
end

m_scripts[scriptname]["ChooseReward"] = function(player, _Creature, _Quest, opt)

return RETURN_NOK
end

m_scripts[scriptname]["NPCDialogStatus"] = function(player, _Creature)

return(128)
end

-- Register a dummy AI
