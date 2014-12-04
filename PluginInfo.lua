--[[----------------------------------------------------------------------------

PluginInfo.lua

Responsible for managing the dialog entry in the Plugin Manager dialog window which
manages the individual plug-ins installed in the Lightroom application.

This will create a section in the Plugin Manager Dialog window.  This example creates a
label and button that when clicked launches a browser window and opens http://www.adobe.com

--------------------------------------------------------------------------------

ADOBE SYSTEMS INCORPORATED
 Copyright 2008 Adobe Systems Incorporated
 All Rights Reserved.

NOTICE: Adobe permits you to use, modify, and distribute this file in accordance
with the terms of the Adobe license agreement accompanying it. If you have received
this file from a source other than Adobe, then your use, modification, or distribution
of it requires the prior written permission of Adobe.

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
