local settings = {
	cache = {},
    cache_used = {},
	timer = {
		[1] = -1,
	}
}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
	job = PlayerData.job
end)

RegisterNetEvent('zkr_kamza:kamza')
AddEventHandler('zkr_kamza:kamza', function(ilekamzy, itemek)
	local ped = GetPlayerPed(-1)
	local armorteraz = 	GetPedArmour(ped)
	if GetGameTimer() > settings.timer[1] then
		if armorteraz >= 1 then
			TriggerServerEvent('zkr_kamza:zabierzhuj', itemek)
			loadAnimDict("move_m@_idles@shake_off")
			TaskPlayAnim(ped, "move_m@_idles@shake_off", "shakeoff_1", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			exports['zkr_progbar']:startUI(3000, 'Ściągasz aktualnie ubraną kamizelke kuloodporną...')	
			Wait(3200)
			ClearPedTasksImmediately(ped)
			SetPedComponentVariation(GetPlayerPed(-1), 9, 0, 0, 0)
			TriggerServerEvent("zkr_kamza:logzdejmij")
			SetPedArmour(ped, 0)
			loadAnimDict("move_m@_idles@shake_off")
			TaskPlayAnim(ped, "move_m@_idles@shake_off", "shakeoff_1", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			exports['zkr_progbar']:startUI(5000, 'Zakładasz kamizelke kuloodporną...')
			Wait(5200)
			ClearPedTasksImmediately(ped)
			SetPedComponentVariation(GetPlayerPed(-1), 9, 26, 9, 9)
			SetPedArmour(ped, ilekamzy)
			TriggerServerEvent("zkr_kamza:logzaloz")
			settings.timer[1] = GetGameTimer() + 30000
		else
			TriggerServerEvent('zkr_kamza:zabierzhuj', itemek)
			loadAnimDict("move_m@_idles@shake_off")
			TaskPlayAnim(ped, "move_m@_idles@shake_off", "shakeoff_1", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			exports['zkr_progbar']:startUI(5000, 'Zakładasz kamizelke kuloodporną...')
			Wait(5200)
			ClearPedTasksImmediately(ped)
			SetPedArmour(ped, ilekamzy)
			SetPedComponentVariation(GetPlayerPed(-1), 9, 26, 9, 9)
			TriggerServerEvent("zkr_kamza:logzaloz")
			settings.timer[1] = GetGameTimer() + 30000
		end
	else
		if Config.okokNotify then
			exports['okokNotify']:Alert('ZKRPACK', 'Nie możesz tak często zakładać kamizelki!', 5000, 'error')
		else 
			ESX.ShowNotification('Nie możesz tak często zakładać kamizelki!')
		end
	end
end)


RegisterCommand('zdejmijkamizelke', function()
	local ped = GetPlayerPed(-1)
	local armor = GetPedArmour(ped)
	if armor >= 1 then
		loadAnimDict("move_m@_idles@shake_off")
		TaskPlayAnim(ped, "move_m@_idles@shake_off", "shakeoff_1", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		exports['zkr_progbar']:startUI(3000, 'Ściągasz kamizelke kuloodporną...')	
		Wait(3200)
		ClearPedTasksImmediately(ped)
		SetPedComponentVariation(GetPlayerPed(-1), 9, 0, 0, 0)
		TriggerServerEvent("zkr_kamza:logzdejmij")
		SetPedArmour(ped, 0)
	else
		if Config.okokNotify then
			exports['okokNotify']:Alert('ZKRPACK', 'Nie masz ubranej kamizelki kuloodpornej', 5000, 'error')
		else 
			ESX.ShowNotification('Nie masz ubranej kamizelki kuloodpornej')
		end
	end
end, false)

function loadAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(100)
	end
end


