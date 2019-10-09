--[[----------------------------------------------------------------------------
Info.lua
C2Cap.lrplugin
Author:@remov_b4_flight
------------------------------------------------------------------------------]]

return {

	LrSdkVersion = 3.0,

	LrToolkitIdentifier = 'nu.mine.ruffles.c2cap',
	LrPluginName = 'C2Cap',
	LrPluginInfoUrl='https://twitter.com/remov_b4_flight',
	LrLibraryMenuItems = { 
		{title = '&Collection',
		file = 'C2Cap.lua',},
	},
	LrPluginInfoProvider = 'PluginInfo.lua',
	LrInitPlugin = 'PluginInit.lua',

	VERSION = { major=1, minor=1, revision=4, build=0, },

}
