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
local Threshold = 15

if (#CurrentSelectionArray > 1) then
	return
end
-- get 1st value of array
local currSelection = CurrentSelectionArray[1]

if (currSelection == nil) then 
	return
-- Check selected collection is not kAllPhotos,k** .. etc.
elseif (type(currSelection) == "string") then
	return
elseif (currSelection.type() ~= 'LrCollection') then
	return
end

--Main part of this plugin.
LrTasks.startAsyncTask( function ()
	if (currSelection:isSmartCollection()) then 
		return
	end
	local CollectionName = currSelection:getName()
	local ProgressBar = LrProgress({title = LOC '$$$/c2cap/processing=Processing Collection : ' .. CollectionName})
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
		local photocount = 0
		local RevertCol,RevertCol2nd
		for i,ColIt in ipairs(collections) do
			if ColIt:getName() == prefs.RevertTo then
				local tempArray = ColIt:getPhotos()
				photocount = #tempArray
				RevertCol = ColIt
				if Threshold <= photocount then
					RevertCol2nd = ColIt
				end
			elseif ColIt:getName() == prefs.Revert2nd then
				RevertCol2nd = ColIt
			end
			if RevertCol ~= nil and RevertCol2nd ~= nil then
				break
			end
		end
		if Threshold <= photocount then
			CurrentCatalog:setActiveSources(RevertCol)
		else
			CurrentCatalog:setActiveSources(RevertCol2nd)
		end
	end
end ) --end of startAsyncTask function()
return
