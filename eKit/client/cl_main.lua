ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)



local Main = RageUI.CreateMenu("Kit", "Interaction", nil, nil, 'root_cause5', "img_jaune")
local open = false
Main.Display.Header = true
Main.Closed = function()
    open = false
	FreezeEntityPosition(PlayerPedId(), false)
end

function OpenMenu() 
    if open then 
		open = false
		RageUI.Visible(Main, false)
		return
	else
		open = true 
		RageUI.Visible(Main, true)
		FreezeEntityPosition(PlayerPedId(), true)
		CreateThread(function()
		while open do 
        RageUI.IsVisible(Main, function()
            

			RageUI.Button("~"..Config.CouleurMenu.."~→~s~ Prendre votre kit de depart", nil, {RightBadge = RageUI.BadgeStyle.Tick}, true, {
				onSelected = function()
					TriggerServerEvent("eKit:verif")
				end
			})

        end)
        Wait(0)
    end
    end)
    end
end

RegisterNetEvent("eKit:good")
AddEventHandler("eKit:good", function()

	if Config.Item then
		for k, v in pairs(Config.ListeItem) do
			TriggerServerEvent("eKit:giveitem", v.name, v.nombre)
		end
	end
	
	if Config.Argent then
		for k, v in pairs(Config.ListeArgent) do
			TriggerServerEvent("eKit:givemoney", v.type, v.nombre)
		end
	end
	
	if Config.Armes then
		for k, v in pairs(Config.ListeArmes) do
			TriggerServerEvent("eKit:giveweapon", v.weapon)
		end
	end
	
	TriggerServerEvent("eKit:kitprit")
	ESX.ShowNotification("~g~Vous avez recu votre kit de bienvenue.")

end)

Citizen.CreateThread(function()
	while true do 
		local wait = 70
		local PedPos = GetEntityCoords(PlayerPedId())
  
		for k,v in pairs(Config.PositionPed) do
			if #(PedPos - v.pos) < 5 then
				wait = 0
				if #(PedPos - v.pos) < 1.5 then
					ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour acceder a votre kit")
					if IsControlJustPressed(0, 51) then
					  OpenMenu()
					end
				end
			end
		end
		Citizen.Wait(wait)
	end
end)

Citizen.CreateThread(function()
	if Config.ActiveBlips then
		for k, v in pairs(Config.PositionBlips) do
			local blip = AddBlipForCoord(v.pos)

			SetBlipSprite(blip, Config.Blips.Id)
			SetBlipScale (blip, Config.Blips.Taille)
			SetBlipColour(blip, Config.Blips.Couleur)
			SetBlipAsShortRange(blip, Config.Blips.Range)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentSubstringPlayerName(Config.Blips.Name)
			EndTextCommandSetBlipName(blip)
		end
	end
end)

Citizen.CreateThread(function()
	if Config.ActivePeds then
		for k,v in pairs(Config.PositionPed) do
			local HashPed = GetHashKey(Config.HashPed)
			while not HasModelLoaded(HashPed) do
			RequestModel(HashPed)
			Wait(20)
			end

			Ped = CreatePed("PED_TYPE_CIVMALE", HashPed, v.pos, false, true)
			SetBlockingOfNonTemporaryEvents(Ped, true)
			FreezeEntityPosition(Ped, true)
			SetEntityInvincible(Ped, true)
			SetEntityHeading(Ped, tonumber(v.heading))


		end
	end
end)
