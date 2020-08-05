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
	propertyTable.isRevert = prefs.isRevert
	propertyTable.RevertTo = prefs.RevertTo
end

function PluginInfo.endDialog( propertyTable ,why )
	prefs.isRevert = propertyTable.isRevert
	prefs.RevertTo = propertyTable.RevertTo
end

function PluginInfo.sectionsForTopOfDialog( viewFactory, propertyTable )
	return {
		{
			title = 'C2Cap',
			synopsis = 'Set caption to collection name contained by.',
			bind_to_object = propertyTable,
			viewFactory:row {
				viewFactory:checkbox {title = 'Revert Back', value = bind 'isRevert',},
				viewFactory:edit_field {title = 'Collection', value = bind 'RevertTo',},
			},
		},
	}
end

return PluginInfo
