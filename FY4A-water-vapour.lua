-- FY4A水汽
local Api = require("coreApi")
local http = require("http")

function ReceiveFriendMsg(CurrentQQ, data) return 1 end
function ReceiveEvents(CurrentQQ, data, extData) return 1 end

function ReceiveGroupMsg(CurrentQQ, data)
    if data.FromUserId == tonumber(CurrentQQ) then
        return 1
    end

    if data.Content:find('4a水汽') or data.Content:find('4A水汽') then
        local resp = http.request('GET', 'http://m.nmc.cn/publish/satellite/FY4A-water-vapour.htm')
        if resp ~= nil then
            local body = resp.body
            local url = body:match([[data%-src="(.-)".+<div class=swiper%-button%-prev>]])
            print(url)
            if url ~= nil then
                Api.Api_SendMsg(
                    CurrentQQ,
                    {
                        toUser = data.FromGroupId,
                        sendToType = 2,
                        sendMsgType = "PicMsg",
                        content = '',
                        groupid = 0,
                        atUser = 0,
                        picUrl = url,
                        picBase64Buf = "",
                        fileMd5 = ""
                    }
                )
                return 2
            end
        end
    end
    return 1
end

