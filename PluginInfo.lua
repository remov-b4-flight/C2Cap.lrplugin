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
	propertyTable.isLog = prefs.isLog
	--propertyTable.isRemove = prefs.isRemove
	propertyTable.isForced = prefs.isForced
end

function PluginInfo.endDialog( propertyTable ,why )
	prefs.isLog = propertyTable.isLog
	--prefs.isRemove = propertyTable.isRemove
	prefs.isForced = propertyTable.isForced
end

function PluginInfo.sectionsForTopOfDialog( viewFactory, propertyTable )
	return {
		{
			title = 'C2Cap',
			synopsis = 'Set caption to collection name contained by.',
			bind_to_object = propertyTable,
			viewFactory:row {
				viewFactory:checkbox {title = 'Enable Log', value = bind 'isLog',},
				--viewFactory:checkbox {title = 'Remove after process', value = bind 'isRemove',},
				viewFactory:checkbox {title = 'Force update', value = bind 'isForced',},
			},
		},
	}
end

return PluginInfo
