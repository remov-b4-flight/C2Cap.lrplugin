--[[----------------------------------------------------------------------------

Info.lua
MyMetadata.lrplugin

--------------------------------------------------------------------------------

ADOBE SYSTEMS INCORPORATED
 Copyright 2008-2010 Adobe Systems Incorporated
 All Rights Reserved.

NOTICE: Adobe permits you to use, modify, and distribute this file in accordance
with the terms of the Adobe license agreement accompanying it. If you have received
this file from a source other than Adobe, then your use, modification, or distribution
of it requires the prior written permission of Adobe.

------------------------------------------------------------------------------]]

return {

	LrSdkVersion = 3.0,

	LrToolkitIdentifier = 'nu.mine.ruffles.c2cap',
	LrPluginName = 'C2Cap',
	LrPluginInfoUrl='https://twitter.com/jenoki48',
	LrLibraryMenuItems = { 
		{title = 'C2Cap',
		file = 'C2Cap.lua',
		enabledWhen = 'photosAvailable',},
	},
	LrPluginInfoProvider = 'PluginInfo.lua',
	LrInitPlugin = 'PluginInit.lua',

	VERSION = { major=1, minor=0, revision=0, build=0, },

}
