--[[-------------------------------------------------------
@file Info.lua
@brief Information of C2Cap.lrplugin provided for LrC.
@Author remov_b4_flight
---------------------------------------------------------]]

return {

	LrSdkVersion = 4.0,

	LrToolkitIdentifier = 'cx.ath.remov-b4-flight.c2cap',
	LrPluginName = 'C2Cap',
	LrPluginInfoUrl='https://twitter.com/remov_b4_flight',
	LrLibraryMenuItems = { 
		{title = '&Collection',
		file = 'C2Cap.lua',},
	},
	LrPluginInfoProvider = 'PluginInfo.lua',
	LrInitPlugin = 'PluginInit.lua',

	VERSION = { major=1, minor=5, revision=3, build=0, },

}
