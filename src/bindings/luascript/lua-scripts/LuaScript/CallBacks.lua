--Here are the callbacks funcs ... this is actually what MaNGOSScript.dll exports , exported to lua

printf('Loading Callbacks by Derex')

--return  -1 if func is not handled (false)
--               0 on success (true)
--               everything else is also counted for true

--Yes , Here is big mess :)

--bool GossipHello ( Player * player, Creature *_Creature )
function GossipHello(player,_Creature)
        printf('GossipHello')
        
        currient_scriptname = _Creature:GetScriptName()
        currient_script = m_scripts[currient_scriptname]

        if currient_script ~= nil then
                   currient_func = currient_script["GossipHello"]
        
                   if currient_func ~= nil then
                         return currient_func(player,_Creature)
                   else
                          printf("Script : %s %s" , currient_scriptname , " does not have GossipHello function " )
                   end
        else
                   printf("Script : %s %s",currient_scriptname," is not handled by Lua-Script")
        end
        return(-1)
end

-- bool GossipSelect( Player *player, Creature *_Creature,uint32 sender, uint32 action )
function GossipSelect( player, _Creature, sender, action )
        printf('GossipSelect')
        
        currient_scriptname = _Creature:GetScriptName()
        currient_script = m_scripts[currient_scriptname]

        if currient_script ~= nil then
                   currient_func = currient_script["GossipSelect"]
        
                   if currient_func ~= nil then
                         return currient_func(player, _Creature, sender, action)
                   else
                          printf("Script : %s %s" , currient_scriptname , " does not have GossipSelect function " )
                   end
        else
                   printf("Script : %s %s",currient_scriptname," is not handled by Lua-Script")
        end        
        return(-1)
end

-- bool GossipSelectWithCode( Player *player, Creature *_Creature, uint32 sender, uint32 action, char* sCode )
function GossipSelectWithCode( player, _Creature, sender, action, sCode )
        printf('GossipSelectWithCode')
        
        currient_scriptname = _Creature:GetScriptName()
        currient_script = m_scripts[currient_scriptname]

        if currient_script ~= nil then
                   currient_func = currient_script["GossipSelectWithCode"]
        
                   if currient_func ~= nil then
                         return currient_func(player, _Creature, sender, action, sCode)
                   else
                          printf("Script : %s %s " , currient_scriptname , " does not have GossipSelectWithCode function " )
                   end
        else
                   printf("Script : %s %s",currient_scriptname," is not handled by Lua-Script")
        end   
        return(-1)
end

-- bool QuestAccept( Player *player, Creature *_Creature, Quest *_Quest )
function QuestAccept( player, _Creature, _Quest )
        printf('QuestAccept')
        
        currient_scriptname = _Creature:GetScriptName()
        currient_script = m_scripts[currient_scriptname]

        if currient_script ~= nil then
                   currient_func = currient_script["QuestAccept"]
        
                   if currient_func ~= nil then
                         return currient_func(player, _Creature, _Quest )
                   else
                          printf("Script : %s %s" , currient_scriptname , " does not have QuestAccept function " )
                   end
        else
                   printf("Script : %s %s",currient_scriptname," is not handled by Lua-Script")
        end   
        return(-1)
end

-- bool QuestSelect( Player *player, Creature *_Creature, Quest *_Quest )
function QuestSelect( player,_Creature,_Quest )
        printf('QuestSelect')
        
        currient_scriptname = _Creature:GetScriptName()
        currient_script = m_scripts[currient_scriptname]

        if currient_script ~= nil then
                   currient_func = currient_script["QuestSelect"]
        
                   if currient_func ~= nil then
                         return currient_func(player,_Creature,_Quest)
                   else
                          printf("Script : %s %s" , currient_scriptname , " does not have QuestSelect function " )
                   end
        else
                   printf("Script : %s %s",currient_scriptname," is not handled by Lua-Script")
        end   
        return(-1)
end

-- bool QuestComplete( Player *player, Creature *_Creature, Quest *_Quest )
function QuestComplete( player, _Creature, _Quest )
        printf('QuestComplete')
        
        currient_scriptname = _Creature:GetScriptName()
        currient_script = m_scripts[currient_scriptname]

        if currient_script ~= nil then
                   currient_func = currient_script["QuestComplete"]
        
                   if currient_func ~= nil then
                         return currient_func( player, _Creature, _Quest)
                   else
                          printf("Script : %s %s" , currient_scriptname , " does not have QuestComplete function " )
                   end
        else
                   printf("Script : %s %s",currient_scriptname," is not handled by Lua-Script")
        end   
        return(-1)
end

