-- Mango Style guard_tirisfal script
-- Converted by SinnerG

-- Create the Mango Script Base object
Guard_Teldrassil = Mango.Scripts.Create('guard_teldrassil');
Guard_Teldrassil:ForceLUA(); -- Don't use the CPP version if valid

-- Function prototypes (to keep it clean)
local Guard_Teldrassil_GossipHello
local Guard_Teldrassil_GossipSelect
local Guard_Teldrassil_SendDefaultMenu
local Guard_Teldrassil_SendClassTrainerMenu
local Guard_Teldrassil_SendProfTrainerMenu
 
-- The actual functions
-- Send the first menu (with the selections)
function Guard_Teldrassil_GossipHello(player,_Creature)
	-- TODO this is used by  guard_default_ai , if script is not part of it anymore pls remove this
	guard_default_ai_Gossip_Hello(player,_Creature)


	player:ADD_GOSSIP_ITEM( 6, "Bank"					, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1)
	player:ADD_GOSSIP_ITEM( 0, "Rut'theran Ferry"		, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2)
	player:ADD_GOSSIP_ITEM( 0, "Guild Master"			, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3)
	player:ADD_GOSSIP_ITEM( 1, "The Inn"				, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4)
	player:ADD_GOSSIP_ITEM( 5, "Stable Master"			, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5)
	player:ADD_GOSSIP_ITEM( 3, "Class Trainer"			, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6)
	player:ADD_GOSSIP_ITEM( 3, "Profession Trainer"		, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7)
	player:SEND_GOSSIP_MENU(4316,_Creature:GetGUID())

return RETURN_OK
end
          
function Guard_Teldrassil_GossipSelect(player, _Creature, sender, action)
	if sender == GOSSIP_SENDER_MAIN then
		Guard_Teldrassil_SendDefaultMenu(player, _Creature, action)

	elseif sender == GOSSIP_SENDER_SEC_CLASSTRAIN then
		Guard_Teldrassil_SendClassTrainerMenu(player, _Creature, action)

	elseif sender == GOSSIP_SENDER_SEC_PROFTRAIN then
		Guard_Teldrassil_SendProfTrainerMenu_(player, _Creature, action)

	end
return RETURN_OK
end

function Guard_Teldrassil_SendDefaultMenu(player, _Creature, action)
	if action == GOSSIP_ACTION_INFO_DEF + 1 then

		player:SEND_GOSSIP_MENU(4317,_Creature:GetGUID())

	elseif action == GOSSIP_ACTION_INFO_DEF + 2 then

		player:SEND_GOSSIP_MENU(4318,_Creature:GetGUID())

	elseif action == GOSSIP_ACTION_INFO_DEF + 3 then

		player:SEND_GOSSIP_MENU(4319,_Creature:GetGUID())

	elseif action == GOSSIP_ACTION_INFO_DEF + 4 then

		player:SEND_POI(9821.49, 960.13, 6, 6, 0, "Dolanaar Inn")
		player:SEND_GOSSIP_MENU(4320,_Creature:GetGUID())

	elseif action == GOSSIP_ACTION_INFO_DEF + 5 then

		player:SEND_POI(9808.37, 931.1, 6, 6, 0, "Seriadne")
		player:SEND_GOSSIP_MENU(5982,_Creature:GetGUID())

	elseif action == GOSSIP_ACTION_INFO_DEF + 6 then

		player:ADD_GOSSIP_ITEM( 3, "Druid"				, GOSSIP_SENDER_SEC_CLASSTRAIN, GOSSIP_ACTION_INFO_DEF + 1)
		player:ADD_GOSSIP_ITEM( 3, "Hunter"				, GOSSIP_SENDER_SEC_CLASSTRAIN, GOSSIP_ACTION_INFO_DEF + 2)
		player:ADD_GOSSIP_ITEM( 3, "Priest"				, GOSSIP_SENDER_SEC_CLASSTRAIN, GOSSIP_ACTION_INFO_DEF + 3)
		player:ADD_GOSSIP_ITEM( 3, "Rogue"				, GOSSIP_SENDER_SEC_CLASSTRAIN, GOSSIP_ACTION_INFO_DEF + 4)
		player:ADD_GOSSIP_ITEM( 3, "Warrior"			, GOSSIP_SENDER_SEC_CLASSTRAIN, GOSSIP_ACTION_INFO_DEF + 5)
		player:SEND_GOSSIP_MENU(4264,_Creature:GetGUID())

	elseif action == GOSSIP_ACTION_INFO_DEF + 7 then

		player:ADD_GOSSIP_ITEM( 3, "Alchemy"			, GOSSIP_SENDER_SEC_PROFTRAIN, GOSSIP_ACTION_INFO_DEF + 1)
		player:ADD_GOSSIP_ITEM( 3, "Cooking"			, GOSSIP_SENDER_SEC_PROFTRAIN, GOSSIP_ACTION_INFO_DEF + 2)
		player:ADD_GOSSIP_ITEM( 3, "Enchanting"			, GOSSIP_SENDER_SEC_PROFTRAIN, GOSSIP_ACTION_INFO_DEF + 3)
		player:ADD_GOSSIP_ITEM( 3, "First Aid"			, GOSSIP_SENDER_SEC_PROFTRAIN, GOSSIP_ACTION_INFO_DEF + 4)
		player:ADD_GOSSIP_ITEM( 3, "Fishing"			, GOSSIP_SENDER_SEC_PROFTRAIN, GOSSIP_ACTION_INFO_DEF + 5)
		player:ADD_GOSSIP_ITEM( 3, "Herbalism"			, GOSSIP_SENDER_SEC_PROFTRAIN, GOSSIP_ACTION_INFO_DEF + 6)
		player:ADD_GOSSIP_ITEM( 3, "Leatherworking"		, GOSSIP_SENDER_SEC_PROFTRAIN, GOSSIP_ACTION_INFO_DEF + 7)
		player:ADD_GOSSIP_ITEM( 3, "Skinning"			, GOSSIP_SENDER_SEC_PROFTRAIN, GOSSIP_ACTION_INFO_DEF + 8)
		player:ADD_GOSSIP_ITEM( 3, "Tailoring"			, GOSSIP_SENDER_SEC_PROFTRAIN, GOSSIP_ACTION_INFO_DEF + 9)
		player:SEND_GOSSIP_MENU(4273,_Creature:GetGUID())
	end
