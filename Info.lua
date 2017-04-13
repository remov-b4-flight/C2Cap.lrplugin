--[[----------------------------------------------------------------------------
Info.lua
C2Cap.lrplugin
Author:@jenoki48
------------------------------------------------------------------------------]]

return {

	LrSdkVersion = 3.0,

	LrToolkitIdentifier = 'nu.mine.ruffles.c2cap',
	LrPluginName = 'C2Cap',
	LrPluginInfoUrl='https://twitter.com/jenoki48',
	LrLibraryMenuItems = { 
		{title = 'Collection',
		file = 'C2Cap.lua',},
	},
	LrPluginInfoProvider = 'PluginInfo.lua',
	LrInitPlugin = 'PluginInit.lua',

	VERSION = { major=1, minor=1, revision=3, build=0, },

}
