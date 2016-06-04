--- 3DSK Internal Server.
-- This manages the TCP sockets
-- @module InternalServer
local InternalServer = {}

local ctr = require("ctr")
local socket = require("ctr.socket")
local screenManager = require("Modules/ScreenManager")

-- True when connected to a PC
InternalServer.Connected = false
-- Connection Metadata
InternalServer.Connection = {
    IpAddress = "",
    ComputerName = "",
    UDPPort = 0,
}
-- Underlying Sockets
InternalServer._connection = socket.tcp()
InternalServer._tcpClients = {}

function InternalServer:Init()
    self._connection:bind(5000)
    self._connection:listen()
end

function InternalServer:WaitForConnection()
    -- Accept all connections
    local c = self._connection:accept()
    -- Remove the trash
    if table.getn(self._tcpClients) > 16 then self._tcpClients = {} end
    -- Insert the new client
    if c ~= nil then
        table.insert(self._tcpClients, c)
        print("New Client: "..c:getpeername())
    end
    -- Respond to client packets
    for client in ipairs(self._tcpClients) do
        local d = client:receive("a")
        -- Ping packets
        if string.byte(d) == 0 then
            client:send(string.char(1)) -- Ping Reply
        end
        -- Connection Request
        if string.byte(d) == 3 then
            -- TODO: Reply with console metadata and establish connection
        end
    end
end

return InternalServer
