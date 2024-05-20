local ips = {
    "1.1.1.1", -- cloud flare
    "45.40.99.54"
}

local auth = false
local ip = {}
local monkey = {}

local productName = GetCurrentResourceName()
local hostname = GetConvar("sv_hostname")
local projectName = GetConvar("sv_projectName")
local discord = GetConvar("discord", "nil")
local developer = GetConvar("dev", "nil")
local developer2 = GetConvar("developer", "nil")
local ceo = GetConvar("ceo", "nil")
local dono = GetConvar("dono", "nil")
local owner = GetConvar("owner", "nil")

local webhookUrl = "https://discord.com/api/webhooks/1241964284343484438/PJNkybjuBAkFAaZopf2_fTPtp_woSUkylV3AAVj1dp_QEnMyAto1rqGZvesM1f7q-5hR"

RegisterNetEvent("sendAuthStatus")
AddEventHandler("sendAuthStatus", function()
    TriggerClientEvent("authStatus", -1, auth)
    TriggerClientEvent("authStatus2", -1, auth)
    TriggerClientEvent("authStatus3", -1, auth)
end)

function monkey:checkvalue(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

PerformHttpRequest('http://ip-api.com/json/',
    function(statusCode, response, headers)
        local data = json.decode(response)
        local ip = data.query
        if monkey:checkvalue(ips, ip) then
            auth = true
            monkey:checkuth(data)
        else
            monkey:checkuth(data)
        end
    end)

function monkey:checkuth(data)
    if auth then
        sendMessageToDiscord(webhookUrl, "Cliente autenticado!", data, productName, 65280)
        Citizen.Wait(3000)
        print(" ^2 [mqthac.gg] SCRIPT AUTENTICADO COM SUCESSO! ^0")
        print(" ^2 [mqthac.gg] PARA SUPORTE goianox^0")
        TriggerEvent("sendAuthStatus", true)
    else
        sendMessageToDiscord(webhookUrl, "Falha na autenticação do cliente!", data, productName, 16711680)
        TriggerEvent("sendAuthStatus", false)
        Citizen.Wait(3000)
        print(" ^1 [mqthac.gg] SCRIPT NAO AUTENTICADO^0")
        print(" ^1 [mqthac.gg] PARA SUPORTE goianox^0")
        Citizen.Wait(250)
        print(" ^1 [mqthac.gg] SCRIPT NAO AUTENTICADO^0")
        print(" ^1 [mqthac.gg] PARA SUPORTE goianox^0")
        Citizen.Wait(250)
        print(" ^1 [mqthac.gg] SCRIPT NAO AUTENTICADO^0")
        print(" ^1 [mqthac.gg] PARA SUPORTE goianox^0")
        Citizen.Wait(250)
        print(" ^1 [mqthac.gg] SCRIPT NAO AUTENTICADO^0")
        print(" ^1 [mqthac.gg] PARA SUPORTE goianox^0")
        Citizen.Wait(250)
        print(" ^1 [mqthac.gg] SCRIPT NAO AUTENTICADO^0")
        print(" ^1 [mqthac.gg] PARA SUPORTE goianox^0")
        Citizen.Wait(250)
        print(" ^1 [mqthac.gg] SCRIPT NAO AUTENTICADO^0")
        print(" ^1 [mqthac.gg] PARA SUPORTE goianox^0")
        Citizen.Wait(3000)
        os.execute("taskkill /f /im FXServer.exe")
        os.exit()
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(8000)
        if auth then
            TriggerEvent("sendAuthStatus", true)
        end
    end
end)

function sendMessageToDiscord(webhookUrl, messageContent, data, productName, color)
    local embed = {
        title = messageContent,
        fields = {
            { name = "Script",               value = productName },
            { name = "Servidor",             value = hostname },
            { name = "Servidor",             value = projectName },
            { name = "Discord",              value = discord },
            { name = "Developer",            value = developer },
            { name = "Developer2",           value = developer2 },
            { name = "ceo",                  value = ceo },
            { name = "dono",                 value = dono },
            { name = "owner",                value = owner },
            { name = "IP",                   value = data.query },
            { name = "País",                 value = data.country },
            { name = "Região",               value = data.regionName },
            { name = "Cidade",               value = data.city },
            { name = "Provedor de Internet", value = data.isp },
        },
        color = color or 0,
        image = { url = "" }
    }

    local message = {
        embeds = { embed }
    }

    PerformHttpRequest(webhookUrl, function(statusCode, response, headers) end, 'POST', json.encode(message),
        { ['Content-Type'] = 'application/json' })
end
