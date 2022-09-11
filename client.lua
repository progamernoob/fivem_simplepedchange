RegisterCommand('setmodel', function(source, args, showError)
	if not args[1] then 
		print "Nothing ommited, setting default"
		args[1] = "mp_m_freemode_01" 
	end
	
	local function SetModel(newped, cb)
		local playerPed = PlayerPedId()
		local newmodel = GetHashKey(newped)
		print ('Trying to set ' .. newped)

		CreateThread(function()
			while not HasModelLoaded(newmodel) do
				RequestModel(newmodel)
				Wait(0)
			end

			if IsModelValid(newmodel) and Citizen.InvokeNative(0x75816577FEA6DAD5, newmodel) and IsModelInCdimage(newmodel) then
				print "Model is valid"
				SetPlayerModel(PlayerId(), newmodel)
				SetPedDefaultComponentVariation(PlayerPedId())
			else
				print "Model invalid"
			end

			if cb ~= nil then
				cb()
			end

		end)
	end
	SetModel(args[1], cb)
end, false)

