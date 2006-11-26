
default_ai = { }

--Called on every new object initialization ( only states that are added to m_AI should have such function )
default_ai["Init"] = function(creature)
printf("default_ai Enter")

end

-- Called when state is changed to that
default_ai["Enter"] = function(creature)
printf("default_ai Enter")

end

-- Called when this state is going to be changed to other
default_ai["Exit"] = function(creature)
printf("default_ai Exit")

end


-- Update function , called at each update cycle
default_ai["Update"] = function(creature)

end

m_AI["default_ai"] = default_ai