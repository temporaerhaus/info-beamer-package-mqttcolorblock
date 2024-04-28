local clean_topic = ""
local bg = resource.create_colored_texture(0, 0, 0, 1)

local M = {}

function parse_rgb(hex)
    hex = hex:gsub("#","")
    return {tonumber("0x"..hex:sub(1,2))/255, tonumber("0x"..hex:sub(3,4))/255, tonumber("0x"..hex:sub(5,6))/255}
end

function M.task(starts, ends, tileconfig, x1, y1, x2, y2)
    clean_topic = tileconfig.mqtt_topic:gsub("[^A-Za-z0-9]", "_")
    print("now listening for path", "root/plugin/colorblock/" .. clean_topic)

    return bg:draw(x1, y1, x2, y2)
end

function M.data_trigger(path, data)
    local my_path = "root/plugin/colorblock/" .. clean_topic
    if path ~= my_path then
        print("ignoring data on path", path)
        return
    end
    print("got color update", data)
    color = parse_rgb(data)
    print("thats color", color)
    bg:dispose()
    bg = resource.create_colored_texture(color[1], color[2], color[3], 1)
end

function M.can_show(tileconfig)
    if tileconfig.mqtt_topic == "" then
        return false
    else
        return true
    end
end

return M
