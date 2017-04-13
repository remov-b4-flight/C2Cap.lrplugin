--[[
C2Cap.lua
this is main part of C2Cap.lrplugin
Author:@jenoki48
--]]

local PluginTitle='C2Cap'
local C2Application = import 'LrApplication'
local C2Tasks = import 'LrTasks'
local C2Progress= import 'LrProgressScope'
--local LrLogger = import 'LrLogger'
--local C2Logger = LrLogger (PluginTitle)
local prefs = import 'LrPrefs'.prefsForPlugin()

--if prefs.isLog then 
--	C2Logger:enable('logfile')
--end
--C2Logger:info(PluginTitle ..' START')
--if prefs.isRevert then C2Logger:info('isRevert=true') end
--if prefs.isForced then C2Logger:info('isForced=true') end

local CurrentCatalog = C2Application:activeCatalog()
local CurrentSelectionArray = CurrentCatalog:getActiveSources()

-- error if multiply selected --
if (#CurrentSelectionArray > 1) then
--	C2Logger:error('Multiple Selections are not supported.')
	return
end

local currSelection=CurrentSelectionArray[1]

--C2Logger:debug('Target type='..currSelection.type())
if (currSelection.type() ~= 'LrCollection') then
--	C2Logger:error('This is not a Collection.')
	return
end

--Main part of this plugin.
C2Tasks.startAsyncTask( function ()
	--error if smart album selected.
	if (currSelection:isSmartCollection()) then 
--		C2Logger:error('Smart Collection is ignored.')
		return
	end
	local CollectionName = currSelection:getName()
	local ProgressBar = C2Progress({
		title = 'Processing Collection : ' .. CollectionName
	})
--	C2Logger:debug('Target collection='..CollectionName)
	local currPhotos = currSelection:getPhotos()
	local countPhotos = #currPhotos
	local CompleteFlag = 0
	CurrentCatalog:withWriteAccessDo('Set Caption',function()
		--loops photos in collection
		for i,PhotoIt in ipairs(currPhotos) do
--			C2Logger:debug( i .. ":".. PhotoIt.localIdentifier)
			currCaption = PhotoIt:getFormattedMetadata('caption')
--			C2Logger:debug(PhotoIt.localIdentifier .. " is now captioned as " .. currCaption)
			if ( prefs.isForced or currCaption=="" ) then
					PhotoIt:setRawMetadata('caption',CollectionName)
--					C2Logger:debug(PhotoIt.localIdentifier .. " is set caption to " .. CollectionName)
			end
			ProgressBar:setPortionComplete(i,countPhotos)
		end --end of for photos loop
		CompleteFlag = 1
	end ,{timeout = 0 ,
		callback = function() 
--			C2Logger:debug("withWriteAccessDo() Timed out. " .. CollectionName)
			CompleteFlag = 0
		end
	}) -- end of withWriteAccessDo function()
	ProgressBar:done()

	-- Revert back to prefs.RevertTo
	if prefs.isRevert and CompleteFlag == 1 then
		local collections = CurrentCatalog:getChildCollections()
--		C2Logger:debug('Revert back')
--		C2Logger:debug(collections)
		for i,ColIt in ipairs(collections) do
--			C2Logger:debug(ColIt:getName())
			if ColIt:getName()==prefs.RevertTo then
				CurrentCatalog:setActiveSources(ColIt)
			end
		end
	end
--C2Logger:debug("startAsyncTask( function() end.")
end ) --end of startAsyncTask function()
return
