--[[-------------------------------------------------------
@file	PluginInfo.lua
@bried	Define plugin manager dialogs at C2Cap.lrplugin
@author	remov-b4-flight
---------------------------------------------------------]]
local LrApplication = import 'LrApplication'
local LrTasks = import 'LrTasks'
local LrView = import 'LrView'
local bind = LrView.bind -- a local shortcut for the binding function
local prefs = import 'LrPrefs'.prefsForPlugin()
local Info = require 'Info'

local PluginInfo = {}
local CurrentCatalog = LrApplication.activeCatalog()

function PluginInfo.startDialog( propertyTable )
	propertyTable.isRevert = prefs.isRevert
	propertyTable.RevertTo = prefs.RevertTo
	propertyTable.Revert2nd = prefs.Revert2nd
	propertyTable.RevertColID = prefs.RevertColID
	propertyTable.RevertColID2nd = prefs.RevertColID2nd
end

function PluginInfo.endDialog( propertyTable )
	LrTasks.startAsyncTask( function ()
		local collections = CurrentCatalog:getChildCollections()
		local RevertColID,RevertColID2nd
		for i,ColIt in ipairs(collections) do
			if ColIt:getName() == propertyTable.RevertTo then
				RevertColID = ColIt.localIdentifier
				if RevertColID2nd ~= nil then
					break
				end
			elseif ColIt:getName() == propertyTable.Revert2nd then
				RevertColID2nd = ColIt.localIdentifier
				if RevertColID ~= nil then
					break
				end
			end
		end
		prefs.isRevert = propertyTable.isRevert
		prefs.RevertTo = propertyTable.RevertTo
		prefs.Revert2nd = propertyTable.Revert2nd
		prefs.RevertColID = RevertColID
		prefs.RevertColID2nd = RevertColID2nd
	end)
end

function PluginInfo.sectionsForTopOfDialog( viewFactory, propertyTable )
	return {
		{
			title = Info.LrPluginName,
			synopsis = LOC '$$$/c2cap/description=Set caption to collection name contained by.',
			bind_to_object = propertyTable,
			viewFactory:row {
				viewFactory:checkbox {title = LOC '$$$/c2cap/revertback=Revert Back', value = bind 'isRevert',},
			},
			viewFactory:row {
				viewFactory:static_text {width_in_chars = 7, title = LOC '$$$/c2cap/revertto=Collection',},
				viewFactory:edit_field {value = bind 'RevertTo',},
			},
			viewFactory:row {
				viewFactory:static_text {width_in_chars = 7, title = LOC '$$$/c2cap/secondto=Second Col.',},
				viewFactory:edit_field {value = bind 'Revert2nd',},
			},
		},
	}
end

return PluginInfo
