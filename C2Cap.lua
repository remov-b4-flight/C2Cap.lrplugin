--[[-------------------------------------------------------
@file	C2Cap.lua
@brief	this is main part of C2Cap.lrplugin
@author	remov-b4-flight
---------------------------------------------------------]]

local PluginTitle='C2Cap'
local LrApplication = import 'LrApplication'
local LrTasks = import 'LrTasks'
local LrProgress= import 'LrProgressScope'
local prefs = import 'LrPrefs'.prefsForPlugin()

local CurrentCatalog = LrApplication:activeCatalog()
local CurrentSelectionArray = CurrentCatalog:getActiveSources()

if (#CurrentSelectionArray > 1) then
	return
end

local currSelection = CurrentSelectionArray[1]

if (currSelection.type() ~= 'LrCollection') then
	return
end
--Main part of this plugin.
LrTasks.startAsyncTask( function ()
	if (currSelection:isSmartCollection()) then 
		return
	end
	local CollectionName = currSelection:getName()
	local ProgressBar = LrProgress({title = 'Processing Collection : ' .. CollectionName})
	local currPhotos = CurrentCatalog:findPhotos {
		searchDesc = {
			{
				criteria = "caption",
				operation = "empty",
				value = "",
				value2 = "",
			},{
				criteria = "collection",
				operation = "any",
				value = CollectionName,
				value2 = "",
			},
			combine = "intersect",
		},
	}

	local countPhotos = #currPhotos
	local CompleteFlag = 0
	CurrentCatalog:withWriteAccessDo('Set Caption',function()
		--loops photos in collection
		for i,PhotoIt in ipairs(currPhotos) do
				PhotoIt:setRawMetadata('caption',CollectionName)
			ProgressBar:setPortionComplete(i,countPhotos)
		end --end of for photos loop
		CompleteFlag = 1
	end ,
	-- a block called by write access can't get
	{ timeout = 0,
		callback = function() CompleteFlag = 0 end }
	) -- end of withWriteAccessDo function()
	ProgressBar:done()

	-- Revert back to prefs.RevertTo
	if prefs.isRevert and CompleteFlag == 1 then
		local collections = CurrentCatalog:getChildCollections()
		for i,ColIt in ipairs(collections) do
			if ColIt:getName()==prefs.RevertTo then
				CurrentCatalog:setActiveSources(ColIt)
				break
			end
		end
	end
end ) --end of startAsyncTask function()
return
