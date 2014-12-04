--[[
PluginInit.lua
Initialize routines when Plugin is loaded
C2Cap.lrplugin
Author:@jenoki48
--]]
local prefs = import 'LrPrefs'.prefsForPlugin() 

if prefs.isLog == nil then 
	prefs.isLog = true
end

if prefs.isRemove == nil then
	prefs.isRemove = false
end

if prefs.isForced == nil then
	prefs.isForced = false
end
