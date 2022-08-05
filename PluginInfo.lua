--[[-------------------------------------------------------
@file	PluginInfo.lua
@bried	Define plugin manager dialogs at C2Cap.lrplugin
@author	remov-b4-flight
---------------------------------------------------------]]
local LrView = import 'LrView'
local bind = LrView.bind -- a local shortcut for the binding function
local prefs = import 'LrPrefs'.prefsForPlugin()

local PluginInfo = {}

function PluginInfo.startDialog( propertyTable )
	propertyTable.isRevert = prefs.isRevert
	propertyTable.RevertTo = prefs.RevertTo
	propertyTable.Revert2nd = prefs.Revert2nd
end

function PluginInfo.endDialog( propertyTable ,why )
	prefs.isRevert = propertyTable.isRevert
	prefs.RevertTo = propertyTable.RevertTo
	prefs.Revert2nd = propertyTable.Revert2nd
end

function PluginInfo.sectionsForTopOfDialog( viewFactory, propertyTable )
	return {
		{
			title = 'C2Cap',
			synopsis = 'Set caption to collection name contained by.',
			bind_to_object = propertyTable,
			viewFactory:row {
				viewFactory:checkbox {title = 'Revert Back', value = bind 'isRevert',},
			},
			viewFactory:row {
				viewFactory:static_text {title = 'Collection',},
				viewFactory:edit_field {value = bind 'RevertTo',},
			},
			viewFactory:row {
				viewFactory:static_text {title = 'Second Col.',},
				viewFactory:edit_field {value = bind 'Revert2nd',},
			},
		},
	}
end

return PluginInfo
