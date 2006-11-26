

-- luabind::adl::object GetAI(Creature* creature)
function GetAI(_Creature)
printf("GetAI")
        currient_scriptname = _Creature:GetScriptName()
        currient_state = m_AI[currient_scriptname]

        if currient_state ~= nil then
                          return currient_state
                   else
                          return m_AI["default_ai"]
        end   
       
return(nil) 
end

--int HasAI(Creature* creature)
function HasAI(_Creature)
printf("HasAI")
        currient_scriptname = _Creature:GetScriptName()
        currient_state = m_AI[currient_scriptname]

        if currient_state ~= nil then
                          return 1
                   else
                          return 0
        end   
       
return 0
end