-- bool ChooseReward( Player *player, Creature *_Creature, Quest *_Quest, uint32 opt )
function ChooseReward( player, _Creature, _Quest, opt )
        printf('ChooseReward')
        
        currient_scriptname = _Creature:GetScriptName()
        currient_script = m_scripts[currient_scriptname]

        if currient_script ~= nil then
                   currient_func = currient_script["ChooseReward"]
        
                   if currient_func ~= nil then
                         return currient_func(player,_Creature)
                   else
                          printf("Script : %s %s" ,currient_scriptname , " does not have ChooseReward function " )
                   end
        else
                   printf("Script : %s %s",currient_scriptname," is not handled by Lua-Script")
        end   
        return(-1)
end

-- uint32 NPCDialogStatus( Player *player, Creature *_Creature )
function NPCDialogStatus( player, _Creature )
        printf('NPCDialogStatus')
        
        currient_scriptname = _Creature:GetScriptName()
        currient_script = m_scripts[currient_scriptname]

        if currient_script ~= nil then
                   currient_func = currient_script["NPCDialogStatus"]
        
                   if currient_func ~= nil then
                         return currient_func(player,_Creature)
                   else
                          printf("Script : %s %s" , currient_scriptname , " does not have NPCDialogStatus function " )
                   end
        else
                   printf("Script : %s %s",currient_scriptname," is not handled by Lua-Script")
        end   
        return(100)
end

-- bool ItemHello( Player *player, Item *_Item, Quest *_Quest )
function ItemHello( player, _Item, _Quest )
        printf('ItemHello')
        
        currient_scriptname = _Creature:GetScriptName()
        currient_script = m_scripts[currient_scriptname]

        if currient_script ~= nil then
                   currient_func = currient_script["ItemHello"]
        
                   if currient_func ~= nil then
                         return currient_func(player, _Item, _Quest)
                   else
                          printf("Script : %s %s" , currient_scriptname , " does not have ItemHello function " )
                   end
        else
                   printf("Script : %s %s",currient_scriptname," is not handled by Lua-Script")
        end   
        return(-1)
end

-- bool ItemQuestAccept( Player *player, Item *_Item, Quest *_Quest )
function ItemQuestAccept( player, _Item, _Quest )
        printf('ItemQuestAccept')
        
        currient_scriptname = _Creature:GetScriptName()
        currient_script = m_scripts[currient_scriptname]

        if currient_script ~= nil then
                   currient_func = currient_script["ItemQuestAccept"]
        
                   if currient_func ~= nil then
                         return currient_func(player, _Item, _Quest)
                   else
                          printf("Script : %s %s" , currient_scriptname , " does not have ItemQuestAccept function " )
                   end
        else
                   printf("Script : %s %s",currient_scriptname," is not handled by Lua-Script")
        end   
        return(-1)
end

-- bool GOHello( Player *player, GameObject *_GO )
function GOHello( player,_GO )
        printf('GOHello')
        
        currient_scriptname = _Creature:GetScriptName()
        currient_script = m_scripts[currient_scriptname]

        if currient_script ~= nil then
                   currient_func = currient_script["GOHello"]
        
                   if currient_func ~= nil then
                         return currient_func(player,_GO)
                   else
                          printf("Script : %s %s" , currient_scriptname , " does not have GOHello function " )
                   end
        else
                   printf("Script : %s %s",currient_scriptname," is not handled by Lua-Script")
        end   
        return(-1)
end

-- bool GOQuestAccept( Player *player, GameObject *_GO, Quest *_Quest )
function  GOQuestAccept( player, _GO, _Quest )
        printf('GOQuestAccept')
        
        currient_scriptname = _Creature:GetScriptName()
        currient_script = m_scripts[currient_scriptname]

        if currient_script ~= nil then
                   currient_func = currient_script["GOQuestAccept"]
        
                   if currient_func ~= nil then
                         return currient_func(player, _GO, _Quest)
                   else
                          printf("Script : %s %s" , currient_scriptname , " does not have GOQuestAccept function " )
                   end
        else
                   printf("Script : %s %s",currient_scriptname," is not handled by Lua-Script")
        end   
        return(-1)
end

-- bool GOChooseReward( Player *player, GameObject *_GO, Quest *_Quest, uint32 opt )
function  GOChooseReward( player, _GO, _Quest, opt )
        printf('GOChooseReward')
        
        currient_scriptname = _Creature:GetScriptName()
        currient_script = m_scripts[currient_scriptname]

        if currient_script ~= nil then
                   currient_func = currient_script["GOChooseReward"]
        
                   if currient_func ~= nil then
                         return currient_func( player, _GO, _Quest, opt)
                   else
                          printf("Script : %s %s" , currient_scriptname , " does not have GOChooseReward function " )
                   end
        else
                   printf("Script : %s %s",currient_scriptname," is not handled by Lua-Script")
        end   
        return(-1)
end

-- bool AreaTrigger( Player *player, Quest *_Quest, uint32 triggerID )
function  AreaTrigger( player, _Quest, triggerID )
        printf('AreaTrigger')
        return(-1)
end

-- void ScriptsFree()
function ScriptsFree()
        printf('ScriptsFree')
end

printf('CallBacks loaded')
