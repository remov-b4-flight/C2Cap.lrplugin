--[[
C2Cap.lua
this is main part of C2Cap.lrplugin
Author:@jenoki48
--]]

local PluginTitle='C2Cap'
local C2Application = import 'LrApplication'
local PhLogger = import 'LrLogger'
local C2Tasks = import 'LrTasks'
local C2Progress= import 'LrProgressScope'
local C2Logger = PhLogger (PluginTitle)
local prefs = import 'LrPrefs'.prefsForPlugin()

if prefs.isLog then 
	C2Logger:enable('logfile')
end
C2Logger:info(PluginTitle ..' START')
--if prefs.isRemove then C2Logger:info('isRemove=true') end
if prefs.isForced then C2Logger:info('isForced=true') end

local CurrentCatalog = C2Application:activeCatalog()
local CurrentSelectionArray = CurrentCatalog:getActiveSources()

-- error if multiply selected --
if (#CurrentSelectionArray > 1) then
	C2Logger:error('Multiple Selections are not supported.')
	return
end

local currSelection=CurrentSelectionArray[1]

C2Logger:debug('Target type='..currSelection:type())
if (currSelection.type() ~= 'LrCollection') then
	C2Logger:error('This is not a Collection.')
	return
end

--Main part of this plugin.
C2Tasks.startAsyncTask( function ()
	--error if smart album selected.
	if (currSelection:isSmartCollection()) then 
		C2Logger:error('Smart Collection is ignored.')
		return
	end
	local CollectionName = currSelection:getName()
	local ProgressBar = C2Progress({
		title = 'Processing Collection : ' .. CollectionName
	})
	C2Logger:debug('Target collection='..CollectionName)
	local currPhotos = currSelection:getPhotos()
	local countPhotos = #currPhotos
	CurrentCatalog:withWriteAccessDo('Set Caption',function()
		--loops photos in collection
		for i,PhotoIt in ipairs(currPhotos) do
			C2Logger:debug( i .. ":".. PhotoIt.localIdentifier)
			currCaption = PhotoIt:getFormattedMetadata('caption')
			C2Logger:debug(PhotoIt.localIdentifier .. " is now captioned as " .. currCaption)
			if ( prefs.isForced or currCaption=="" ) then
					PhotoIt:setRawMetadata('caption',CollectionName)
					C2Logger:debug(PhotoIt.localIdentifier .. " is set caption to " .. CollectionName)
			end
			ProgressBar:setPortionComplete(i,countPhotos)
		end --end of for photos loop
		ProgressBar:done()
	end ) -- end of withWriteAccessDo function()
end ) --end of startAsyncTask function()
return
