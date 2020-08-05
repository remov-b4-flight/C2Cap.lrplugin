--[[
PluginInit.lua
Initialize routines when Plugin is loaded
C2Cap.lrplugin
Author:@jenoki48
--]]
local prefs = import 'LrPrefs'.prefsForPlugin() 

if prefs.isRevert == nil then
	prefs.isRevert = false
end
