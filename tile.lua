local clean_topic = ""
local color = {0,0,0}

local M = {}

local function parse_rgb(hex)
    hex = hex:gsub("#","")
    return {tonumber("0x"..hex:sub(1,2))/255, tonumber("0x"..hex:sub(3,4))/255, tonumber("0x"..hex:sub(5,6))/255}
end

function M.task(starts, ends, tileconfig, x1, y1, x2, y2)
    clean_topic = tileconfig.mqtt_topic:gsub("[^A-Za-z0-9]", "_")
    print("now listening for path", clean_topic)

    local bg = resource.create_colored_texture(color[1], color[2], color[3], 1)

    for now in api.frame_between(starts, ends) do
        bg:draw(x1, y1, x2, y2)
    end

    bg:dispose()
end

function M.data_trigger(path, data)
    if path ~= clean_topic then
        print("ignoring data on path", path)
        return
    end
    print("got color update", data)
    color = parse_rgb(data)
end

function M.can_show(tileconfig)
    if tileconfig.mqtt_topic == "" then
        return false
    else
        return true
    end
end

return M
