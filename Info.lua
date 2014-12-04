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
		{title = 'C2Cap',
		file = 'C2Cap.lua',
		enabledWhen = 'photosAvailable',},
	},
	LrPluginInfoProvider = 'PluginInfo.lua',
	LrInitPlugin = 'PluginInit.lua',

	VERSION = { major=1, minor=0, revision=0, build=0, },

}
