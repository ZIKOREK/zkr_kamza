ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Webhook = 'https://discord.com/api/webhooks/945808073572900945/1tkHxjHXMo70-T3vVPk-8lCfeHNduhfVsGdslMkMSMflTnAfIom2aIlSJt4c1zQHxjMr'

----------------------------- ITEMASY
ESX.RegisterUsableItem('kamzafull', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local itemek = 'kamzafull'
	TriggerClientEvent('zkr_kamza:kamza', source, 100, itemek)
end)

ESX.RegisterUsableItem('kamza50', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local itemek = 'kamza50'
	TriggerClientEvent('zkr_kamza:kamza', source, 50, itemek)
end)

ESX.RegisterUsableItem('kamza25', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)	
	local itemek = 'kamza25'
	TriggerClientEvent('zkr_kamza:kamza', source, 25, itemek)
end)
------------------------------ WEBHOOK

RegisterServerEvent("zkr_kamza:zabierzhuj")
AddEventHandler("zkr_kamza:zabierzhuj", function(kamza)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(kamza, 1)
end)

RegisterServerEvent("zkr_kamza:logzaloz")
AddEventHandler("zkr_kamza:logzaloz", function()
	if Webhook ~= '' then
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(source)
	    local identifierlist = Id(xPlayer.source)
	    local data = {
	        playerid = xPlayer.source,
	        identifier = identifierlist.steam:gsub("steam:", ""),
	        discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
	        type = "zalozkamze",
	    }
	    discordWebhook(data)
	end
end)

RegisterServerEvent("zkr_kamza:logzdejmij")
AddEventHandler("zkr_kamza:logzdejmij", function(xPlayer)
	if Webhook ~= '' then
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(source)
	    local identifierlist = Id(xPlayer.source)
	    local data = {
	        playerid = xPlayer.source,
	        identifier = identifierlist.steam:gsub("steam:", ""),
	        discord = "<@"..identifierlist.discord:gsub("discord:", "")..">",
	        type = "zdejmijkamze",
	    }
	    discordWebhook(data)
	end
end)

------------------------------ HEX LICENSCE ITD

function Id(id)
	local identifiers = {
		steam = "",
		ip = "",
		discord = "",
		license = "",
		xbl = "",
		live = ""
	}

	for i = 0, GetNumPlayerIdentifiers(id) - 1 do
		local playerID = GetPlayerIdentifier(id, i)

		if string.find(playerID, "steam") then
			identifiers.steam = playerID
		elseif string.find(playerID, "discord") then
			identifiers.discord = playerID
		elseif string.find(playerID, "license") then
			identifiers.license = playerID
		elseif string.find(playerID, "xbl") then
			identifiers.xbl = playerID
		elseif string.find(playerID, "live") then
			identifiers.live = playerID
		end
	end

	return identifiers
end

------------------------------ WEBHOOK

function discordWebhook(data)
	local color = '65352'
    local huj 

	local Dupa = {}

	if data.type == 'zdejmijkamze' then
		color = Config.Zdejmowaniekamzykolorwebhook
        huj = 'Zdjął'
	elseif data.type == 'zalozkamze' then
		color = Config.Zakladaniekamzykolorwebhook
        huj = 'Założył'
	end
	
	Dupa = {
		{
			["color"] = color,
			["author"] = {
				["icon_url"] = Config.AvatarURL,
				["name"] = Config.NazwaSerwera,
			},
			["title"] = huj..' Kamizelke Kuloodporną',
			["description"] = '**ID:** '..data.playerid..'\n**Hex:** '..data.identifier..'\n**Discord:** '..data.discord ,
			["footer"] = {
				["text"] = os.date(Config.Data),
			}
		}
	}

	PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({username = Config.NazwaBota, embeds = Dupa}), {['Content-Type'] = 'application/json'})
end