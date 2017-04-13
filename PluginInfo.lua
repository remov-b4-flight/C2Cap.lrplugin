--[[----------------------------------------------------------------------------
PluginInfo.lua
C2Cap.lrplugin
Author:@jenoki48
------------------------------------------------------------------------------]]
local LrView = import 'LrView'
local bind = LrView.bind -- a local shortcut for the binding function
local prefs = import 'LrPrefs'.prefsForPlugin()

local PluginInfo = {}

function PluginInfo.startDialog( propertyTable )
--	propertyTable.isLog = prefs.isLog
	propertyTable.isRevert = prefs.isRevert
	propertyTable.isForced = prefs.isForced
	propertyTable.RevertTo = prefs.RevertTo
end

function PluginInfo.endDialog( propertyTable ,why )
--	prefs.isLog = propertyTable.isLog
	prefs.isRevert = propertyTable.isRevert
	prefs.isForced = propertyTable.isForced
	prefs.RevertTo = propertyTable.RevertTo
end

function PluginInfo.sectionsForTopOfDialog( viewFactory, propertyTable )
	return {
		{
			title = 'C2Cap',
			synopsis = 'Set caption to collection name contained by.',
			bind_to_object = propertyTable,
			viewFactory:row {
--				viewFactory:checkbox {title = 'Enable Log', value = bind 'isLog',},
				viewFactory:checkbox {title = 'Force update', value = bind 'isForced',},
				viewFactory:checkbox {title = 'Revert Back', value = bind 'isRevert',},
				viewFactory:edit_field {title = 'Collection', value = bind 'RevertTo',},
			},
		},
	}
end

return PluginInfo
