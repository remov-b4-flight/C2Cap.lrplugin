--[[-------------------------------------------------------
@file	PluginInit.lua
@brief	Initialize routines when C2Cap.lrplugin Plugin is loaded. 
@author	remove-b4-flight
---------------------------------------------------------]]
local prefs = import 'LrPrefs'.prefsForPlugin()

if prefs.isRevert == nil then
	prefs.isRevert = false
end

if prefs.Title == nil then
	prefs.Title = 'C2Cap'
end