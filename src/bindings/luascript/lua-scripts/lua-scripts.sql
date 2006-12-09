-- Scripts for Mangos-Lua scripting library

-- guards
UPDATE `creature_template` SET`ScriptName` = 'guard_orgrimmar' WHERE `entry` = 3296;
UPDATE `creature_template` SET`ScriptName` = 'guard_stormwind' WHERE `entry` IN (68,1976);
UPDATE `creature_template` SET`ScriptName` = 'guard_elwynnforest' WHERE `entry` = 1423;
UPDATE `creature_template` SET`ScriptName` = 'guard_darnassus' WHERE `entry` = 4262;
UPDATE `creature_template` SET`ScriptName` = 'guard_teldrassil' WHERE `entry` = 3571;
UPDATE `creature_template` SET`ScriptName` = 'guard_ironforge' WHERE `entry` = 5595;
UPDATE `creature_template` SET`ScriptName` = 'guard_dunmorogh' WHERE `entry` IN (727,13076);
UPDATE `creature_template` SET`ScriptName` = 'guard_undercity' WHERE `entry` = 5624;
UPDATE `creature_template` SET`ScriptName` = 'guard_bluffwatcher' WHERE `entry` = 3084;
UPDATE `creature_template` SET`ScriptName` = 'guard_durotar' WHERE `entry` = 5953;
UPDATE `creature_template` SET`ScriptName` = 'guard_mulgore' WHERE `entry` IN (3209,3210,3211,3212,3213,3214,3215,3217,3218,3219,3220,3221,3222,3223,3224);
UPDATE `creature_template` SET`ScriptName` = 'guard_dunmorogh' WHERE `entry` = 727 OR `entry` = 13076;
UPDATE `creature_template` SET`ScriptName` = 'guard_tirisfal' WHERE `entry` IN (1735,1738,2210,1736,1739,1737,1744,1745,5725,1743,2209,1746,1742);
