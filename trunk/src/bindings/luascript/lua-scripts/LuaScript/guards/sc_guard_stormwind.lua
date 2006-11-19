scriptname = "guard_stormwind"
--Taken from ScriptsDev

m_scripts[scriptname] = {}

m_scripts[scriptname]["GossipHello"] = function(player,_Creature)

    player:ADD_GOSSIP_ITEM( 0, "Bank"                 , GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1)
    player:ADD_GOSSIP_ITEM( 0, "Gryphon master"       , GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2)
    player:ADD_GOSSIP_ITEM( 0, "Guild master"         , GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3)
    player:ADD_GOSSIP_ITEM( 0, "Inn"                  , GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4)
    player:ADD_GOSSIP_ITEM( 0, "Stable master"        , GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5)
    player:ADD_GOSSIP_ITEM( 0, "Class trainer"        , GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6)
    player:ADD_GOSSIP_ITEM( 0, "Profession trainer"   , GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7)

    player:SEND_GOSSIP_MENU(2593,_Creature:GetGUID());

return(0)
end

--Some functions
function SendDefaultMenu_guard_stormwind(player, _Creature,  action)

    if action == GOSSIP_ACTION_INFO_DEF + 1 then
        player:SEND_GOSSIP_MENU(4260,_Creature:GetGUID())

    elseif action == GOSSIP_ACTION_INFO_DEF + 2 then
        player:SEND_GOSSIP_MENU(4261,_Creature:GetGUID())

    elseif action == GOSSIP_ACTION_INFO_DEF + 3 then
        player:SEND_GOSSIP_MENU(4262,_Creature:GetGUID())

    elseif action == GOSSIP_ACTION_INFO_DEF + 4 then
        player:SEND_POI(-9459.34, 42.08, 99, 6, 0, "Lion's Pride Inn")
        player:SEND_GOSSIP_MENU(4263,_Creature:GetGUID())

    elseif action == GOSSIP_ACTION_INFO_DEF + 5 then
        player:SEND_POI(-9466.62, 45.87, 99, 6, 0, "Erma")
        player:SEND_GOSSIP_MENU(5983,_Creature:GetGUID())

    elseif action == GOSSIP_ACTION_INFO_DEF + 6 then
        player:ADD_GOSSIP_ITEM( 0, "Druid"                , GOSSIP_SENDER_SEC_CLASSTRAIN, GOSSIP_ACTION_INFO_DEF + 1)
        player:ADD_GOSSIP_ITEM( 0, "Hunter"               , GOSSIP_SENDER_SEC_CLASSTRAIN, GOSSIP_ACTION_INFO_DEF + 2)
        player:ADD_GOSSIP_ITEM( 0, "Mage"                 , GOSSIP_SENDER_SEC_CLASSTRAIN, GOSSIP_ACTION_INFO_DEF + 3)
        player:ADD_GOSSIP_ITEM( 0, "Paladin"              , GOSSIP_SENDER_SEC_CLASSTRAIN, GOSSIP_ACTION_INFO_DEF + 4)
        player:ADD_GOSSIP_ITEM( 0, "Priest"               , GOSSIP_SENDER_SEC_CLASSTRAIN, GOSSIP_ACTION_INFO_DEF + 5)
        player:ADD_GOSSIP_ITEM( 0, "Rogue"                , GOSSIP_SENDER_SEC_CLASSTRAIN, GOSSIP_ACTION_INFO_DEF + 6)
        player:ADD_GOSSIP_ITEM( 0, "Warlock"              , GOSSIP_SENDER_SEC_CLASSTRAIN, GOSSIP_ACTION_INFO_DEF + 7)
        player:ADD_GOSSIP_ITEM( 0, "Warrior"              , GOSSIP_SENDER_SEC_CLASSTRAIN, GOSSIP_ACTION_INFO_DEF + 8)

        player:SEND_GOSSIP_MENU(4264,_Creature:GetGUID())

    elseif action == GOSSIP_ACTION_INFO_DEF + 7 then
        player:ADD_GOSSIP_ITEM( 0, "Alchemy"              , GOSSIP_SENDER_SEC_PROFTRAIN, GOSSIP_ACTION_INFO_DEF + 1)
        player:ADD_GOSSIP_ITEM( 0, "Blacksmithing"        , GOSSIP_SENDER_SEC_PROFTRAIN, GOSSIP_ACTION_INFO_DEF + 2)
        player:ADD_GOSSIP_ITEM( 0, "Cooking"              , GOSSIP_SENDER_SEC_PROFTRAIN, GOSSIP_ACTION_INFO_DEF + 3)
        player:ADD_GOSSIP_ITEM( 0, "Enchanting"           , GOSSIP_SENDER_SEC_PROFTRAIN, GOSSIP_ACTION_INFO_DEF + 4)
        player:ADD_GOSSIP_ITEM( 0, "Engineering"          , GOSSIP_SENDER_SEC_PROFTRAIN, GOSSIP_ACTION_INFO_DEF + 5)
        player:ADD_GOSSIP_ITEM( 0, "First Aid"            , GOSSIP_SENDER_SEC_PROFTRAIN, GOSSIP_ACTION_INFO_DEF + 6)
        player:ADD_GOSSIP_ITEM( 0, "Fishing"              , GOSSIP_SENDER_SEC_PROFTRAIN, GOSSIP_ACTION_INFO_DEF + 7)
        player:ADD_GOSSIP_ITEM( 0, "Herbalism"            , GOSSIP_SENDER_SEC_PROFTRAIN, GOSSIP_ACTION_INFO_DEF + 8)
        player:ADD_GOSSIP_ITEM( 0, "Leatherworking"       , GOSSIP_SENDER_SEC_PROFTRAIN, GOSSIP_ACTION_INFO_DEF + 9)
        player:ADD_GOSSIP_ITEM( 0, "Mining"               , GOSSIP_SENDER_SEC_PROFTRAIN, GOSSIP_ACTION_INFO_DEF + 10)
        player:ADD_GOSSIP_ITEM( 0, "Skinning"             , GOSSIP_SENDER_SEC_PROFTRAIN, GOSSIP_ACTION_INFO_DEF + 11)
        player:ADD_GOSSIP_ITEM( 0, "Tailoring"            , GOSSIP_SENDER_SEC_PROFTRAIN, GOSSIP_ACTION_INFO_DEF + 12)

        player:SEND_GOSSIP_MENU(4273,_Creature:GetGUID())
    end
