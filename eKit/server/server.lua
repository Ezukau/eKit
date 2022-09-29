ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function sendToDiscordWithSpecialURL(Color, Title, Description)
	local Content = {
	        {
	            ["color"] = Color,
	            ["title"] = Title,
	            ["description"] = Description,
		        ["footer"] = {
	            ["text"] = "Server Logs",
	            ["icon_url"] = nil,
	            },
	        }
	    }
	PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({username = Name, embeds = Content}), { ['Content-Type'] = 'application/json' })
end

local kit = 0
RegisterNetEvent("eKit:verif")
AddEventHandler("eKit:verif", function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local ident = xPlayer.getIdentifier()

    MySQL.Async.fetchAll("SELECT kit FROM users WHERE identifier = '"..ident.."'", {}, function(result)
        if (result) then
            for k, v in pairs(result) do
                kit = v.kit
            end

            if kit == 1 then 
                TriggerClientEvent('esx:showNotification', source, "~r~Vous avez deja recuperer votre kit.")
            elseif kit == 0 then 
                TriggerClientEvent("eKit:good", source)
            end
        end
        
    end)

end)

RegisterNetEvent("eKit:giveitem")
AddEventHandler("eKit:giveitem", function(name, nombre)
    local source = source
    xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem(name, nombre)
end)

RegisterNetEvent("eKit:givemoney")
AddEventHandler("eKit:givemoney", function(type, nombre)
    local source = source
    xPlayer = ESX.GetPlayerFromId(source)

    if type == "cash" then
        xPlayer.addMoney(nombre)
    end

    if type == "bank" then
        xPlayer.addAccountMoney("bank", nombre)
    end

    if type == "black_money" then 
        xPlayer.addAccountMoney("black_money", nombre)
    end

end)

RegisterNetEvent("eKit:giveweapon")
AddEventHandler("eKit:giveweapon", function(weapon)
    local source = source
    xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addWeapon(weapon, 250)
end)

RegisterNetEvent("eKit:kitprit")
AddEventHandler("eKit:kitprit", function()
    local source = source
    xPlayer = ESX.GetPlayerFromId(source)
    local ident = xPlayer.getIdentifier()
    local name = xPlayer.getName()
    local newKit = 1
    local date = os.date('*t')
	if date.day < 10 then date.day = '0' .. tostring(date.day) end
	if date.month < 10 then date.month = '0' .. tostring(date.month) end
	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

    MySQL.Async.execute("UPDATE users SET kit = "..newKit.." WHERE identifier = '"..ident.."'", {}, function()
    end)
    sendToDiscordWithSpecialURL(0, "Kit de bienvenue", "Ientifier: ```"..ident.."``` \n Joueur: ```"..name.."``` \n Date: ```"..date.day.."/"..date.month.."/"..date.year.." à "..date.hour.."h"..date.min.."min"..date.sec.."s```")

end)