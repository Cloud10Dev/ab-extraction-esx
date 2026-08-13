local ESX=exports.es_extended:getSharedObject(); local data={items={}}; local round=false
local function open() SetNuiFocus(true,true); SendNUIMessage({action='open',data=data,grid=Config.Grid,items=Config.Item}) end
RegisterCommand('inventory',open); RegisterKeyMapping('inventory','Open grid inventory','keyboard','TAB')
RegisterCommand('solo',function() TriggerServerEvent('ab:queue','solo') end); RegisterCommand('duo',function() TriggerServerEvent('ab:queue','duo') end); RegisterCommand('squad',function() TriggerServerEvent('ab:queue','squad') end); RegisterCommand('extract',function() if round then TriggerServerEvent('ab:extract') end end)
RegisterNetEvent('ab:refresh',function(d) data=d; SendNUIMessage({action='data',data=d}) end)
RegisterNetEvent('ab:round',function(pos) round=true; SetEntityCoords(PlayerPedId(),pos.x,pos.y,pos.z); ESX.ShowNotification('Operation started. Use /extract to return.') end)
RegisterNetEvent('ab:returned',function(d) round=false; data=d; local p=Config.Lobby; SetEntityCoords(PlayerPedId(),p.x,p.y,p.z); ESX.ShowNotification('Extraction successful: +100 XP') end)
RegisterNUICallback('close',function(_,cb) SetNuiFocus(false,false); cb('ok') end)
RegisterNUICallback('drop',function(d,cb) TriggerServerEvent('ab:drop',d.index,d.count); cb('ok') end)
CreateThread(function() ESX.TriggerServerCallback('ab:getData',function(d) data=d end) end)