end

function SendClassTrainerMenu_guard_stormwind(player, _Creature, action)

    if action == GOSSIP_ACTION_INFO_DEF + 1 then
        player:SEND_GOSSIP_MENU(4265,_Creature:GetGUID())


    elseif action == GOSSIP_ACTION_INFO_DEF + 2 then
        player:SEND_GOSSIP_MENU(4266,_Creature:GetGUID())

    elseif action == GOSSIP_ACTION_INFO_DEF + 3 then
        player:SEND_POI(-9471.12, 33.44, 99, 6, 0, "Zaldimar Wefhellt")
        player:SEND_GOSSIP_MENU(4268,_Creature:GetGUID())

    elseif (action == GOSSIP_ACTION_INFO_DEF + 4) then
        player:SEND_POI(-9469, 108.05, 99, 6, 0, "Brother Wilhelm")
        player:SEND_GOSSIP_MENU(4269,_Creature:GetGUID())

    elseif action == GOSSIP_ACTION_INFO_DEF + 5 then
        player:SEND_POI(-9461.07, 32.6, 99, 6, 0, "Priestess Josetta")
        player:SEND_GOSSIP_MENU(4267,_Creature:GetGUID())

    elseif action == GOSSIP_ACTION_INFO_DEF + 6 then
        player:SEND_POI(-9465.13, 13.29, 99, 6, 0, "Keryn Sylvius")
        player:SEND_GOSSIP_MENU(4270,_Creature:GetGUID())

    elseif action == GOSSIP_ACTION_INFO_DEF + 7 then
        player:SEND_POI(-9473.21, -4.08, 99, 6, 0, "Maximillian Crowe")
        player:SEND_GOSSIP_MENU(4272,_Creature:GetGUID())

    elseif action == GOSSIP_ACTION_INFO_DEF + 7 then
        player:SEND_POI(-9461.82, 109.50, 99, 6, 0, "Lyria Du Lac")
        player:SEND_GOSSIP_MENU(4271,_Creature:GetGUID())
     end