end

function Guard_Teldrassil_SendClassTrainerMenu(player, _Creature, action)
	if action == GOSSIP_ACTION_INFO_DEF + 1 then

		player:SEND_POI(9741.58, 963.7, 6, 6, 0, "Kal")
		player:SEND_GOSSIP_MENU(4323,_Creature:GetGUID())

	elseif action == GOSSIP_ACTION_INFO_DEF + 2 then

		player:SEND_POI(9815.12, 926.28, 6, 6, 0, "Dazalar")
		player:SEND_GOSSIP_MENU(4324,_Creature:GetGUID())

	elseif action == GOSSIP_ACTION_INFO_DEF + 3 then

		player:SEND_POI(9906.16, 986.63, 6, 6, 0, "Laurna Morninglight")
		player:SEND_GOSSIP_MENU(4325,_Creature:GetGUID())

	elseif action == GOSSIP_ACTION_INFO_DEF + 4 then

		player:SEND_POI(9789, 942.86, 6, 6, 0, "Jannok Breezesong")
		player:SEND_GOSSIP_MENU(4326,_Creature:GetGUID())

	elseif action == GOSSIP_ACTION_INFO_DEF + 5 then

		player:SEND_POI(9821.96, 950.61, 6, 6, 0, "Kyra Windblade")
		player:SEND_GOSSIP_MENU(4327,_Creature:GetGUID())
	end
end

function Guard_Teldrassil_SendProfTrainerMenu(player, _Creature, action)
	if action == GOSSIP_ACTION_INFO_DEF + 1 then

		player:SEND_POI(9767.59, 878.81, 6, 6, 0, "Cyndra Kindwhisper")
		player:SEND_GOSSIP_MENU(4329,_Creature:GetGUID())

	elseif action == GOSSIP_ACTION_INFO_DEF + 2 then

		player:SEND_POI(9751.19, 906.13, 6, 6, 0, "Zarrin")
		player:SEND_GOSSIP_MENU(4330,_Creature:GetGUID())

	elseif action == GOSSIP_ACTION_INFO_DEF + 3 then

		player:SEND_POI(10677.59, 1946.56, 6, 6, 0, "Alanna Raveneye")
		player:SEND_GOSSIP_MENU(4331,_Creature:GetGUID())

	elseif action == GOSSIP_ACTION_INFO_DEF + 4 then

		player:SEND_POI(9903.12, 999, 6, 6, 0, "Byancie")
		player:SEND_GOSSIP_MENU(4332,_Creature:GetGUID())

	elseif action == GOSSIP_ACTION_INFO_DEF + 5 then

		player:SEND_GOSSIP_MENU(4333,_Creature:GetGUID())

	elseif action == GOSSIP_ACTION_INFO_DEF + 6 then

		player:SEND_POI(9773.78, 875.88, 6, 6, 0, "Malorne Bladeleaf")
		player:SEND_GOSSIP_MENU(4334,_Creature:GetGUID())

	elseif action == GOSSIP_ACTION_INFO_DEF + 7 then

		player:SEND_POI(10152.59, 1681.46, 6, 6, 0, "Nadyia Maneweaver")
		player:SEND_GOSSIP_MENU(4335,_Creature:GetGUID())

	elseif action == GOSSIP_ACTION_INFO_DEF + 8 then

		player:SEND_POI(10135.59, 1673.18, 6, 6, 0, "Radnaal Maneweaver")
		player:SEND_GOSSIP_MENU(4337,_Creature:GetGUID())

	elseif action == GOSSIP_ACTION_INFO_DEF + 9 then

		player:SEND_POI(-1249.17, 155, 6, 6, 0, "Stonehoof Geology")
		player:SEND_GOSSIP_MENU(4337,_Creature:GetGUID())
	end
end

-- Assign the functions
Guard_Teldrassil.GossipHello = Guard_Teldrassil_GossipHello;
Guard_Teldrassil.GossipSelect= Guard_Teldrassil_GossipSelect;

-- Activate (run) the script
Guard_Teldrassil:Activate();
