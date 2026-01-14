--[[-------------------------------------------------------
@file	C2Cap.lua
@brief	this is main part of C2Cap.lrplugin
@author	remov-b4-flight
---------------------------------------------------------]]

local LrApplication = import 'LrApplication'
local LrTasks = import 'LrTasks'
local LrProgress= import 'LrProgressScope'
local prefs = import 'LrPrefs'.prefsForPlugin()
local Info = require 'Info'

local CurrentCatalog = LrApplication:activeCatalog()
local CurrentSelectionArray = CurrentCatalog:getActiveSources()
local TIMEOUT = 0.25
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

-- Main part of this plugin.
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
	CurrentCatalog:withWriteAccessDo(Info.LrPluginName, function()
		-- loops photos in collection
		for i,PhotoIt in ipairs(currPhotos) do
			-- It's omitted 'ProgressBar:isCancelled()' check for speedup.
			PhotoIt:setRawMetadata('caption',CollectionName)
			ProgressBar:setPortionComplete(i,countPhotos)
		end -- end of for photos loop
		CompleteFlag = 1
	end ,
	-- a block called by write access can't get
	{ 	timeout = TIMEOUT,
		callback = function() CompleteFlag = 0 end,
		asynchronous = true
	}
	) -- end of withWriteAccessDo function()
	ProgressBar:done()

	-- Revert back to prefs.RevertTo
	if (prefs.isRevert and CompleteFlag == 1) then
		local RevertCol = CurrentCatalog:getCollectionByLocalIdentifier(prefs.RevertColID)
		if RevertCol == nil then
			return
		end
		local photocount = #RevertCol:getPhotos()
		if Threshold <= photocount then
			CurrentCatalog:setActiveSources(RevertCol)
		else
			local RevertCol2nd = CurrentCatalog:getCollectionByLocalIdentifier(prefs.RevertColID2nd)
			if RevertCol2nd == nil then
				return
			end
			CurrentCatalog:setActiveSources(RevertCol2nd)
		end
	end
end ) -- end of startAsyncTask function()
return