end

function SendProfTrainerMenu_guard_stormwind(player, _Creature, action)

    if action == GOSSIP_ACTION_INFO_DEF + 1 then
        player:SEND_POI(-9057.04, 153.63, 99, 6, 0, "Alchemist Mallory")
        player:SEND_GOSSIP_MENU(4274,_Creature:GetGUID())

    elseif action == GOSSIP_ACTION_INFO_DEF + 2 then

        player:SEND_POI(-9456.58, 87.90, 99, 6, 0, "Smith Argus") 
        player:SEND_GOSSIP_MENU(4275,_Creature:GetGUID())


    elseif action == GOSSIP_ACTION_INFO_DEF + 3 then

        player:SEND_POI(-9467.54, -3.16, 99, 6, 0, "Tomas") 
        player:SEND_GOSSIP_MENU(4276,_Creature:GetGUID())


    elseif action == GOSSIP_ACTION_INFO_DEF + 4 then

        player:SEND_GOSSIP_MENU(4277,_Creature:GetGUID())


    elseif action == GOSSIP_ACTION_INFO_DEF + 5 then

        player:SEND_GOSSIP_MENU(4278,_Creature:GetGUID())


    elseif action == GOSSIP_ACTION_INFO_DEF + 6 then

        player:SEND_POI(-9456.82, 30.49, 99, 6, 0, "Michelle Belle")
        player:SEND_GOSSIP_MENU(4279,_Creature:GetGUID())


    elseif action == GOSSIP_ACTION_INFO_DEF + 7 then

        player:SEND_POI(-9386.54, -118.73, 99, 6, 0, "Lee Brown")
        player:SEND_GOSSIP_MENU(4280,_Creature:GetGUID())


    elseif action == GOSSIP_ACTION_INFO_DEF + 8 then

        player:SEND_POI(-9060.70, 149.23, 99, 6, 0, "Herbalist Pomeroy")
        player:SEND_GOSSIP_MENU(4281,_Creature:GetGUID())


    elseif action == GOSSIP_ACTION_INFO_DEF + 9 then

        player:SEND_POI(-9376.12, -75.23, 99, 6, 0, "Adele Fielder")


    elseif action == GOSSIP_ACTION_INFO_DEF + 10 then

        player:SEND_POI(-9381.12, -70.11, 99, 6, 0, "Helene Peltskinner")
        player:SEND_GOSSIP_MENU(4283,_Creature:GetGUID())

    elseif action == GOSSIP_ACTION_INFO_DEF + 11 then

        player:SEND_POI(-9536.91, -1212.76, 99, 6, 0, "Eldrin")
        player:SEND_GOSSIP_MENU(4284,_Creature:GetGUID())


    elseif action == GOSSIP_ACTION_INFO_DEF + 12 then

        player:SEND_POI(-9376.12, -75.23, 99, 6, 0, "Adele Fielder")
        player:SEND_GOSSIP_MENU(4285,_Creature:GetGUID())
   end
end

m_scripts[scriptname]["GossipSelect"] = function(player, _Creature, sender, action)
     --Serving guard_stormwind/main menu
    if sender == GOSSIP_SENDER_MAIN then
         SendDefaultMenu_guard_stormwind(player, _Creature, action)
    
    --Came from the second menu already
     elseif sender == GOSSIP_SENDER_SEC_CLASSTRAIN then
        SendClassTrainerMenu_guard_stormwind(player, _Creature, action)
     
     elseif sender == GOSSIP_SENDER_SEC_PROFTRAIN then
        SendProfTrainerMenu_guard_stormwind(player, _Creature, action)
        
      end

return(0)
end

m_scripts[scriptname]["GossipSelectWithCode"] = function(player, _Creature, sender, action, sCode)

return(-1)
end

m_scripts[scriptname]["QuestAccept"] = function( player, _Creature, _Quest )

return(-1)
end

m_scripts[scriptname]["QuestSelect"] = function(player,_Creature,_Quest)

return(-1)
end

m_scripts[scriptname]["ChooseReward"] = function(player, _Creature, _Quest, opt)

return(-1)
end

m_scripts[scriptname]["NPCDialogStatus"] = function(player,_Creature)

return(128)
end
