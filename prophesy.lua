local ffi = require('ffi')
local bit = require('bit')
local vector = require("vector")
local antiaim_funcs = require('gamesense/antiaim_funcs')
local base64 = require('gamesense/base64')
local clipboard = require('gamesense/clipboard')
local images = require('gamesense/images')
local http = require('gamesense/http')
local ent = require ('gamesense/entity')
local client_screensize = client.screen_size
local client_draw_text = client.draw_text
local obex_data = obex_fetch and obex_fetch() or {username = 'admin', build = 'recode', discord=''}
local js = panorama.open()
local MyPersonaAPI, LobbyAPI, PartyListAPI, SteamOverlayAPI = js.MyPersonaAPI, js.LobbyAPI, js.PartyListAPI, js.SteamOverlayAPI
local data = obex_fetch and obex_fetch() or {username = 'admin', build = 'recode', discord=''}
local function str_to_sub(input, sep)
	local t = {}
	for str in string.gmatch(input, "([^"..sep.."]+)") do
		t[#t + 1] = string.gsub(str, "\n", "")
	end
	return t
end

local function to_boolean(str)
	if str == "true" or str == "false" then
		return (str == "true")
	else
		return str
	end
end
---------------------
--pos_wtm

local valuwes = {
	paketa_pitch = 0,
}

local login = {
    username = data.username,
    version = "1.0.0",
    build = data.build,
}

if login.build == 'User' then
    login.build = 'Live'
end



 
---------------------
--pos_wtm

local valuwes = {
	paketa_pitch = 0,
}

local login = {
    username = data.username,
    version = "1.0.0",
    build = data.build,
}

if login.build == 'User' then
    login.build = 'Live'
end


local classptr = ffi.typeof('void***')
local rawientitylist = client.create_interface('client.dll', 'VClientEntityList003') or error('VClientEntityList003 wasnt found', 2)

local ientitylist = ffi.cast(classptr, rawientitylist) or error('rawientitylist is nil', 2)

local native_GetNetChannelInfo = vtable_bind("engine.dll", "VEngineClient014", 78, "void* (__thiscall*)(void* ecx)")
local native_GetLatency = vtable_thunk(9, "float(__thiscall*)(void*, int)")
local get_client_entity = ffi.cast('void*(__thiscall*)(void*, int)', ientitylist[0][3]) or error('get_client_entity is nil', 2)
local js = panorama.open()
local MyPersonaAPI, LobbyAPI, PartyListAPI, SteamOverlayAPI = js.MyPersonaAPI, js.LobbyAPI, js.PartyListAPI, js.SteamOverlayAPI

json.encode_sparse_array(true)

local unpack = unpack
local next = next
local line = renderer.line
local world_to_screen = renderer.world_to_screen
local unpack_vec = vector().unpack
local resolver_flag = {}
local resolver_status = false
X,Y = client.screen_size()

local var_table = {};
    
local prev_simulation_time = 0

local function time_to_ticks(t)
    return math.floor(0.5 + (t / globals.tickinterval()))
end

local function lerp2(a, b, t)
    return a + (b - a) * t
end

local diff_sim = 0

function var_table:sim_diff() 
    local current_simulation_time = time_to_ticks(entity.get_prop(entity.get_local_player(), "m_flSimulationTime"))
    local diff = current_simulation_time - prev_simulation_time
    prev_simulation_time = current_simulation_time
    diff_sim = diff
    return diff_sim
end

local notify_lol = {}
local function lerp(a, b, t)
    return a + (b - a) * t
end

local rounding = 4
local o = 20
local rad = rounding + 2
local n = 45

local RoundedRect = function(x, y, w, h, radius, r, g, b, a) renderer.rectangle(x+radius,y,w-radius*2,radius,r,g,b,a)renderer.rectangle(x,y+radius,radius,h-radius*2,r,g,b,a)renderer.rectangle(x+radius,y+h-radius,w-radius*2,radius,r,g,b,a)renderer.rectangle(x+w-radius,y+radius,radius,h-radius*2,r,g,b,a)renderer.rectangle(x+radius,y+radius,w-radius*2,h-radius*2,r,g,b,a)renderer.circle(x+radius,y+radius,r,g,b,a,radius,180,0.25)renderer.circle(x+w-radius,y+radius,r,g,b,a,radius,90,0.25)renderer.circle(x+radius,y+h-radius,r,g,b,a,radius,270,0.25)renderer.circle(x+w-radius,y+h-radius,r,g,b,a,radius,0,0.25) end
local OutlineGlow = function(x, y, w, h, radius, r, g, b, a) renderer.rectangle(x+2,y+radius+rad,1,h-rad*2-radius*2,r,g,b,a)renderer.rectangle(x+w-3,y+radius+rad,1,h-rad*2-radius*2,r,g,b,a)renderer.rectangle(x+radius+rad,y+2,w-rad*2-radius*2,1,r,g,b,a)renderer.rectangle(x+radius+rad,y+h-3,w-rad*2-radius*2,1,r,g,b,a)renderer.circle_outline(x+radius+rad,y+radius+rad,r,g,b,a,radius+rounding,180,0.25,1)renderer.circle_outline(x+w-radius-rad,y+radius+rad,r,g,b,a,radius+rounding,270,0.25,1)renderer.circle_outline(x+radius+rad,y+h-radius-rad,r,g,b,a,radius+rounding,90,0.25,1)renderer.circle_outline(x+w-radius-rad,y+h-radius-rad,r,g,b,a,radius+rounding,0,0.25,1) end
local FadedRoundedGlow = function(x, y, w, h, radius, r, g, b, a, glow, r1, g1, b1) local n=a/255*n;renderer.rectangle(x+radius,y,w-radius*2,1,r,g,b,n)renderer.circle_outline(x+radius,y+radius,r,g,b,n,radius,180,0.25,1)renderer.circle_outline(x+w-radius,y+radius,r,g,b,n,radius,270,0.25,1)renderer.rectangle(x,y+radius,1,h-radius*2,r,g,b,n)renderer.rectangle(x+w-1,y+radius,1,h-radius*2,r,g,b,n)renderer.circle_outline(x+radius,y+h-radius,r,g,b,n,radius,90,0.25,1)renderer.circle_outline(x+w-radius,y+h-radius,r,g,b,n,radius,0,0.25,1)renderer.rectangle(x+radius,y+h-1,w-radius*2,1,r,g,b,n) for radius=4,glow do local radius=radius/2;OutlineGlow(x-radius,y-radius,w+radius*2,h+radius*2,radius,r1,g1,b1,glow-radius*2)end end
local container_glow = function(x, y, w, h, r, g, b, a, alpha,r1, g1, b1, fn) if alpha*255>0 then renderer.blur(x,y,w,h)end;RoundedRect(x,y,w,h,rounding,17,17,17,a)FadedRoundedGlow(x,y,w,h,rounding,r,g,b,alpha*255,alpha*o,r1,g1,b1)if not fn then return end;fn(x+rounding,y+rounding,w-rounding*2,h-rounding*2.0) end
 


local function roundedRectangle(b, c, d, e, f, g, h, i, j, k)
    renderer.rectangle(b, c, d, e, f, g, h, i)
    renderer.circle(b, c, f, g, h, i, k, -180, 0.25)
    renderer.circle(b + d, c, f, g, h, i, k, 90, 0.25)
    renderer.rectangle(b, c - k, d, k, f, g, h, i)
    renderer.circle(b + d, c + e, f, g, h, i, k, 0, 0.25)
    renderer.circle(b, c + e, f, g, h, i, k, -90, 0.25)
    renderer.rectangle(b, c + e, d, k, f, g, h, i)
    renderer.rectangle(b - k, c, k, e, f, g, h, i)
    renderer.rectangle(b + d, c, k, e, f, g, h, i)
end


local function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end




---------------------------------
ideal = {
    table = {
        config_data = {};
        visuals = {
            picture = "https://flagcdn.com/w160/%s.png";
            image_loaded = "";
            animation_variables = {};
            new_change = true;
            to_draw_ticks = 0;
            offset_maxed2 = 0;
            indi_op = 0;
            offset_maxed = 0;
            indi_op2 = 0;
            indi_op3 = 0;
            indi_op4 = 0;
        };
    };
    reference = {};
    menu = {};
    anti_aim = {
        is_invert = false;
        tick_var = 0;
        cur_team = 0;
        state_id = 0;
        is_active_inds = 0;
        pitch = "";
        pitch_value = 0;
        yaw_base = "";
        yaw = "";
        yaw_value = 0;
        yaw_jitter = "";
        yaw_jitter_value = 0;
        body_yaw = "";
        body_yaw_value = 0;
        freestanding_body_yaw = false;
        freestanding = "";
        freestanding_value = 0;
        defensive_ct = false;
        defensive_t = false;
        is_active = false;
        last_press = 0;
        aa_dir = 0;
        defensive = false;
        defensive_ticks = 0;
        ground_time = 0;
        current_preset = 0;
    };
}

ideal.reference = {
    anti_aim = {
        master                                            = ui.reference("AA", "Anti-aimbot angles", "Enabled");
        yaw_base                                          = ui.reference("AA", "Anti-aimbot angles", "Yaw base");
        pitch                                             = {ui.reference("AA", "Anti-aimbot angles", "Pitch")};
        yaw                     = {ui.reference("AA", "Anti-aimbot angles", "Yaw")};
        yaw_jitter       = {ui.reference("AA", "Anti-aimbot angles", "Yaw jitter")};
        body_yaw           = {ui.reference("AA", "Anti-aimbot angles", "Body yaw")};
        freestanding_body_yaw                             = ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw");
        edge_yaw                                          = ui.reference("AA", "Anti-aimbot angles", "Edge yaw");
        freestanding      = {ui.reference("AA", "Anti-aimbot angles", "Freestanding")};
        roll_offset                                       = ui.reference("AA", "Anti-aimbot angles", "Roll");
    };


    other = {
        double_tap = {ui.reference("RAGE", "Aimbot", "Double tap")};
        hide_shots      = {ui.reference("AA", "Other", "On shot anti-aim")};
        fakeducking                                     = ui.reference("RAGE", "Other", "Duck peek assist");
        legs                                            = ui.reference("AA", "Other", "Leg movement");
        slow_motion    = {ui.reference("AA", "Other", "Slow motion")};
        bunny_hop = ui.reference("Misc", "Movement", "Bunny hop");
        enable_fakelag        = {ui.reference("AA", "Fake lag", "Enabled")};
        fakelag_limit        = ui.reference("AA", "Fake lag", "Limit");
        auto_peek = {ui.reference("rage", "other", "quick peek assist")};
    }
}

setup_skeet_element = function (types, element, value, type_of)
    if types == "vis" then
        for table, values in pairs(ideal.reference.anti_aim) do
            if type(values) == "table" then
                for table_, values_ in pairs(values) do
                    if type_of == "load" then
                        ui.set_visible(values_, false)
                    else
                        ui.set_visible(values_, true)
                    end
                end
            else
                if type_of == "load" then
                    ui.set_visible(values, false)
                else
                    ui.set_visible(values, true)
                end
            end
        end
    elseif types == "vis_elem" then
        ui.set_visible(element, value)
    elseif types == "elem" then
        ui.set(element, value)
    end
end;

--#functions

-- helpers function @credit:boshka~#9502 (russian friend)


local script = {}

script.helpers = {
    defensive = 0,
    checker = 0,

    easeInOut = function(self, t)
        return (t > 0.5) and 4*((t-1)^3)+1 or 4*t^3;
    end,

    clamp = function(self, val, lower, upper)
        assert(val and lower and upper, "not very useful error message here")
        if lower > upper then lower, upper = upper, lower end -- swap if boundaries supplied the wrong way
        return math.max(lower, math.min(upper, val))
    end,

    split = function(self, inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
    end,

    rgba_to_hex = function(self, r, g, b, a)
      return bit.tohex(
        (math.floor(r + 0.5) * 16777216) + 
        (math.floor(g + 0.5) * 65536) + 
        (math.floor(b + 0.5) * 256) + 
        (math.floor(a + 0.5))
      )
    end,

    hex_to_rgba = function(self, hex)
    local color = tonumber(hex, 16)

    return 
    math.floor(color / 16777216) % 256, 
    math.floor(color / 65536) % 256, 
    math.floor(color / 256) % 256, 
    color % 256
    end,

    color_text = function(self, string, r, g, b, a)
        local accent = "\a" .. self:rgba_to_hex(r, g, b, a)
        local white = "\a" .. self:rgba_to_hex(255, 255, 255, a)

        local str = ""
        for i, s in ipairs(self:split(string, "$")) do
            str = str .. (i % 2 ==( string:sub(1, 1) == "$" and 0 or 1) and white or accent) .. s
        end

        return str
    end,

    animate_text = function(self, time, string, r, g, b, a)
        local t_out, t_out_iter = { }, 1

        local l = string:len( ) - 1

        local r_add = (255 - r)
        local g_add = (255 - g)
        local b_add = (255 - b)
        local a_add = (155 - a)

        for i = 1, #string do
            local iter = (i - 1)/(#string - 1) + time
            t_out[t_out_iter] = "\a" .. script.helpers:rgba_to_hex( r + r_add * math.abs(math.cos( iter )), g + g_add * math.abs(math.cos( iter )), b + b_add * math.abs(math.cos( iter )), a + a_add * math.abs(math.cos( iter )) )

            t_out[t_out_iter + 1] = string:sub( i, i )

            t_out_iter = t_out_iter + 2
        end

        return t_out
    end,

    get_time = function(self, h12)
        local hours, minutes, seconds = client.system_time()

        if h12 then
                local hrs = hours % 12

                if hrs == 0 then
                        hrs = 12
                else
                        hrs = hrs < 10 and hrs or ('%02d'):format(hrs)
                end

                return ('%s:%02d %s'):format(
                        hrs,
                        minutes,
                        hours >= 12 and 'pm' or 'am'
                )
        end

        return ('%02d:%02d:%02d'):format(
                hours,
                minutes,
                seconds
        )
end,
}


script.renderer = {
   rec = function(self, x, y, w, h, radius, color)
        radius = math.min(x/2, y/2, radius)
        local r, g, b, a = unpack(color)
        renderer.rectangle(x, y + radius, w, h - radius*2, r, g, b, a)
        renderer.rectangle(x + radius, y, w - radius*2, radius, r, g, b, a)
        renderer.rectangle(x + radius, y + h - radius, w - radius*2, radius, r, g, b, a)
        renderer.circle(x + radius, y + radius, r, g, b, a, radius, 180, 0.25)
        renderer.circle(x - radius + w, y + radius, r, g, b, a, radius, 90, 0.25)
        renderer.circle(x - radius + w, y - radius + h, r, g, b, a, radius, 0, 0.25)
        renderer.circle(x + radius, y - radius + h, r, g, b, a, radius, -90, 0.25)
    end,

    rec_outline = function(self, x, y, w, h, radius, thickness, color)
        radius = math.min(w/2, h/2, radius)
        local r, g, b, a = unpack(color)
        if radius == 1 then
            renderer.rectangle(x, y, w, thickness, r, g, b, a)
            renderer.rectangle(x, y + h - thickness, w , thickness, r, g, b, a)
        else
            renderer.rectangle(x + radius, y, w - radius*2, thickness, r, g, b, a)
            renderer.rectangle(x + radius, y + h - thickness, w - radius*2, thickness, r, g, b, a)
            renderer.rectangle(x, y + radius, thickness, h - radius*2, r, g, b, a)
            renderer.rectangle(x + w - thickness, y + radius, thickness, h - radius*2, r, g, b, a)
            renderer.circle_outline(x + radius, y + radius, r, g, b, a, radius, 180, 0.25, thickness)
            renderer.circle_outline(x + radius, y + h - radius, r, g, b, a, radius, 90, 0.25, thickness)
            renderer.circle_outline(x + w - radius, y + radius, r, g, b, a, radius, -90, 0.25, thickness)
            renderer.circle_outline(x + w - radius, y + h - radius, r, g, b, a, radius, 0, 0.25, thickness)
        end
    end,

    glow_module = function(self, x, y, w, h, width, rounding, accent, accent_inner)
        local thickness = 1
        local offset = 1
        local r, g, b, a = unpack(accent)
        if accent_inner then
            self:rec(x , y, w, h + 1, rounding, accent_inner)
        end
        for k = 0, width do
            if a * (k/width)^(1) > 5 then
                local accent = {r, g, b, a * (k/width)^(2)}
                self:rec_outline(x + (k - width - offset)*thickness, y + (k - width - offset) * thickness, w - (k - width - offset)*thickness*2, h + 1 - (k - width - offset)*thickness*2, rounding + thickness * (width - k + offset), thickness, accent)
            end
        end
    end
}

local function table_contains(tbl, val)
    for i=1,#tbl do
        if tbl[i] == val then
            return true
        end
    end
    return false
end

-- LERP FUNCTION FOR THE ANIMATION
function ideal.table.visuals.animation_variables.lerp(a,b,t)
    return a + (b - a) * t
end

-- ALPHA = ALPHA; MIN = MINIMUM ALPHA FOR THE PULSATION; MAX = MAXIMUM ALPHA FOR THE PULSATION; SPEED = ANIMATION SPEED
function ideal.table.visuals.animation_variables.pulsate(alpha,min,max,speed)

    if alpha >= max - 2 then
        ideal.table.visuals.new_change = false
        --alpha = animation_variables.lerp(alpha,max,globals.frametime() * speed)
    elseif alpha <= min  + 2 then
        ideal.table.visuals.new_change = true
        --alpha = animation_variables.lerp(alpha,min,globals.frametime() * speed)
    end

    if ideal.table.visuals.new_change == true then
        alpha = ideal.table.visuals.animation_variables.lerp(alpha,max,globals.frametime() * speed)
    else
        alpha = ideal.table.visuals.animation_variables.lerp(alpha,min,globals.frametime() * speed)
    end

    return alpha 
end

-- OFFSET TO BE MODULATED; WHEN = TRUE OR FALSE TO MODULATE; ORIGINAL = ORIGINAL POSITION; NEW_PLACE = LOCATION FOR THE OFFSET TO MOVE TO; SPEED = ANIMATION SPEED
function ideal.table.visuals.animation_variables.movement(offset,when,original,new_place,speed)

    if when == true then
        offset = ideal.table.visuals.animation_variables.lerp(offset,new_place,globals.frametime() * speed)
    else
        offset = ideal.table.visuals.animation_variables.lerp(offset,original,globals.frametime() * speed)
    end

    return offset 
end

-- ALPHA = YOUR ALPHA; FADE_BOOL = IF TRUE FADES IN IF NEGATIVE FADES AWAY;F_IN = FADE IN ALPHA; F_AWAY = FADE AWAY ALPHA; SPEED = ANIMATION SPEED
function ideal.table.visuals.animation_variables.fade(alpha,fade_bool,f_in,f_away,speed) 

    if fade_bool == true then 
        alpha = ideal.table.visuals.animation_variables.lerp(alpha,f_in,globals.frametime() * speed)
    else
        alpha = ideal.table.visuals.animation_variables.lerp(alpha,f_away,globals.frametime() * speed)
    end

    return alpha
end

rounded_rectangle = function(x, y, r, g, b, a, width, height, radius)
    -- rectangles
  
    renderer.rectangle(x + radius, y, width - (radius * 2), radius, r, g, b, a)
    renderer.rectangle(x + radius, y + height - radius, width - (radius * 2), radius, r, g, b, a)
    renderer.rectangle(x, y + radius, radius, height - (radius * 2), r, g, b, a)
    renderer.rectangle(x + (width - radius), y + radius, radius, height - (radius * 2), r, g, b, a)

    -- circles
    renderer.circle(x + radius, y + radius, r, g, b,a, radius, 145, radius * 0.1)
    renderer.circle(x + width - radius, y + radius, r, g, b, a, radius, 90, radius * 0.1)
    renderer.circle(x + radius, y + height - radius, r, g, b, a, radius, 180, radius * 0.1)
    renderer.circle(x + width - radius, y + height - radius, r, g, b, a, radius, 0, radius * 0.1)
end

ideal.menu.antiaim_elements_ct = {}
ideal.menu.antiaim_elements_t = {}
ideal.menu.tab_label = ui.new_label("AA", "Anti-aimbot angles", " ")
ideal.menu.color_picker = ui.new_color_picker("AA", "Anti-aimbot angles", " ", 179, 190, 214, 255)
ideal.menu.tab_selector = ui.new_combobox("AA", "Anti-aimbot angles", "\nselection", {"welcome", "anti-aim", "misc", "visuals", "config"})
--[[ideal.menu.antiaim_button = ui.new_label("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFlinks");
ideal.menu.antiaim_combo = ui.new_combobox("AA", "Anti-aimbot angles", "\nbuttons", "discord", "youtube")

ideal.menu.antiaim_discord = ui.new_button("AA", "Anti-aimbot angles", "load button" , function()
    if ui.get(ideal.menu.antiaim_combo) == "discord" then
    panorama.loadstring("SteamOverlayAPI.OpenExternalBrowserURL('https://discord.gg/jitter');")()
    elseif ui.get(ideal.menu.antiaim_combo) == "youtube" then
    panorama.loadstring("SteamOverlayAPI.OpenExternalBrowserURL('https://www.youtube.com/@kurahvh/videos');")()
    end
end);--]]
ideal.menu.antiaim_list = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFpresets", "slow jitter", "custom desync", "unmatched","keshi");
ideal.menu.antiaim_enable_addons = ui.new_checkbox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFkeybinds");
ideal.menu.antiaim_manual_left = ui.new_hotkey("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFleft");
ideal.menu.antiaim_manual_right = ui.new_hotkey("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFright");
ideal.menu.antiaim_manual_forward = ui.new_hotkey("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFforward");
ideal.menu.antiaim_freestanding = ui.new_hotkey("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFfs");
--ideal.menu.antiaim_enable_resolver = ui.new_checkbox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFcorrection");
--ideal.menu.antiaim_enable_resolver_combo = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFtype", "small correction", "desync correction");
ideal.menu.antiaim_anti_knife = ui.new_checkbox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFavoid backstab");
ideal.menu.antiaim_anti_broken = ui.new_checkbox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFbroken");
ideal.menu.watermark = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFWatermark", "-","Bottom", "Side");
ideal.menu.antiaim_anti_sun_rise = ui.new_checkbox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFsun rise mode");
ideal.menu.antiaim_legit_aa = ui.new_checkbox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFlegit anti-aim");
ideal.menu.antiaim_quickpeek = ui.new_checkbox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFpeek addons");
ideal.menu.antiaim_quickpeek_addons = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFbody", "static", "jitter", "opposite");
ideal.menu.antiaim_quickpeek_addons_second = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFmanipulation", "none", "slow", "fast");
ideal.menu.antiaim_quickpeek_addons_third = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFdefensive", "off", "on");
ideal.menu.antiaim_safeknife = ui.new_checkbox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFsafe head");
ideal.menu.antiaim_safeknife_options = ui.new_multiselect("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFtrigger", "knife", "zeus");
ideal.menu.antiaim_animation = ui.new_checkbox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFanimations");
ideal.menu.antiaim_animation_ground = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFground", "off", "sliding", "moonwalk", "break", "modern");
ideal.menu.antiaim_animation_air = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFin air", "off", "static", "moonwalk", "running");
ideal.menu.antiaim_animation_extra = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFextras", "off", "reset pitch");
ideal.menu.antiaim_defensive_exploit = ui.new_checkbox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFdefensive");
ideal.menu.antiaim_defensive_type = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFtype", "meta","ideal", "custom");
ideal.menu.antiaim_defensive_pitch = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFpitch", "off", "default", "up", "down", "minimal", "random", "custom");
ideal.menu.antiaim_defensive_pitch_slider = ui.new_slider("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFcustom pitch", -89, 89, 0, true, "°");
ideal.menu.antiaim_defensive_yaw = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFyaw", "off", "180", "spin", "static", "180 Z", "crosshair");
ideal.menu.antiaim_defensive_offset = ui.new_slider("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFyaw offset", -180, 180, 0, true, "°");
ideal.menu.antiaim_defensive_byaw = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFbody", "off", "off", "opposite", "jitter", "static");
ideal.menu.antiaim_defensive_boffset = ui.new_slider("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFbody offset", -180, 180, 0, true, "°");
ideal.menu.indicators5 = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFindicator", "none", "modern","ideal","old");
--ideal.menu.indicators2 = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFwatermark type", "text", "flag", "legacy");
ideal.menu.debugindicators = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFdebug panel", "off","1", "2", "3");
ideal.menu.indicators = ui.new_multiselect("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFdefensive indicator", "text", "bar", "icon")
ideal.menu.builder_state = {'global', 'stand', 'run', 'slow', 'in air', 'air duck', 'move duck', 'duck', 'fake lag'}
ideal.menu.state_to_num = { 
    ['global'] = 1, 
    ['stand'] = 2, 
    ['run'] = 3, 
    ['slow'] = 4, --export
    ['in air'] = 5,
    ['air duck'] = 6,
    ['move duck'] = 7,
    ['duck'] = 8,
    ['fake lag'] = 9, 
};
ideal.menu.team_site = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFFselector", {"counter", "terror"})
ideal.menu.aabuilder_state = ui.new_combobox("AA", "Anti-aimbot angles", "\nstate", ideal.menu.builder_state);
send_button_t = function ()
    local str = ""
    for i=1, 9 do
        if ui.get(ideal.menu.aabuilder_state) == ideal.menu.builder_state[i] then
            str = str
            .. tostring(ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_pitch)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_pitch_slider)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_base)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_slider)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_slider_left)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_slider_right)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_slider_adv_tick)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_slider_adv_delay)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_slider_adv_left)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_slider_adv_right)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_body_yaw_adv_left)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_body_yaw_adv_right)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_jitter)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_jitter_slider)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_jitter_slider_l)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_jitter_slider_r)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_body_yaw)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_body_yaw_slider)) .. "|"
        end
    end

    local tbl = str_to_sub(str, "|")
	for i2 = 1, 9 do
        if ui.get(ideal.menu.aabuilder_state) == ideal.menu.builder_state[i2] then
            ui.set(ideal.menu.antiaim_elements_t[i2].antiaim_pitch, tostring(tbl[1]))
            ui.set(ideal.menu.antiaim_elements_t[i2].antiaim_pitch_slider, tonumber(tbl[2]))
            ui.set(ideal.menu.antiaim_elements_t[i2].antiaim_yaw_base, tostring(tbl[3]))
            ui.set(ideal.menu.antiaim_elements_t[i2].antiaim_yaw, tostring(tbl[4]))
            ui.set(ideal.menu.antiaim_elements_t[i2].antiaim_yaw_advanced, tostring(tbl[5]))
            ui.set(ideal.menu.antiaim_elements_t[i2].antiaim_yaw_slider, tonumber(tbl[6]))
            ui.set(ideal.menu.antiaim_elements_t[i2].antiaim_yaw_slider_left, tonumber(tbl[7]))
            ui.set(ideal.menu.antiaim_elements_t[i2].antiaim_yaw_slider_right, tonumber(tbl[8]))
            ui.set(ideal.menu.antiaim_elements_t[i2].antiaim_yaw_slider_adv_tick, tonumber(tbl[9]))
            ui.set(ideal.menu.antiaim_elements_t[i2].antiaim_yaw_slider_adv_delay, tostring(tbl[10]))
            ui.set(ideal.menu.antiaim_elements_t[i2].antiaim_yaw_slider_adv_left, tonumber(tbl[11]))
            ui.set(ideal.menu.antiaim_elements_t[i2].antiaim_yaw_slider_adv_right, tonumber(tbl[12]))
            ui.set(ideal.menu.antiaim_elements_t[i2].antiaim_body_yaw_adv_left, tostring(tbl[13]))
            ui.set(ideal.menu.antiaim_elements_t[i2].antiaim_body_yaw_adv_right, tostring(tbl[14]))   
            ui.set(ideal.menu.antiaim_elements_t[i2].antiaim_yaw_jitter, tostring(tbl[15]))
            ui.set(ideal.menu.antiaim_elements_t[i2].antiaim_yaw_jitter_slider, tonumber(tbl[16]))
            ui.set(ideal.menu.antiaim_elements_t[i2].antiaim_yaw_jitter_slider_l, tonumber(tbl[17]))       
            ui.set(ideal.menu.antiaim_elements_t[i2].antiaim_yaw_jitter_slider_r, tonumber(tbl[18]))    
            ui.set(ideal.menu.antiaim_elements_t[i2].antiaim_body_yaw, tostring(tbl[19]))       
            ui.set(ideal.menu.antiaim_elements_t[i2].antiaim_body_yaw_slider, tonumber(tbl[20]))         
        end
	end
end

send_button_ct = function ()
    local str = ""
    for i=1, 9 do
        if ui.get(ideal.menu.aabuilder_state) == ideal.menu.builder_state[i] then
            str = str
            .. tostring(ui.get(ideal.menu.antiaim_elements_t[i].antiaim_pitch)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_t[i].antiaim_pitch_slider)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_base)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_slider)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_slider_left)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_slider_right)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_slider_adv_tick)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_slider_adv_delay)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_slider_adv_left)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_slider_adv_right)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_t[i].antiaim_body_yaw_adv_left)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_t[i].antiaim_body_yaw_adv_right)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_jitter)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_jitter_slider)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_jitter_slider_l)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_jitter_slider_r)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_t[i].antiaim_body_yaw)) .. "|"
            .. tostring(ui.get(ideal.menu.antiaim_elements_t[i].antiaim_body_yaw_slider)) .. "|"
        end
    end

    local tbl = str_to_sub(str, "|")
	for i2 = 1, 9 do
        if ui.get(ideal.menu.aabuilder_state) == ideal.menu.builder_state[i2] then
            ui.set(ideal.menu.antiaim_elements_ct[i2].antiaim_pitch, tostring(tbl[1]))
            ui.set(ideal.menu.antiaim_elements_ct[i2].antiaim_pitch_slider, tonumber(tbl[2]))
            ui.set(ideal.menu.antiaim_elements_ct[i2].antiaim_yaw_base, tostring(tbl[3]))
            ui.set(ideal.menu.antiaim_elements_ct[i2].antiaim_yaw, tostring(tbl[4]))
            ui.set(ideal.menu.antiaim_elements_ct[i2].antiaim_yaw_advanced, tostring(tbl[5]))
            ui.set(ideal.menu.antiaim_elements_ct[i2].antiaim_yaw_slider, tonumber(tbl[6]))
            ui.set(ideal.menu.antiaim_elements_ct[i2].antiaim_yaw_slider_left, tonumber(tbl[7]))
            ui.set(ideal.menu.antiaim_elements_ct[i2].antiaim_yaw_slider_right, tonumber(tbl[8]))
            ui.set(ideal.menu.antiaim_elements_ct[i2].antiaim_yaw_slider_adv_tick, tonumber(tbl[9]))
            ui.set(ideal.menu.antiaim_elements_ct[i2].antiaim_yaw_slider_adv_delay, tostring(tbl[10]))
            ui.set(ideal.menu.antiaim_elements_ct[i2].antiaim_yaw_slider_adv_left, tonumber(tbl[11]))
            ui.set(ideal.menu.antiaim_elements_ct[i2].antiaim_yaw_slider_adv_right, tonumber(tbl[12]))
            ui.set(ideal.menu.antiaim_elements_ct[i2].antiaim_body_yaw_adv_left, tostring(tbl[13]))
            ui.set(ideal.menu.antiaim_elements_ct[i2].antiaim_body_yaw_adv_right, tostring(tbl[14]))   
            ui.set(ideal.menu.antiaim_elements_ct[i2].antiaim_yaw_jitter, tostring(tbl[15]))
            ui.set(ideal.menu.antiaim_elements_ct[i2].antiaim_yaw_jitter_slider, tonumber(tbl[16]))
            ui.set(ideal.menu.antiaim_elements_ct[i2].antiaim_yaw_jitter_slider_l, tonumber(tbl[17]))       
            ui.set(ideal.menu.antiaim_elements_ct[i2].antiaim_yaw_jitter_slider_r, tonumber(tbl[18]))    
            ui.set(ideal.menu.antiaim_elements_ct[i2].antiaim_body_yaw, tostring(tbl[19]))       
            ui.set(ideal.menu.antiaim_elements_ct[i2].antiaim_body_yaw_slider, tonumber(tbl[20]))         
        end
	end
end
for k, v in pairs(ideal.menu.builder_state) do
    ideal.menu.antiaim_elements_ct[k] = {  
        enable = ui.new_checkbox("AA", "Anti-aimbot angles", "\aB3BED6FFenable \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].."");
        antiaim_pitch = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [ct] pitch  ", {"off", "default", "up", "down", "minimal", "random", "custom"});
        antiaim_pitch_slider = ui.new_slider("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [ct] custom pitch", -89, 89, 0, true, "°");
        antiaim_yaw_base = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [ct] yaw base  ", {"at targets", "local view"});
        antiaim_yaw = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [ct] yaw  ", {"off", "180", "spin", "static", "180 Z", "crosshair"});
        antiaim_yaw_advanced = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [ct] yaw type ", {"static", "custom desync", "tick", "break", "anti-break", "sync"});
        antiaim_yaw_slider = ui.new_slider("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [ct] static yaw", -180, 180, 0, true, "°");
        antiaim_yaw_slider_left = ui.new_slider("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [ct] left yaw  ", -180, 180, 0, true, "°");
        antiaim_yaw_slider_right = ui.new_slider("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [ct] right yaw  ", -180, 180, 0, true, "°");
        antiaim_yaw_slider_adv_tick = ui.new_slider("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [ct] manipulation speed  ", 1, 50, 0, true, "x");
        antiaim_yaw_slider_adv_delay = ui.new_slider("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [ct] manipulation delay  ", 1, 10, 0, true, "d");
        antiaim_yaw_slider_adv_left = ui.new_slider("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [ct] manipulation left  ", -180, 180, 0, true, "°");
        antiaim_yaw_slider_adv_right = ui.new_slider("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [ct] manipulation right  ", -180, 180, 0, true, "°");
        antiaim_body_yaw_adv_left = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [ct] body yaw left ", {"off", "opposite", "jitter", "static"});
        antiaim_body_yaw_adv_right = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [ct] body yaw right ", {"off", "opposite", "jitter", "static"});
        antiaim_yaw_jitter = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [ct] yaw jitter ", {"off", "offset", "center", "random", "skitter", "left ^ right offset", "left ^ right center", "left ^ right random", "left ^ right skitter"});
        antiaim_yaw_jitter_slider = ui.new_slider("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [ct] static jitter ", -180, 180, 0, true, "°");
        antiaim_yaw_jitter_slider_l = ui.new_slider("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [ct] left jitter ", -180, 180, 0, true, "°");
        antiaim_yaw_jitter_slider_r = ui.new_slider("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [ct] right jitter ", -180, 180, 0, true, "°");
        antiaim_body_yaw = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [ct] body yaw ", {"off", "opposite", "jitter", "static"});
        antiaim_body_yaw_slider = ui.new_slider("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [ct] static body yaw", -180, 180, 0, true, "°");
        antiaim_defensive = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [ct] defensive ", {"off", "always on", "switch cycle"});
        send_to_t = ui.new_button("AA", "Anti-aimbot angles", "Send to \aB3BED6FFT", send_button_t);
    }
end

for k, v in pairs(ideal.menu.builder_state) do
    ideal.menu.antiaim_elements_t[k] = {
        enable = ui.new_checkbox("AA", "Anti-aimbot angles", "\aB3BED6FFenable \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].."");
        antiaim_pitch = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [t] pitch  ", {"off", "default", "up", "down", "minimal", "random", "custom"});
        antiaim_pitch_slider = ui.new_slider("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [t] custom pitch", -89, 89, 0, true, "°");
        antiaim_yaw_base = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [t] yaw base  ", {"at targets", "local view"});
        antiaim_yaw = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [t] yaw  ", {"off", "180", "spin", "static", "180 Z", "crosshair"});
        antiaim_yaw_advanced = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [t] yaw manipulation ", {"static", "custom desync", "tick", "break", "anti-break", "sync"});
        antiaim_yaw_slider = ui.new_slider("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [t] static yaw", -180, 180, 0, true, "°");
        antiaim_yaw_slider_left = ui.new_slider("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [t] left yaw  ", -180, 180, 0, true, "°");
        antiaim_yaw_slider_right = ui.new_slider("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [t] right yaw  ", -180, 180, 0, true, "°");
        antiaim_yaw_slider_adv_tick = ui.new_slider("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [t] manipulation speed  ", 1, 50, 0, true, "x");
        antiaim_yaw_slider_adv_delay = ui.new_slider("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [t] manipulation delay  ", 1, 10, 0, true, "d");
        antiaim_yaw_slider_adv_left = ui.new_slider("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [t] manipulation left  ", -180, 180, 0, true, "°");
        antiaim_yaw_slider_adv_right = ui.new_slider("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [t] manipulation right  ", -180, 180, 0, true, "°");
        antiaim_body_yaw_adv_left = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [t] body yaw left ", {"off", "opposite", "jitter", "static"});
        antiaim_body_yaw_adv_right = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [t] body yaw right ", {"off", "opposite", "jitter", "static"});
        antiaim_yaw_jitter = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [t] yaw jitter ", {"off", "offset", "center", "random", "skitter", "left ^ right offset", "left ^ right center", "left ^ right random", "left ^ right skitter"});
        antiaim_yaw_jitter_slider = ui.new_slider("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [t] static jitter ", -180, 180, 0, true, "°");
        antiaim_yaw_jitter_slider_l = ui.new_slider("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [t] left jitter ", -180, 180, 0, true, "°");
        antiaim_yaw_jitter_slider_r = ui.new_slider("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [t] right jitter ", -180, 180, 0, true, "°");
        antiaim_body_yaw = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [t] body yaw ", {"off", "opposite", "jitter", "static"});
        antiaim_body_yaw_slider = ui.new_slider("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [t]] static body yaw", -180, 180, 0, true, "°");
        antiaim_defensive = ui.new_combobox("AA", "Anti-aimbot angles", "\aB3BED6FFideal \a989898FF- \aFFFFFFFF"..ideal.menu.builder_state[k].." [t] defensive ", {"off", "always on", "switch cycle"});
        send_to_ct = ui.new_button("AA", "Anti-aimbot angles", "Send to \aB3BED6FFCT", send_button_ct);
    }
end

ideal.table.config_data.cfg_data = {
    anti_aim = {
        ideal.menu.antiaim_elements_ct[1].antiaim_pitch;
        ideal.menu.antiaim_elements_ct[1].antiaim_pitch_slider;
        ideal.menu.antiaim_elements_ct[1].antiaim_yaw_base;
        ideal.menu.antiaim_elements_ct[1].antiaim_yaw;
        ideal.menu.antiaim_elements_ct[1].antiaim_yaw_advanced;
        ideal.menu.antiaim_elements_ct[1].antiaim_yaw_slider;
        ideal.menu.antiaim_elements_ct[1].antiaim_yaw_slider_left;
        ideal.menu.antiaim_elements_ct[1].antiaim_yaw_slider_right;
        ideal.menu.antiaim_elements_ct[1].antiaim_yaw_slider_adv_tick;
        ideal.menu.antiaim_elements_ct[1].antiaim_yaw_slider_adv_delay;
        ideal.menu.antiaim_elements_ct[1].antiaim_yaw_slider_adv_left;
        ideal.menu.antiaim_elements_ct[1].antiaim_yaw_slider_adv_right;
        ideal.menu.antiaim_elements_ct[1].antiaim_body_yaw_adv_left;
        ideal.menu.antiaim_elements_ct[1].antiaim_body_yaw_adv_right;
        ideal.menu.antiaim_elements_ct[1].antiaim_yaw_jitter;
        ideal.menu.antiaim_elements_ct[1].antiaim_yaw_jitter_slider;
        ideal.menu.antiaim_elements_ct[1].antiaim_yaw_jitter_slider_l;
        ideal.menu.antiaim_elements_ct[1].antiaim_yaw_jitter_slider_r;
        ideal.menu.antiaim_elements_ct[1].antiaim_body_yaw;
        ideal.menu.antiaim_elements_ct[1].antiaim_body_yaw_slider;
        ideal.menu.antiaim_elements_ct[1].antiaim_defensive;

        ideal.menu.antiaim_elements_ct[2].enable;
        ideal.menu.antiaim_elements_ct[2].antiaim_pitch;
        ideal.menu.antiaim_elements_ct[2].antiaim_pitch_slider;
        ideal.menu.antiaim_elements_ct[2].antiaim_yaw_base;
        ideal.menu.antiaim_elements_ct[2].antiaim_yaw;
        ideal.menu.antiaim_elements_ct[2].antiaim_yaw_advanced;
        ideal.menu.antiaim_elements_ct[2].antiaim_yaw_slider;
        ideal.menu.antiaim_elements_ct[2].antiaim_yaw_slider_left;
        ideal.menu.antiaim_elements_ct[2].antiaim_yaw_slider_right;
        ideal.menu.antiaim_elements_ct[2].antiaim_yaw_slider_adv_tick;
        ideal.menu.antiaim_elements_ct[2].antiaim_yaw_slider_adv_delay;
        ideal.menu.antiaim_elements_ct[2].antiaim_yaw_slider_adv_left;
        ideal.menu.antiaim_elements_ct[2].antiaim_yaw_slider_adv_right;
        ideal.menu.antiaim_elements_ct[2].antiaim_body_yaw_adv_left;
        ideal.menu.antiaim_elements_ct[2].antiaim_body_yaw_adv_right;
        ideal.menu.antiaim_elements_ct[2].antiaim_yaw_jitter;
        ideal.menu.antiaim_elements_ct[2].antiaim_yaw_jitter_slider;
        ideal.menu.antiaim_elements_ct[2].antiaim_yaw_jitter_slider_l;
        ideal.menu.antiaim_elements_ct[2].antiaim_yaw_jitter_slider_r;
        ideal.menu.antiaim_elements_ct[2].antiaim_body_yaw;
        ideal.menu.antiaim_elements_ct[2].antiaim_body_yaw_slider;
        ideal.menu.antiaim_elements_ct[2].antiaim_defensive;
        ideal.menu.antiaim_elements_ct[3].enable;
        ideal.menu.antiaim_elements_ct[3].antiaim_pitch;
        ideal.menu.antiaim_elements_ct[3].antiaim_pitch_slider;
        ideal.menu.antiaim_elements_ct[3].antiaim_yaw_base;
        ideal.menu.antiaim_elements_ct[3].antiaim_yaw;
        ideal.menu.antiaim_elements_ct[3].antiaim_yaw_advanced;
        ideal.menu.antiaim_elements_ct[3].antiaim_yaw_slider;
        ideal.menu.antiaim_elements_ct[3].antiaim_yaw_slider_left;
        ideal.menu.antiaim_elements_ct[3].antiaim_yaw_slider_right;
        ideal.menu.antiaim_elements_ct[3].antiaim_yaw_slider_adv_tick;
        ideal.menu.antiaim_elements_ct[3].antiaim_yaw_slider_adv_delay;
        ideal.menu.antiaim_elements_ct[3].antiaim_yaw_slider_adv_left;
        ideal.menu.antiaim_elements_ct[3].antiaim_yaw_slider_adv_right;
        ideal.menu.antiaim_elements_ct[3].antiaim_body_yaw_adv_left;
        ideal.menu.antiaim_elements_ct[3].antiaim_body_yaw_adv_right;
        ideal.menu.antiaim_elements_ct[3].antiaim_yaw_jitter;
        ideal.menu.antiaim_elements_ct[3].antiaim_yaw_jitter_slider;
        ideal.menu.antiaim_elements_ct[3].antiaim_yaw_jitter_slider_l;
        ideal.menu.antiaim_elements_ct[3].antiaim_yaw_jitter_slider_r;
        ideal.menu.antiaim_elements_ct[3].antiaim_body_yaw;
        ideal.menu.antiaim_elements_ct[3].antiaim_body_yaw_slider;
        ideal.menu.antiaim_elements_ct[3].antiaim_defensive;

        ideal.menu.antiaim_elements_ct[4].enable;
        ideal.menu.antiaim_elements_ct[4].antiaim_pitch;
        ideal.menu.antiaim_elements_ct[4].antiaim_pitch_slider;
        ideal.menu.antiaim_elements_ct[4].antiaim_yaw_base;
        ideal.menu.antiaim_elements_ct[4].antiaim_yaw;
        ideal.menu.antiaim_elements_ct[4].antiaim_yaw_advanced;
        ideal.menu.antiaim_elements_ct[4].antiaim_yaw_slider;
        ideal.menu.antiaim_elements_ct[4].antiaim_yaw_slider_left;
        ideal.menu.antiaim_elements_ct[4].antiaim_yaw_slider_right;
        ideal.menu.antiaim_elements_ct[4].antiaim_yaw_slider_adv_tick;
        ideal.menu.antiaim_elements_ct[4].antiaim_yaw_slider_adv_delay;
        ideal.menu.antiaim_elements_ct[4].antiaim_yaw_slider_adv_left;
        ideal.menu.antiaim_elements_ct[4].antiaim_yaw_slider_adv_right;
        ideal.menu.antiaim_elements_ct[4].antiaim_body_yaw_adv_left;
        ideal.menu.antiaim_elements_ct[4].antiaim_body_yaw_adv_right;
        ideal.menu.antiaim_elements_ct[4].antiaim_yaw_jitter;
        ideal.menu.antiaim_elements_ct[4].antiaim_yaw_jitter_slider;
        ideal.menu.antiaim_elements_ct[4].antiaim_yaw_jitter_slider_l;
        ideal.menu.antiaim_elements_ct[4].antiaim_yaw_jitter_slider_r;
        ideal.menu.antiaim_elements_ct[4].antiaim_body_yaw;
        ideal.menu.antiaim_elements_ct[4].antiaim_body_yaw_slider;
        ideal.menu.antiaim_elements_ct[4].antiaim_defensive;

        ideal.menu.antiaim_elements_ct[5].enable;
        ideal.menu.antiaim_elements_ct[5].antiaim_pitch;
        ideal.menu.antiaim_elements_ct[5].antiaim_pitch_slider;
        ideal.menu.antiaim_elements_ct[5].antiaim_yaw_base;
        ideal.menu.antiaim_elements_ct[5].antiaim_yaw;
        ideal.menu.antiaim_elements_ct[5].antiaim_yaw_advanced;
        ideal.menu.antiaim_elements_ct[5].antiaim_yaw_slider;
        ideal.menu.antiaim_elements_ct[5].antiaim_yaw_slider_left;
        ideal.menu.antiaim_elements_ct[5].antiaim_yaw_slider_right;
        ideal.menu.antiaim_elements_ct[5].antiaim_yaw_slider_adv_tick;
        ideal.menu.antiaim_elements_ct[5].antiaim_yaw_slider_adv_delay;
        ideal.menu.antiaim_elements_ct[5].antiaim_yaw_slider_adv_left;
        ideal.menu.antiaim_elements_ct[5].antiaim_yaw_slider_adv_right;
        ideal.menu.antiaim_elements_ct[5].antiaim_body_yaw_adv_left;
        ideal.menu.antiaim_elements_ct[5].antiaim_body_yaw_adv_right;
        ideal.menu.antiaim_elements_ct[5].antiaim_yaw_jitter;
        ideal.menu.antiaim_elements_ct[5].antiaim_yaw_jitter_slider;
        ideal.menu.antiaim_elements_ct[5].antiaim_yaw_jitter_slider_l;
        ideal.menu.antiaim_elements_ct[5].antiaim_yaw_jitter_slider_r;
        ideal.menu.antiaim_elements_ct[5].antiaim_body_yaw;
        ideal.menu.antiaim_elements_ct[5].antiaim_body_yaw_slider;
        ideal.menu.antiaim_elements_ct[5].antiaim_defensive;

        ideal.menu.antiaim_elements_ct[6].enable;
        ideal.menu.antiaim_elements_ct[6].antiaim_pitch;
        ideal.menu.antiaim_elements_ct[6].antiaim_pitch_slider;
        ideal.menu.antiaim_elements_ct[6].antiaim_yaw_base;
        ideal.menu.antiaim_elements_ct[6].antiaim_yaw;
        ideal.menu.antiaim_elements_ct[6].antiaim_yaw_advanced;
        ideal.menu.antiaim_elements_ct[6].antiaim_yaw_slider;
        ideal.menu.antiaim_elements_ct[6].antiaim_yaw_slider_left;
        ideal.menu.antiaim_elements_ct[6].antiaim_yaw_slider_right;
        ideal.menu.antiaim_elements_ct[6].antiaim_yaw_slider_adv_tick;
        ideal.menu.antiaim_elements_ct[6].antiaim_yaw_slider_adv_delay;
        ideal.menu.antiaim_elements_ct[6].antiaim_yaw_slider_adv_left;
        ideal.menu.antiaim_elements_ct[6].antiaim_yaw_slider_adv_right;
        ideal.menu.antiaim_elements_ct[6].antiaim_body_yaw_adv_left;
        ideal.menu.antiaim_elements_ct[6].antiaim_body_yaw_adv_right;
        ideal.menu.antiaim_elements_ct[6].antiaim_yaw_jitter;
        ideal.menu.antiaim_elements_ct[6].antiaim_yaw_jitter_slider;
        ideal.menu.antiaim_elements_ct[6].antiaim_yaw_jitter_slider_l;
        ideal.menu.antiaim_elements_ct[6].antiaim_yaw_jitter_slider_r;
        ideal.menu.antiaim_elements_ct[6].antiaim_body_yaw;
        ideal.menu.antiaim_elements_ct[6].antiaim_body_yaw_slider;
        ideal.menu.antiaim_elements_ct[6].antiaim_defensive;
        ideal.menu.antiaim_elements_ct[7].enable;
        ideal.menu.antiaim_elements_ct[7].antiaim_pitch;
        ideal.menu.antiaim_elements_ct[7].antiaim_pitch_slider;
        ideal.menu.antiaim_elements_ct[7].antiaim_yaw_base;
        ideal.menu.antiaim_elements_ct[7].antiaim_yaw;
        ideal.menu.antiaim_elements_ct[7].antiaim_yaw_advanced;
        ideal.menu.antiaim_elements_ct[7].antiaim_yaw_slider;
        ideal.menu.antiaim_elements_ct[7].antiaim_yaw_slider_left;
        ideal.menu.antiaim_elements_ct[7].antiaim_yaw_slider_right;
        ideal.menu.antiaim_elements_ct[7].antiaim_yaw_slider_adv_tick;
        ideal.menu.antiaim_elements_ct[7].antiaim_yaw_slider_adv_delay;
        ideal.menu.antiaim_elements_ct[7].antiaim_yaw_slider_adv_left;
        ideal.menu.antiaim_elements_ct[7].antiaim_yaw_slider_adv_right;
        ideal.menu.antiaim_elements_ct[7].antiaim_body_yaw_adv_left;
        ideal.menu.antiaim_elements_ct[7].antiaim_body_yaw_adv_right;
        ideal.menu.antiaim_elements_ct[7].antiaim_yaw_jitter;
        ideal.menu.antiaim_elements_ct[7].antiaim_yaw_jitter_slider;
        ideal.menu.antiaim_elements_ct[7].antiaim_yaw_jitter_slider_l;
        ideal.menu.antiaim_elements_ct[7].antiaim_yaw_jitter_slider_r;
        ideal.menu.antiaim_elements_ct[7].antiaim_body_yaw;
        ideal.menu.antiaim_elements_ct[7].antiaim_body_yaw_slider;
        ideal.menu.antiaim_elements_ct[7].antiaim_defensive;

        ideal.menu.antiaim_elements_ct[8].enable;
        ideal.menu.antiaim_elements_ct[8].antiaim_pitch;
        ideal.menu.antiaim_elements_ct[8].antiaim_pitch_slider;
        ideal.menu.antiaim_elements_ct[8].antiaim_yaw_base;
        ideal.menu.antiaim_elements_ct[8].antiaim_yaw;
        ideal.menu.antiaim_elements_ct[8].antiaim_yaw_advanced;
        ideal.menu.antiaim_elements_ct[8].antiaim_yaw_slider;
        ideal.menu.antiaim_elements_ct[8].antiaim_yaw_slider_left;
        ideal.menu.antiaim_elements_ct[8].antiaim_yaw_slider_right;
        ideal.menu.antiaim_elements_ct[8].antiaim_yaw_slider_adv_tick;
        ideal.menu.antiaim_elements_ct[8].antiaim_yaw_slider_adv_delay;
        ideal.menu.antiaim_elements_ct[8].antiaim_yaw_slider_adv_left;
        ideal.menu.antiaim_elements_ct[8].antiaim_yaw_slider_adv_right;
        ideal.menu.antiaim_elements_ct[8].antiaim_body_yaw_adv_left;
        ideal.menu.antiaim_elements_ct[8].antiaim_body_yaw_adv_right;
        ideal.menu.antiaim_elements_ct[8].antiaim_yaw_jitter;
        ideal.menu.antiaim_elements_ct[8].antiaim_yaw_jitter_slider;
        ideal.menu.antiaim_elements_ct[8].antiaim_yaw_jitter_slider_l;
        ideal.menu.antiaim_elements_ct[8].antiaim_yaw_jitter_slider_r;
        ideal.menu.antiaim_elements_ct[8].antiaim_body_yaw;
        ideal.menu.antiaim_elements_ct[8].antiaim_body_yaw_slider;
        ideal.menu.antiaim_elements_ct[8].antiaim_defensive;

        ideal.menu.antiaim_elements_ct[9].enable;
        ideal.menu.antiaim_elements_ct[9].antiaim_pitch;
        ideal.menu.antiaim_elements_ct[9].antiaim_pitch_slider;
        ideal.menu.antiaim_elements_ct[9].antiaim_yaw_base;
        ideal.menu.antiaim_elements_ct[9].antiaim_yaw;
        ideal.menu.antiaim_elements_ct[9].antiaim_yaw_advanced;
        ideal.menu.antiaim_elements_ct[9].antiaim_yaw_slider;
        ideal.menu.antiaim_elements_ct[9].antiaim_yaw_slider_left;
        ideal.menu.antiaim_elements_ct[9].antiaim_yaw_slider_right;
        ideal.menu.antiaim_elements_ct[9].antiaim_yaw_slider_adv_tick;
        ideal.menu.antiaim_elements_ct[9].antiaim_yaw_slider_adv_delay;
        ideal.menu.antiaim_elements_ct[9].antiaim_yaw_slider_adv_left;
        ideal.menu.antiaim_elements_ct[9].antiaim_yaw_slider_adv_right;
        ideal.menu.antiaim_elements_ct[9].antiaim_body_yaw_adv_left;
        ideal.menu.antiaim_elements_ct[9].antiaim_body_yaw_adv_right;
        ideal.menu.antiaim_elements_ct[9].antiaim_yaw_jitter;
        ideal.menu.antiaim_elements_ct[9].antiaim_yaw_jitter_slider;
        ideal.menu.antiaim_elements_ct[9].antiaim_yaw_jitter_slider_l;
        ideal.menu.antiaim_elements_ct[9].antiaim_yaw_jitter_slider_r;
        ideal.menu.antiaim_elements_ct[9].antiaim_body_yaw;
        ideal.menu.antiaim_elements_ct[9].antiaim_body_yaw_slider;
        ideal.menu.antiaim_elements_ct[9].antiaim_defensive;

        ideal.menu.antiaim_elements_t[1].antiaim_pitch;
        ideal.menu.antiaim_elements_t[1].antiaim_pitch_slider;
        ideal.menu.antiaim_elements_t[1].antiaim_yaw_base;
        ideal.menu.antiaim_elements_t[1].antiaim_yaw;
        ideal.menu.antiaim_elements_t[1].antiaim_yaw_advanced;
        ideal.menu.antiaim_elements_t[1].antiaim_yaw_slider;
        ideal.menu.antiaim_elements_t[1].antiaim_yaw_slider_left;
        ideal.menu.antiaim_elements_t[1].antiaim_yaw_slider_right;
        ideal.menu.antiaim_elements_t[1].antiaim_yaw_slider_adv_tick;
        ideal.menu.antiaim_elements_t[1].antiaim_yaw_slider_adv_delay;
        ideal.menu.antiaim_elements_t[1].antiaim_yaw_slider_adv_left;
        ideal.menu.antiaim_elements_t[1].antiaim_yaw_slider_adv_right;
        ideal.menu.antiaim_elements_t[1].antiaim_body_yaw_adv_left;
        ideal.menu.antiaim_elements_t[1].antiaim_body_yaw_adv_right;
        ideal.menu.antiaim_elements_t[1].antiaim_yaw_jitter;
        ideal.menu.antiaim_elements_t[1].antiaim_yaw_jitter_slider;
        ideal.menu.antiaim_elements_t[1].antiaim_yaw_jitter_slider_l;
        ideal.menu.antiaim_elements_t[1].antiaim_yaw_jitter_slider_r;
        ideal.menu.antiaim_elements_t[1].antiaim_body_yaw;
        ideal.menu.antiaim_elements_t[1].antiaim_body_yaw_slider;
        ideal.menu.antiaim_elements_t[1].antiaim_defensive;
        ideal.menu.antiaim_elements_t[2].enable;
        ideal.menu.antiaim_elements_t[2].antiaim_pitch;
        ideal.menu.antiaim_elements_t[2].antiaim_pitch_slider;
        ideal.menu.antiaim_elements_t[2].antiaim_yaw_base;
        ideal.menu.antiaim_elements_t[2].antiaim_yaw;
        ideal.menu.antiaim_elements_t[2].antiaim_yaw_advanced;
        ideal.menu.antiaim_elements_t[2].antiaim_yaw_slider;
        ideal.menu.antiaim_elements_t[2].antiaim_yaw_slider_left;
        ideal.menu.antiaim_elements_t[2].antiaim_yaw_slider_right;
        ideal.menu.antiaim_elements_t[2].antiaim_yaw_slider_adv_tick;
        ideal.menu.antiaim_elements_t[2].antiaim_yaw_slider_adv_delay;
        ideal.menu.antiaim_elements_t[2].antiaim_yaw_slider_adv_left;
        ideal.menu.antiaim_elements_t[2].antiaim_yaw_slider_adv_right;
        ideal.menu.antiaim_elements_t[2].antiaim_body_yaw_adv_left;
        ideal.menu.antiaim_elements_t[2].antiaim_body_yaw_adv_right;
        ideal.menu.antiaim_elements_t[2].antiaim_yaw_jitter;
        ideal.menu.antiaim_elements_t[2].antiaim_yaw_jitter_slider;
        ideal.menu.antiaim_elements_t[2].antiaim_yaw_jitter_slider_l;
        ideal.menu.antiaim_elements_t[2].antiaim_yaw_jitter_slider_r;
        ideal.menu.antiaim_elements_t[2].antiaim_body_yaw;
        ideal.menu.antiaim_elements_t[2].antiaim_body_yaw_slider;
        ideal.menu.antiaim_elements_t[2].antiaim_defensive;
        ideal.menu.antiaim_elements_t[3].enable;
        ideal.menu.antiaim_elements_t[3].antiaim_pitch;
        ideal.menu.antiaim_elements_t[3].antiaim_pitch_slider;
        ideal.menu.antiaim_elements_t[3].antiaim_yaw_base;
        ideal.menu.antiaim_elements_t[3].antiaim_yaw;
        ideal.menu.antiaim_elements_t[3].antiaim_yaw_advanced;
        ideal.menu.antiaim_elements_t[3].antiaim_yaw_slider;
        ideal.menu.antiaim_elements_t[3].antiaim_yaw_slider_left;
        ideal.menu.antiaim_elements_t[3].antiaim_yaw_slider_right;
        ideal.menu.antiaim_elements_t[3].antiaim_yaw_slider_adv_tick;
        ideal.menu.antiaim_elements_t[3].antiaim_yaw_slider_adv_delay;
        ideal.menu.antiaim_elements_t[3].antiaim_yaw_slider_adv_left;
        ideal.menu.antiaim_elements_t[3].antiaim_yaw_slider_adv_right;
        ideal.menu.antiaim_elements_t[3].antiaim_body_yaw_adv_left;
        ideal.menu.antiaim_elements_t[3].antiaim_body_yaw_adv_right;
        ideal.menu.antiaim_elements_t[3].antiaim_yaw_jitter;
        ideal.menu.antiaim_elements_t[3].antiaim_yaw_jitter_slider;
        ideal.menu.antiaim_elements_t[3].antiaim_yaw_jitter_slider_l;
        ideal.menu.antiaim_elements_t[3].antiaim_yaw_jitter_slider_r;
        ideal.menu.antiaim_elements_t[3].antiaim_body_yaw;
        ideal.menu.antiaim_elements_t[3].antiaim_body_yaw_slider;
        ideal.menu.antiaim_elements_t[3].antiaim_defensive;
        ideal.menu.antiaim_elements_t[4].enable;
        ideal.menu.antiaim_elements_t[4].antiaim_pitch;
        ideal.menu.antiaim_elements_t[4].antiaim_pitch_slider;
        ideal.menu.antiaim_elements_t[4].antiaim_yaw_base;
        ideal.menu.antiaim_elements_t[4].antiaim_yaw;
        ideal.menu.antiaim_elements_t[4].antiaim_yaw_advanced;
        ideal.menu.antiaim_elements_t[4].antiaim_yaw_slider;
        ideal.menu.antiaim_elements_t[4].antiaim_yaw_slider_left;
        ideal.menu.antiaim_elements_t[4].antiaim_yaw_slider_right;
        ideal.menu.antiaim_elements_t[4].antiaim_yaw_slider_adv_tick;
        ideal.menu.antiaim_elements_t[4].antiaim_yaw_slider_adv_delay;
        ideal.menu.antiaim_elements_t[4].antiaim_yaw_slider_adv_left;
        ideal.menu.antiaim_elements_t[4].antiaim_yaw_slider_adv_right;
        ideal.menu.antiaim_elements_t[4].antiaim_body_yaw_adv_left;
        ideal.menu.antiaim_elements_t[4].antiaim_body_yaw_adv_right;
        ideal.menu.antiaim_elements_t[4].antiaim_yaw_jitter;
        ideal.menu.antiaim_elements_t[4].antiaim_yaw_jitter_slider;
        ideal.menu.antiaim_elements_t[4].antiaim_yaw_jitter_slider_l;
        ideal.menu.antiaim_elements_t[4].antiaim_yaw_jitter_slider_r;
        ideal.menu.antiaim_elements_t[4].antiaim_body_yaw;
        ideal.menu.antiaim_elements_t[4].antiaim_body_yaw_slider;
        ideal.menu.antiaim_elements_t[4].antiaim_defensive;
        ideal.menu.antiaim_elements_t[5].enable;
        ideal.menu.antiaim_elements_t[5].antiaim_pitch;
        ideal.menu.antiaim_elements_t[5].antiaim_pitch_slider;
        ideal.menu.antiaim_elements_t[5].antiaim_yaw_base;
        ideal.menu.antiaim_elements_t[5].antiaim_yaw;
        ideal.menu.antiaim_elements_t[5].antiaim_yaw_advanced;
        ideal.menu.antiaim_elements_t[5].antiaim_yaw_slider;
        ideal.menu.antiaim_elements_t[5].antiaim_yaw_slider_left;
        ideal.menu.antiaim_elements_t[5].antiaim_yaw_slider_right;
        ideal.menu.antiaim_elements_t[5].antiaim_yaw_slider_adv_tick;
        ideal.menu.antiaim_elements_t[5].antiaim_yaw_slider_adv_delay;
        ideal.menu.antiaim_elements_t[5].antiaim_yaw_slider_adv_left;
        ideal.menu.antiaim_elements_t[5].antiaim_yaw_slider_adv_right;
        ideal.menu.antiaim_elements_t[5].antiaim_body_yaw_adv_left;
        ideal.menu.antiaim_elements_t[5].antiaim_body_yaw_adv_right;
        ideal.menu.antiaim_elements_t[5].antiaim_yaw_jitter;
        ideal.menu.antiaim_elements_t[5].antiaim_yaw_jitter_slider;
        ideal.menu.antiaim_elements_t[5].antiaim_yaw_jitter_slider_l;
        ideal.menu.antiaim_elements_t[5].antiaim_yaw_jitter_slider_r;
        ideal.menu.antiaim_elements_t[5].antiaim_body_yaw;
        ideal.menu.antiaim_elements_t[5].antiaim_body_yaw_slider;
        ideal.menu.antiaim_elements_t[5].antiaim_defensive;
        ideal.menu.antiaim_elements_t[6].enable;
        ideal.menu.antiaim_elements_t[6].antiaim_pitch;
        ideal.menu.antiaim_elements_t[6].antiaim_pitch_slider;
        ideal.menu.antiaim_elements_t[6].antiaim_yaw_base;
        ideal.menu.antiaim_elements_t[6].antiaim_yaw;
        ideal.menu.antiaim_elements_t[6].antiaim_yaw_advanced;
        ideal.menu.antiaim_elements_t[6].antiaim_yaw_slider;
        ideal.menu.antiaim_elements_t[6].antiaim_yaw_slider_left;
        ideal.menu.antiaim_elements_t[6].antiaim_yaw_slider_right;
        ideal.menu.antiaim_elements_t[6].antiaim_yaw_slider_adv_tick;
        ideal.menu.antiaim_elements_t[6].antiaim_yaw_slider_adv_delay;
        ideal.menu.antiaim_elements_t[6].antiaim_yaw_slider_adv_left;
        ideal.menu.antiaim_elements_t[6].antiaim_yaw_slider_adv_right;
        ideal.menu.antiaim_elements_t[6].antiaim_body_yaw_adv_left;
        ideal.menu.antiaim_elements_t[6].antiaim_body_yaw_adv_right;
        ideal.menu.antiaim_elements_t[6].antiaim_yaw_jitter;
        ideal.menu.antiaim_elements_t[6].antiaim_yaw_jitter_slider;
        ideal.menu.antiaim_elements_t[6].antiaim_yaw_jitter_slider_l;
        ideal.menu.antiaim_elements_t[6].antiaim_yaw_jitter_slider_r;
        ideal.menu.antiaim_elements_t[6].antiaim_body_yaw;
        ideal.menu.antiaim_elements_t[6].antiaim_body_yaw_slider;
        ideal.menu.antiaim_elements_t[6].antiaim_defensive;
        ideal.menu.antiaim_elements_t[7].enable;
        ideal.menu.antiaim_elements_t[7].antiaim_pitch;
        ideal.menu.antiaim_elements_t[7].antiaim_pitch_slider;
        ideal.menu.antiaim_elements_t[7].antiaim_yaw_base;
        ideal.menu.antiaim_elements_t[7].antiaim_yaw;
        ideal.menu.antiaim_elements_t[7].antiaim_yaw_advanced;
        ideal.menu.antiaim_elements_t[7].antiaim_yaw_slider;
        ideal.menu.antiaim_elements_t[7].antiaim_yaw_slider_left;
        ideal.menu.antiaim_elements_t[7].antiaim_yaw_slider_right;
        ideal.menu.antiaim_elements_t[7].antiaim_yaw_slider_adv_tick;
        ideal.menu.antiaim_elements_t[7].antiaim_yaw_slider_adv_delay;
        ideal.menu.antiaim_elements_t[7].antiaim_yaw_slider_adv_left;
        ideal.menu.antiaim_elements_t[7].antiaim_yaw_slider_adv_right;
        ideal.menu.antiaim_elements_t[7].antiaim_body_yaw_adv_left;
        ideal.menu.antiaim_elements_t[7].antiaim_body_yaw_adv_right;
        ideal.menu.antiaim_elements_t[7].antiaim_yaw_jitter;
        ideal.menu.antiaim_elements_t[7].antiaim_yaw_jitter_slider;
        ideal.menu.antiaim_elements_t[7].antiaim_yaw_jitter_slider_l;
        ideal.menu.antiaim_elements_t[7].antiaim_yaw_jitter_slider_r;
        ideal.menu.antiaim_elements_t[7].antiaim_body_yaw;
        ideal.menu.antiaim_elements_t[7].antiaim_body_yaw_slider;
        ideal.menu.antiaim_elements_t[7].antiaim_defensive;
        ideal.menu.antiaim_elements_t[8].enable;
        ideal.menu.antiaim_elements_t[8].antiaim_pitch;
        ideal.menu.antiaim_elements_t[8].antiaim_pitch_slider;
        ideal.menu.antiaim_elements_t[8].antiaim_yaw_base;
        ideal.menu.antiaim_elements_t[8].antiaim_yaw;
        ideal.menu.antiaim_elements_t[8].antiaim_yaw_advanced;
        ideal.menu.antiaim_elements_t[8].antiaim_yaw_slider;
        ideal.menu.antiaim_elements_t[8].antiaim_yaw_slider_left;
        ideal.menu.antiaim_elements_t[8].antiaim_yaw_slider_right;
        ideal.menu.antiaim_elements_t[8].antiaim_yaw_slider_adv_tick;
        ideal.menu.antiaim_elements_t[8].antiaim_yaw_slider_adv_delay;
        ideal.menu.antiaim_elements_t[8].antiaim_yaw_slider_adv_left;
        ideal.menu.antiaim_elements_t[8].antiaim_yaw_slider_adv_right;
        ideal.menu.antiaim_elements_t[8].antiaim_body_yaw_adv_left;
        ideal.menu.antiaim_elements_t[8].antiaim_body_yaw_adv_right;
        ideal.menu.antiaim_elements_t[8].antiaim_yaw_jitter;
        ideal.menu.antiaim_elements_t[8].antiaim_yaw_jitter_slider;
        ideal.menu.antiaim_elements_t[8].antiaim_yaw_jitter_slider_l;
        ideal.menu.antiaim_elements_t[8].antiaim_yaw_jitter_slider_r;
        ideal.menu.antiaim_elements_t[8].antiaim_body_yaw;
        ideal.menu.antiaim_elements_t[8].antiaim_body_yaw_slider;
        ideal.menu.antiaim_elements_t[8].antiaim_defensive;
        ideal.menu.antiaim_elements_t[9].enable;
        ideal.menu.antiaim_elements_t[9].antiaim_pitch;
        ideal.menu.antiaim_elements_t[9].antiaim_pitch_slider;
        ideal.menu.antiaim_elements_t[9].antiaim_yaw_base;
        ideal.menu.antiaim_elements_t[9].antiaim_yaw;
        ideal.menu.antiaim_elements_t[9].antiaim_yaw_advanced;
        ideal.menu.antiaim_elements_t[9].antiaim_yaw_slider;
        ideal.menu.antiaim_elements_t[9].antiaim_yaw_slider_left;
        ideal.menu.antiaim_elements_t[9].antiaim_yaw_slider_right;
        ideal.menu.antiaim_elements_t[9].antiaim_yaw_slider_adv_tick;
        ideal.menu.antiaim_elements_t[9].antiaim_yaw_slider_adv_delay;
        ideal.menu.antiaim_elements_t[9].antiaim_yaw_slider_adv_left;
        ideal.menu.antiaim_elements_t[9].antiaim_yaw_slider_adv_right;
        ideal.menu.antiaim_elements_t[9].antiaim_body_yaw_adv_left;
        ideal.menu.antiaim_elements_t[9].antiaim_body_yaw_adv_right;
        ideal.menu.antiaim_elements_t[9].antiaim_yaw_jitter;
        ideal.menu.antiaim_elements_t[9].antiaim_yaw_jitter_slider;
        ideal.menu.antiaim_elements_t[9].antiaim_yaw_jitter_slider_l;
        ideal.menu.antiaim_elements_t[9].antiaim_yaw_jitter_slider_r;
        ideal.menu.antiaim_elements_t[9].antiaim_body_yaw;
        ideal.menu.antiaim_elements_t[9].antiaim_body_yaw_slider;
        ideal.menu.antiaim_elements_t[9].antiaim_defensive;
    };

    keybindsandothertable = {};
    other_aa = {};
}

local export_config = ui.new_button("AA", "Anti-aimbot angles", "\aB3BED6FFExport", function ()
    local Code = {{}, {}, {}};

    for _, main in pairs(ideal.table.config_data.cfg_data.anti_aim) do
        if ui.get(main) ~= nil then
            table.insert(Code[1], tostring(ui.get(main)))
        end
    end

    for _, main in pairs(ideal.table.config_data.cfg_data.keybindsandothertable) do
        if ui.get(main) ~= nil then
            table.insert(Code[2], tostring(framework.library["=>"].func.arr_to_string(main)))
        end
    end

    for _, main in pairs(ideal.table.config_data.cfg_data.other_aa) do
        if ui.get(main) ~= nil then
            table.insert(Code[3], tostring(ui.get(main)))
        end
    end

    clipboard.set(base64.encode(json.stringify(Code)))
end);
local import_config = ui.new_button("AA", "Anti-aimbot angles", "\aB3BED6FFImport", function ()
    local protected = function() 
        for k, v in pairs(json.parse(base64.decode(clipboard.get()))) do
            
            k = ({[1] = "anti_aim", [2] = "keybindsandothertable", [3] = "other_aa"})[k]

            for k2, v2 in pairs(v) do
                if (k == "anti_aim") then
                    if v2 == "true" then
                        ui.set(ideal.table.config_data.cfg_data[k][k2], true)
                    elseif v2 == "false" then
                        ui.set(ideal.table.config_data.cfg_data[k][k2], false)
                    else
                        ui.set(ideal.table.config_data.cfg_data[k][k2], v2)
                    end
                end
                if (k == "keybindsandothertable") then
                    ui.set(ideal.table.config_data.cfg_data[k][k2], framework.library["=>"].func.str_to_sub(v2, ","))
                end
                if (k == "other_aa") then
                    if v2 == "true" then
                        ui.set(ideal.table.config_data.cfg_data[k][k2], true)
                    elseif v2 == "false" then
                        ui.set(ideal.table.config_data.cfg_data[k][k2], false)
                    else
                        ui.set(ideal.table.config_data.cfg_data[k][k2], v2)
                    end
                end
            end
        end
    end
    local status, message = pcall(protected)
    if not status then
        error("we get error on importing config")
        return
    end
end);

client.set_event_callback( "paint_ui", function(  )
if ui.get(ideal.menu.antiaim_list) == "slow jitter" then
    preset_data = "W1siZG93biIsIjAiLCJhdCB0YXJnZXRzIiwiMTgwIiwic3RhdGljIiwiNSIsIjAiLCIwIiwiMSIsIjEiLCIwIiwiMCIsIm9mZiIsIm9mZiIsImNlbnRlciIsIjY4IiwiMCIsIjAiLCJqaXR0ZXIiLCIwIiwib2ZmIiwidHJ1ZSIsImRvd24iLCIwIiwiYXQgdGFyZ2V0cyIsIjE4MCIsInRpY2siLCIwIiwiMzQiLCItMzQiLCI1IiwiNiIsIjMwIiwiLTIwIiwib2ZmIiwib2ZmIiwib2ZmIiwiMCIsIjAiLCIwIiwib2ZmIiwiMCIsIm9mZiIsInRydWUiLCJkb3duIiwiODkiLCJhdCB0YXJnZXRzIiwiMTgwIiwidGljayIsIjAiLCItMzIiLCIyNyIsIjciLCI3IiwiNDMiLCItMjgiLCJvZmYiLCJvZmYiLCJvZmYiLCIwIiwiMCIsIjAiLCJvZmYiLCIwIiwib2ZmIiwidHJ1ZSIsImRvd24iLCIwIiwiYXQgdGFyZ2V0cyIsIjE4MCIsInRpY2siLCIwIiwiMCIsIjAiLCI2IiwiNSIsIjI1IiwiLTE4Iiwib2ZmIiwib2ZmIiwib2ZmIiwiMCIsIjAiLCIwIiwib2ZmIiwiMCIsIm9mZiIsInRydWUiLCJtaW5pbWFsIiwiMCIsImF0IHRhcmdldHMiLCIxODAiLCJ0aWNrIiwiMCIsIi0yMyIsIjMwIiwiNSIsIjYiLCIzMCIsIi0xMiIsIm9mZiIsIm9mZiIsIm9mZiIsIjAiLCIwIiwiMCIsIm9mZiIsIjAiLCJvZmYiLCJ0cnVlIiwibWluaW1hbCIsIjAiLCJhdCB0YXJnZXRzIiwiMTgwIiwidGljayIsIjAiLCItMTkiLCIzOCIsIjUiLCI2IiwiMzkiLCItMTYiLCJvZmYiLCJvZmYiLCJvZmYiLCIwIiwiMCIsIjAiLCJvZmYiLCIwIiwiYWx3YXlzIG9uIiwidHJ1ZSIsImRvd24iLCIwIiwiYXQgdGFyZ2V0cyIsIjE4MCIsInRpY2siLCIwIiwiLTMwIiwiNDAiLCI2IiwiNiIsIjM5IiwiLTIzIiwib2ZmIiwib2ZmIiwib2ZmIiwiMCIsIjAiLCIwIiwib2ZmIiwiMCIsIm9mZiIsInRydWUiLCJtaW5pbWFsIiwiMCIsImF0IHRhcmdldHMiLCIxODAiLCJ0aWNrIiwiMCIsIi00MSIsIjM0IiwiNSIsIjUiLCIyNCIsIi0yMCIsIm9mZiIsIm9mZiIsIm9mZiIsIjAiLCIwIiwiMCIsIm9mZiIsIjAiLCJvZmYiLCJ0cnVlIiwibWluaW1hbCIsIjAiLCJhdCB0YXJnZXRzIiwiMTgwIiwidGljayIsIjQiLCIxNiIsIi0xIiwiNiIsIjMiLCIzNCIsIi0yMyIsIm9mZiIsIm9mZiIsIm9mZiIsIjEiLCIxMDQiLCItNyIsImppdHRlciIsIjAiLCJvZmYiLCJkb3duIiwiMCIsImF0IHRhcmdldHMiLCIxODAiLCJzdGF0aWMiLCI1IiwiMCIsIjAiLCIxIiwiMSIsIjAiLCIwIiwib2ZmIiwib2ZmIiwiY2VudGVyIiwiNjgiLCIwIiwiMCIsImppdHRlciIsIjAiLCJvZmYiLCJ0cnVlIiwiZG93biIsIjAiLCJhdCB0YXJnZXRzIiwiMTgwIiwidGljayIsIjAiLCIzNCIsIi0zNCIsIjUiLCI2IiwiMzAiLCItMjAiLCJvZmYiLCJvZmYiLCJvZmYiLCIwIiwiMCIsIjAiLCJvZmYiLCIwIiwib2ZmIiwidHJ1ZSIsImRvd24iLCI4OSIsImF0IHRhcmdldHMiLCIxODAiLCJ0aWNrIiwiMCIsIi0zMiIsIjI3IiwiNyIsIjciLCI0MyIsIi0yOCIsIm9mZiIsIm9mZiIsIm9mZiIsIjAiLCIwIiwiMCIsIm9mZiIsIjAiLCJvZmYiLCJ0cnVlIiwiZG93biIsIjAiLCJhdCB0YXJnZXRzIiwiMTgwIiwidGljayIsIjAiLCIwIiwiMCIsIjYiLCI1IiwiMjUiLCItMTgiLCJvZmYiLCJvZmYiLCJvZmYiLCIwIiwiMCIsIjAiLCJvZmYiLCIwIiwib2ZmIiwidHJ1ZSIsIm1pbmltYWwiLCIwIiwiYXQgdGFyZ2V0cyIsIjE4MCIsInRpY2siLCIwIiwiLTIzIiwiMzAiLCI1IiwiNiIsIjMwIiwiLTEyIiwib2ZmIiwib2ZmIiwib2ZmIiwiMCIsIjAiLCIwIiwib2ZmIiwiMCIsIm9mZiIsInRydWUiLCJtaW5pbWFsIiwiMCIsImF0IHRhcmdldHMiLCIxODAiLCJ0aWNrIiwiMCIsIi0xOSIsIjM4IiwiNSIsIjYiLCIzOSIsIi0xNiIsIm9mZiIsIm9mZiIsIm9mZiIsIjAiLCIwIiwiMCIsIm9mZiIsIjAiLCJhbHdheXMgb24iLCJ0cnVlIiwiZG93biIsIjAiLCJhdCB0YXJnZXRzIiwiMTgwIiwidGljayIsIjAiLCItMzAiLCI0MCIsIjYiLCI2IiwiMzkiLCItMjMiLCJvZmYiLCJvZmYiLCJvZmYiLCIwIiwiMCIsIjAiLCJvZmYiLCIwIiwib2ZmIiwidHJ1ZSIsIm1pbmltYWwiLCIwIiwiYXQgdGFyZ2V0cyIsIjE4MCIsInRpY2siLCIwIiwiLTQxIiwiMzQiLCI1IiwiNSIsIjM3IiwiLTI0Iiwib2ZmIiwib2ZmIiwib2ZmIiwiMCIsIjAiLCIwIiwib2ZmIiwiMCIsIm9mZiIsInRydWUiLCJtaW5pbWFsIiwiMCIsImF0IHRhcmdldHMiLCIxODAiLCJ0aWNrIiwiNCIsIjE2IiwiLTEiLCI2IiwiMyIsIjM0IiwiLTIzIiwib2ZmIiwib2ZmIiwib2ZmIiwiMSIsIjEwNCIsIi03Iiwiaml0dGVyIiwiMCIsIm9mZiJdLHt9LHt9XQ=="
elseif ui.get(ideal.menu.antiaim_list) == "custom desync" then
    preset_data = "W1siZG93biIsIjAiLCJhdCB0YXJnZXRzIiwiMTgwIiwic3RhdGljIiwiNSIsIjAiLCIwIiwiMSIsIjEiLCIwIiwiMCIsIm9mZiIsIm9mZiIsImNlbnRlciIsIjY4IiwiMCIsIjAiLCJqaXR0ZXIiLCIwIiwib2ZmIiwidHJ1ZSIsImRvd24iLCIwIiwiYXQgdGFyZ2V0cyIsIjE4MCIsImN1c3RvbSBkZXN5bmMiLCIwIiwiMzQiLCItMzQiLCIxIiwiMSIsIjAiLCIwIiwib2ZmIiwib2ZmIiwib2ZmIiwiMCIsIjAiLCIwIiwib2ZmIiwiMCIsIm9mZiIsInRydWUiLCJkb3duIiwiODkiLCJhdCB0YXJnZXRzIiwiMTgwIiwiY3VzdG9tIGRlc3luYyIsIjAiLCItMzIiLCIyNyIsIjEiLCIxIiwiMCIsIjAiLCJvZmYiLCJvZmYiLCJvZmYiLCIwIiwiMCIsIjAiLCJvZmYiLCIwIiwiYWx3YXlzIG9uIiwidHJ1ZSIsImRvd24iLCIwIiwiYXQgdGFyZ2V0cyIsIjE4MCIsInRpY2siLCIwIiwiMCIsIjAiLCIxMCIsIjUiLCItMzAiLCI2MCIsImppdHRlciIsIm9mZiIsIm9mZiIsIjAiLCIwIiwiMCIsIm9mZiIsIjAiLCJvZmYiLCJ0cnVlIiwibWluaW1hbCIsIjAiLCJhdCB0YXJnZXRzIiwiMTgwIiwiY3VzdG9tIGRlc3luYyIsIjAiLCItMjUiLCIzMCIsIjEiLCIxIiwiMCIsIjAiLCJvZmYiLCJvZmYiLCJvZmYiLCIwIiwiMCIsIjAiLCJvZmYiLCIwIiwiYWx3YXlzIG9uIiwidHJ1ZSIsIm1pbmltYWwiLCIwIiwiYXQgdGFyZ2V0cyIsIjE4MCIsImN1c3RvbSBkZXN5bmMiLCIwIiwiLTE5IiwiMzgiLCIxIiwiMSIsIjAiLCIwIiwib2ZmIiwib2ZmIiwib2ZmIiwiMCIsIjAiLCIwIiwib2ZmIiwiMCIsIm9mZiIsInRydWUiLCJkb3duIiwiMCIsImF0IHRhcmdldHMiLCIxODAiLCJjdXN0b20gZGVzeW5jIiwiMCIsIi0yNSIsIjQwIiwiMSIsIjEiLCIwIiwiMCIsIm9mZiIsIm9mZiIsIm9mZiIsIjAiLCIwIiwiMCIsIm9mZiIsIjAiLCJvZmYiLCJ0cnVlIiwibWluaW1hbCIsIjAiLCJhdCB0YXJnZXRzIiwiMTgwIiwiY3VzdG9tIGRlc3luYyIsIjAiLCItNDEiLCIzNCIsIjEiLCIxIiwiMCIsIjAiLCJvZmYiLCJvZmYiLCJvZmYiLCIwIiwiMCIsIjAiLCJvZmYiLCIwIiwib2ZmIiwidHJ1ZSIsIm1pbmltYWwiLCIwIiwiYXQgdGFyZ2V0cyIsIjE4MCIsInN0YXRpYyIsIjQiLCIwIiwiMCIsIjEiLCIxIiwiMCIsIjAiLCJvZmYiLCJvZmYiLCJjZW50ZXIiLCI2MSIsIjAiLCIwIiwiaml0dGVyIiwiMCIsIm9mZiIsImRvd24iLCIwIiwiYXQgdGFyZ2V0cyIsIjE4MCIsInN0YXRpYyIsIjUiLCIwIiwiMCIsIjEiLCIxIiwiMCIsIjAiLCJvZmYiLCJvZmYiLCJjZW50ZXIiLCI2OCIsIjAiLCIwIiwiaml0dGVyIiwiMCIsIm9mZiIsInRydWUiLCJkb3duIiwiMCIsImF0IHRhcmdldHMiLCIxODAiLCJjdXN0b20gZGVzeW5jIiwiMCIsIjM0IiwiLTM0IiwiMSIsIjEiLCIwIiwiMCIsIm9mZiIsIm9mZiIsIm9mZiIsIjAiLCIwIiwiMCIsIm9mZiIsIjAiLCJvZmYiLCJ0cnVlIiwiZG93biIsIjg5IiwiYXQgdGFyZ2V0cyIsIjE4MCIsImN1c3RvbSBkZXN5bmMiLCIwIiwiLTMyIiwiMjciLCIxIiwiMSIsIjAiLCIwIiwib2ZmIiwib2ZmIiwib2ZmIiwiMCIsIjAiLCIwIiwib2ZmIiwiMCIsImFsd2F5cyBvbiIsInRydWUiLCJkb3duIiwiMCIsImF0IHRhcmdldHMiLCIxODAiLCJ0aWNrIiwiMCIsIjAiLCIwIiwiMTAiLCI1IiwiLTMwIiwiNjAiLCJqaXR0ZXIiLCJvZmYiLCJvZmYiLCIwIiwiMCIsIjAiLCJvZmYiLCIwIiwib2ZmIiwidHJ1ZSIsIm1pbmltYWwiLCIwIiwiYXQgdGFyZ2V0cyIsIjE4MCIsImN1c3RvbSBkZXN5bmMiLCIwIiwiLTIzIiwiMzAiLCIxIiwiMSIsIjAiLCIwIiwib2ZmIiwib2ZmIiwib2ZmIiwiMCIsIjAiLCIwIiwib2ZmIiwiMCIsImFsd2F5cyBvbiIsInRydWUiLCJtaW5pbWFsIiwiMCIsImF0IHRhcmdldHMiLCIxODAiLCJjdXN0b20gZGVzeW5jIiwiMCIsIi0xOSIsIjM2IiwiMSIsIjEiLCIwIiwiMCIsIm9mZiIsIm9mZiIsIm9mZiIsIjAiLCIwIiwiMCIsIm9mZiIsIjAiLCJvZmYiLCJ0cnVlIiwiZG93biIsIjAiLCJhdCB0YXJnZXRzIiwiMTgwIiwiY3VzdG9tIGRlc3luYyIsIjAiLCItMzAiLCI0MCIsIjEiLCIxIiwiMCIsIjAiLCJvZmYiLCJvZmYiLCJvZmYiLCIwIiwiMCIsIjAiLCJvZmYiLCIwIiwib2ZmIiwidHJ1ZSIsIm1pbmltYWwiLCIwIiwiYXQgdGFyZ2V0cyIsIjE4MCIsImN1c3RvbSBkZXN5bmMiLCIwIiwiLTQxIiwiMzQiLCIxIiwiMSIsIjAiLCIwIiwib2ZmIiwib2ZmIiwib2ZmIiwiMCIsIjAiLCIwIiwib2ZmIiwiMCIsIm9mZiIsInRydWUiLCJtaW5pbWFsIiwiMCIsImF0IHRhcmdldHMiLCIxODAiLCJzdGF0aWMiLCI0IiwiMCIsIjAiLCIxIiwiMSIsIjAiLCIwIiwib2ZmIiwib2ZmIiwiY2VudGVyIiwiNjEiLCIwIiwiMCIsImppdHRlciIsIjAiLCJvZmYiXSx7fSx7fV0="
elseif ui.get(ideal.menu.antiaim_list) == "unmatched" then
    preset_data = "W1siY3VzdG9tIiwiODkiLCJhdCB0YXJnZXRzIiwiMTgwIiwiY3VzdG9tIGRlc3luYyIsIjAiLCItMjAiLCIyMCIsIjEiLCIxIiwiMCIsIjAiLCJvZmYiLCJvZmYiLCJsZWZ0IF4gcmlnaHQgY2VudGVyIiwiMCIsIi0xMCIsIjEwIiwib2ZmIiwiMCIsInN3aXRjaCBjeWNsZSIsInRydWUiLCJjdXN0b20iLCI4OSIsImF0IHRhcmdldHMiLCIxODAiLCJhbnRpLWJyZWFrIiwiMCIsIjAiLCIwIiwiNiIsIjEiLCItMjQiLCIyNCIsIm9mZiIsIm9mZiIsIm9mZiIsIjAiLCItMTAiLCIxMCIsIm9mZiIsIjAiLCJvZmYiLCJ0cnVlIiwiY3VzdG9tIiwiODkiLCJhdCB0YXJnZXRzIiwiMTgwIiwiY3VzdG9tIGRlc3luYyIsIjAiLCItMjQiLCIyNCIsIjMiLCIxIiwiLTE1IiwiMTUiLCJvZmYiLCJvZmYiLCJvZmYiLCIwIiwiLTE1IiwiMTUiLCJvZmYiLCIwIiwib2ZmIiwidHJ1ZSIsImN1c3RvbSIsIjg5IiwiYXQgdGFyZ2V0cyIsIjE4MCIsImN1c3RvbSBkZXN5bmMiLCIwIiwiLTIwIiwiMjAiLCIxIiwiMSIsIjAiLCIwIiwib2ZmIiwib2ZmIiwib2ZmIiwiMCIsIi0xMCIsIjEwIiwib2ZmIiwiMCIsIm9mZiIsInRydWUiLCJjdXN0b20iLCI4OSIsImF0IHRhcmdldHMiLCIxODAiLCJjdXN0b20gZGVzeW5jIiwiMCIsIi0zMSIsIjMxIiwiMiIsIjEiLCItMzAiLCIzMCIsIm9mZiIsIm9mZiIsIm9mZiIsIjAiLCItMTciLCIxNyIsIm9mZiIsIjAiLCJzd2l0Y2ggY3ljbGUiLCJ0cnVlIiwiY3VzdG9tIiwiODkiLCJhdCB0YXJnZXRzIiwiMTgwIiwiY3VzdG9tIGRlc3luYyIsIjAiLCItMjkiLCIyOSIsIjEiLCIxIiwiLTIyIiwiMjIiLCJvZmYiLCJvZmYiLCJvZmYiLCIwIiwiLTE1IiwiMTUiLCJvZmYiLCIwIiwic3dpdGNoIGN5Y2xlIiwidHJ1ZSIsImN1c3RvbSIsIjg5IiwiYXQgdGFyZ2V0cyIsIjE4MCIsImN1c3RvbSBkZXN5bmMiLCIwIiwiNDAiLCItMTYiLCIxIiwiMSIsIjAiLCIwIiwib2ZmIiwib2ZmIiwib2ZmIiwiMCIsIjAiLCIwIiwib2ZmIiwiMCIsIm9mZiIsInRydWUiLCJjdXN0b20iLCI4OSIsImF0IHRhcmdldHMiLCIxODAiLCJhbnRpLWJyZWFrIiwiMCIsIjAiLCIwIiwiMSIsIjEiLCItMTciLCIxNyIsIm9mZiIsIm9mZiIsImxlZnQgXiByaWdodCBjZW50ZXIiLCIwIiwiLTE5IiwiMTkiLCJvZmYiLCIwIiwic3dpdGNoIGN5Y2xlIiwidHJ1ZSIsImN1c3RvbSIsIjg5IiwiYXQgdGFyZ2V0cyIsIjE4MCIsImFudGktYnJlYWsiLCIwIiwiMCIsIjAiLCIxIiwiMSIsIi0yNiIsIjI2Iiwib2ZmIiwib2ZmIiwib2ZmIiwiMCIsIi0xMCIsIjEwIiwib2ZmIiwiMCIsIm9mZiIsImN1c3RvbSIsIjg5IiwiYXQgdGFyZ2V0cyIsIjE4MCIsImN1c3RvbSBkZXN5bmMiLCIwIiwiLTIwIiwiMjAiLCIxIiwiMSIsIjAiLCIwIiwib2ZmIiwib2ZmIiwibGVmdCBeIHJpZ2h0IGNlbnRlciIsIjAiLCItMTAiLCIxMCIsIm9mZiIsIjAiLCJvZmYiLCJ0cnVlIiwiY3VzdG9tIiwiODkiLCJhdCB0YXJnZXRzIiwiMTgwIiwiY3VzdG9tIGRlc3luYyIsIjAiLCIzMCIsIi0zMCIsIjYiLCIxIiwiLTI0IiwiMjQiLCJvZmYiLCJvZmYiLCJvZmYiLCIwIiwiLTEwIiwiMTAiLCJvZmYiLCIwIiwib2ZmIiwidHJ1ZSIsImN1c3RvbSIsIjg5IiwiYXQgdGFyZ2V0cyIsIjE4MCIsImN1c3RvbSBkZXN5bmMiLCIwIiwiLTI0IiwiMjQiLCIzIiwiMSIsIi0xNSIsIjE1Iiwib2ZmIiwib2ZmIiwib2ZmIiwiMCIsIi0xNSIsIjE1Iiwib2ZmIiwiMCIsIm9mZiIsInRydWUiLCJjdXN0b20iLCI4OSIsImF0IHRhcmdldHMiLCIxODAiLCJjdXN0b20gZGVzeW5jIiwiMCIsIi0yMCIsIjIwIiwiMSIsIjEiLCIwIiwiMCIsIm9mZiIsIm9mZiIsIm9mZiIsIjAiLCItMTAiLCIxMCIsIm9mZiIsIjAiLCJhbHdheXMgb24iLCJ0cnVlIiwiY3VzdG9tIiwiODkiLCJhdCB0YXJnZXRzIiwiMTgwIiwiYW50aS1icmVhayIsIjAiLCIzNiIsIi0yOSIsIjgiLCIxIiwiMzYiLCItMjkiLCJvZmYiLCJvZmYiLCJvZmZzZXQiLCIxIiwiLTE3IiwiMTciLCJvZmYiLCIwIiwiYWx3YXlzIG9uIiwidHJ1ZSIsImN1c3RvbSIsIjg5IiwiYXQgdGFyZ2V0cyIsIjE4MCIsInRpY2siLCIwIiwiLTI5IiwiMjkiLCI1IiwiNiIsIjM5IiwiLTE2Iiwib2ZmIiwib2ZmIiwib2ZmIiwiMyIsIjMiLCItMyIsIm9mZiIsIjAiLCJhbHdheXMgb24iLCJ0cnVlIiwiY3VzdG9tIiwiODkiLCJhdCB0YXJnZXRzIiwiMTgwIiwiY3VzdG9tIGRlc3luYyIsIjAiLCI0MCIsIi0xNiIsIjEiLCIxIiwiMCIsIjAiLCJvZmYiLCJvZmYiLCJvZmYiLCIwIiwiMCIsIjAiLCJvZmYiLCIwIiwib2ZmIiwidHJ1ZSIsImN1c3RvbSIsIjg5IiwiYXQgdGFyZ2V0cyIsIjE4MCIsImFudGktYnJlYWsiLCIwIiwiMCIsIjAiLCIxIiwiMSIsIi0xNyIsIjE3Iiwib2ZmIiwib2ZmIiwibGVmdCBeIHJpZ2h0IGNlbnRlciIsIjAiLCItMTkiLCIxOSIsIm9mZiIsIjAiLCJhbHdheXMgb24iLCJ0cnVlIiwiY3VzdG9tIiwiODkiLCJhdCB0YXJnZXRzIiwiMTgwIiwiYW50aS1icmVhayIsIjAiLCIwIiwiMCIsIjEiLCIxIiwiLTI2IiwiMjYiLCJvZmYiLCJvZmYiLCJvZmYiLCIwIiwiLTEwIiwiMTAiLCJvZmYiLCIwIiwib2ZmIl0se30se31d"
elseif ui.get(ideal.menu.antiaim_list) == "keshi" then
    preset_data = "W1sibWluaW1hbCIsIjAiLCJhdCB0YXJnZXRzIiwiMTgwIiwic3RhdGljIiwiMCIsIjAiLCIwIiwiMSIsIjEiLCIwIiwiMCIsIm9mZiIsIm9mZiIsIm9mZnNldCIsIjAiLCIwIiwiMCIsInN0YXRpYyIsIjAiLCJvZmYiLCJ0cnVlIiwibWluaW1hbCIsIjAiLCJhdCB0YXJnZXRzIiwiMTgwIiwiY3VzdG9tIGRlc3luYyIsIjAiLCItMjIiLCI0NSIsIjciLCIxIiwiLTIyIiwiNDUiLCJqaXR0ZXIiLCJqaXR0ZXIiLCJjZW50ZXIiLCIwIiwiMCIsIjAiLCJvZmYiLCIwIiwib2ZmIiwidHJ1ZSIsIm1pbmltYWwiLCIwIiwiYXQgdGFyZ2V0cyIsIjE4MCIsImN1c3RvbSBkZXN5bmMiLCIwIiwiLTM1IiwiNDAiLCIxIiwiMSIsIjAiLCIwIiwib2ZmIiwib2ZmIiwiY2VudGVyIiwiMCIsIjAiLCIwIiwib2ZmIiwiMCIsInN3aXRjaCBjeWNsZSIsInRydWUiLCJtaW5pbWFsIiwiMCIsImF0IHRhcmdldHMiLCIxODAiLCJjdXN0b20gZGVzeW5jIiwiMCIsIi0yOCIsIjQ2IiwiMSIsIjEiLCIwIiwiMCIsIm9mZiIsIm9mZiIsImNlbnRlciIsIjAiLCIwIiwiMCIsIm9mZiIsIjAiLCJzd2l0Y2ggY3ljbGUiLCJ0cnVlIiwiY3VzdG9tIiwiODkiLCJhdCB0YXJnZXRzIiwiMTgwIiwiY3VzdG9tIGRlc3luYyIsIjAiLCI0NCIsIi0yNiIsIjEiLCIxIiwiMCIsIjAiLCJvZmYiLCJvZmYiLCJjZW50ZXIiLCIwIiwiMCIsIjAiLCJvZmYiLCIwIiwic3dpdGNoIGN5Y2xlIiwidHJ1ZSIsImRvd24iLCIwIiwiYXQgdGFyZ2V0cyIsIjE4MCIsImN1c3RvbSBkZXN5bmMiLCIwIiwiNDQiLCItMjYiLCIxIiwiMSIsIjAiLCIwIiwib2ZmIiwib2ZmIiwiY2VudGVyIiwiMCIsIjAiLCIwIiwib2ZmIiwiMCIsInN3aXRjaCBjeWNsZSIsInRydWUiLCJtaW5pbWFsIiwiMCIsImF0IHRhcmdldHMiLCIxODAiLCJjdXN0b20gZGVzeW5jIiwiMCIsIi0zMSIsIjQyIiwiMSIsIjEiLCIwIiwiMCIsIm9mZiIsIm9mZiIsImNlbnRlciIsIjAiLCIwIiwiMCIsIm9mZiIsIjAiLCJzd2l0Y2ggY3ljbGUiLCJ0cnVlIiwiZG93biIsIjAiLCJhdCB0YXJnZXRzIiwiMTgwIiwiY3VzdG9tIGRlc3luYyIsIjAiLCItMjgiLCI0NyIsIjEiLCIxIiwiMCIsIjAiLCJvZmYiLCJvZmYiLCJjZW50ZXIiLCIwIiwiMCIsIjAiLCJvZmYiLCIwIiwic3dpdGNoIGN5Y2xlIiwidHJ1ZSIsImRvd24iLCIwIiwiYXQgdGFyZ2V0cyIsIjE4MCIsImN1c3RvbSBkZXN5bmMiLCIwIiwiMCIsIjAiLCIxIiwiMSIsIjAiLCIwIiwib2ZmIiwib2ZmIiwibGVmdCBeIHJpZ2h0IGNlbnRlciIsIjAiLCIwIiwiMCIsIm9mZiIsIjAiLCJvZmYiLCJvZmYiLCIwIiwiYXQgdGFyZ2V0cyIsIm9mZiIsInN0YXRpYyIsIjAiLCIwIiwiMCIsIjEiLCIxIiwiMCIsIjAiLCJvZmYiLCJvZmYiLCJvZmYiLCIwIiwiMCIsIjAiLCJvZmYiLCIwIiwib2ZmIiwidHJ1ZSIsIm1pbmltYWwiLCIwIiwiYXQgdGFyZ2V0cyIsIjE4MCIsImN1c3RvbSBkZXN5bmMiLCIwIiwiLTIyIiwiNDUiLCI3IiwiMSIsIi0yMiIsIjQ1Iiwiaml0dGVyIiwiaml0dGVyIiwiY2VudGVyIiwiMCIsIjAiLCIwIiwib2ZmIiwiMCIsIm9mZiIsInRydWUiLCJtaW5pbWFsIiwiMCIsImF0IHRhcmdldHMiLCIxODAiLCJjdXN0b20gZGVzeW5jIiwiMCIsIi0zNSIsIjQwIiwiMSIsIjEiLCIwIiwiMCIsIm9mZiIsIm9mZiIsImNlbnRlciIsIjAiLCIwIiwiMCIsIm9mZiIsIjAiLCJvZmYiLCJ0cnVlIiwibWluaW1hbCIsIjAiLCJhdCB0YXJnZXRzIiwiMTgwIiwiY3VzdG9tIGRlc3luYyIsIjAiLCItMjgiLCI0NiIsIjEiLCIxIiwiMCIsIjAiLCJvZmYiLCJvZmYiLCJjZW50ZXIiLCIwIiwiMCIsIjAiLCJvZmYiLCIwIiwib2ZmIiwidHJ1ZSIsImN1c3RvbSIsIjg5IiwiYXQgdGFyZ2V0cyIsIjE4MCIsImN1c3RvbSBkZXN5bmMiLCIwIiwiNDQiLCItMjYiLCIxIiwiMSIsIjAiLCIwIiwib2ZmIiwib2ZmIiwiY2VudGVyIiwiMCIsIjAiLCIwIiwib2ZmIiwiMCIsIm9mZiIsInRydWUiLCJkb3duIiwiMCIsImF0IHRhcmdldHMiLCIxODAiLCJjdXN0b20gZGVzeW5jIiwiMCIsIjQ0IiwiLTI2IiwiMSIsIjEiLCIwIiwiMCIsIm9mZiIsIm9mZiIsImNlbnRlciIsIjAiLCIwIiwiMCIsIm9mZiIsIjAiLCJvZmYiLCJ0cnVlIiwibWluaW1hbCIsIjAiLCJhdCB0YXJnZXRzIiwiMTgwIiwiY3VzdG9tIGRlc3luYyIsIjAiLCItMzEiLCI0MiIsIjEiLCIxIiwiMCIsIjAiLCJvZmYiLCJvZmYiLCJjZW50ZXIiLCIwIiwiMCIsIjAiLCJvZmYiLCIwIiwib2ZmIiwidHJ1ZSIsImRvd24iLCIwIiwiYXQgdGFyZ2V0cyIsIjE4MCIsImN1c3RvbSBkZXN5bmMiLCIwIiwiLTI4IiwiNDciLCIxIiwiMSIsIjAiLCIwIiwib2ZmIiwib2ZmIiwiY2VudGVyIiwiMCIsIjAiLCIwIiwib2ZmIiwiMCIsIm9mZiIsInRydWUiLCJkb3duIiwiMCIsImF0IHRhcmdldHMiLCIxODAiLCJjdXN0b20gZGVzeW5jIiwiMCIsIjAiLCIwIiwiMSIsIjEiLCIwIiwiMCIsIm9mZiIsIm9mZiIsImxlZnQgXiByaWdodCBjZW50ZXIiLCIwIiwiMCIsIjAiLCJvZmYiLCIwIiwib2ZmIl0se30se31d"
end
end)

local load_preset = ui.new_button("AA", "Anti-aimbot angles", "load preset", function ()
    local protected = function() 
        for k, v in pairs(json.parse(base64.decode(preset_data))) do
            
            k = ({[1] = "anti_aim", [2] = "keybindsandothertable", [3] = "other_aa"})[k]

            for k2, v2 in pairs(v) do
                if (k == "anti_aim") then
                    if v2 == "true" then
                        ui.set(ideal.table.config_data.cfg_data[k][k2], true)
                    elseif v2 == "false" then
                        ui.set(ideal.table.config_data.cfg_data[k][k2], false)
                    else
                        ui.set(ideal.table.config_data.cfg_data[k][k2], v2)
                    end
                end
                if (k == "keybindsandothertable") then
                    ui.set(ideal.table.config_data.cfg_data[k][k2], framework.library["=>"].func.str_to_sub(v2, ","))
                end
                if (k == "other_aa") then
                    if v2 == "true" then
                        ui.set(ideal.table.config_data.cfg_data[k][k2], true)
                    elseif v2 == "false" then
                        ui.set(ideal.table.config_data.cfg_data[k][k2], false)
                    else
                        ui.set(ideal.table.config_data.cfg_data[k][k2], v2)
                    end
                end
            end
        end
    end
    local status, message = pcall(protected)
    if not status then
        error("we get error on loading preset")
        return
    end
end);

rgba_to_hex = function(b,c,d,e)
    return string.format('%02x%02x%02x%02x',b,c,d,e)
end
text_fade_animation = function(speed, r, g, b, a, text)
    local final_text = ''
    local curtime = globals.curtime()
    for i=0, #text do
        local color = rgba_to_hex(r, g, b, a*math.abs(1*math.cos(2*speed*curtime/4+i*5/30)))
        final_text = final_text..'\a'..color..text:sub(i, i)
    end
    return final_text
end

client.set_event_callback( "paint_ui", function(  )
    --print(tostring(ui.get(ideal.menu.antiaim_elements_t[1].enable)) .." "..tostring(ui.get(ideal.menu.antiaim_elements_ct[1].enable)))
    setup_skeet_element("vis", nil, nil, "load")
    setup_skeet_element("vis_elem", export_config, ui.get(ideal.menu.tab_selector) == "config", nil)
    setup_skeet_element("vis_elem", import_config, ui.get(ideal.menu.tab_selector) == "config", nil)
    setup_skeet_element("vis_elem", load_preset, ui.get(ideal.menu.tab_selector) == "welcome", nil)
    local r,g,b = ui.get(ideal.menu.color_picker)
    if ui.is_menu_open() then
        ui.set(ideal.menu.tab_label, "ideal \a989898FF- " .. text_fade_animation(8, r,g,b, 255, "qq932084933"))
    end
    local anti_aim_tab = ui.get(ideal.menu.tab_selector) == "anti-aim"
    local misc_tab = ui.get(ideal.menu.tab_selector) == "misc"
    local visuals_tab = ui.get(ideal.menu.tab_selector) == "visuals"
    local main_tab = ui.get(ideal.menu.tab_selector) == "welcome"
    local yaw_addons_enabled = ui.get(ideal.menu.antiaim_enable_addons)
    for i = 1,#ideal.menu.builder_state do
        local selecte = ui.get(ideal.menu.aabuilder_state)
        local team_selected = ui.get(ideal.menu.team_site)
        local conditions_enabled_ct = ui.get(ideal.menu.antiaim_elements_ct[i].enable)
        local conditions_enabled_t = ui.get(ideal.menu.antiaim_elements_t[i].enable)
        local show_ct = anti_aim_tab and selecte == ideal.menu.builder_state[i] and conditions_enabled_ct and team_selected == "counter"
        local show_t = anti_aim_tab and selecte == ideal.menu.builder_state[i] and conditions_enabled_t and team_selected == "terror"
        ui.set_visible(ideal.menu.antiaim_elements_ct[i].enable, anti_aim_tab and selecte == ideal.menu.builder_state[i] and i > 1 and team_selected == "counter")
        ui.set_visible(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_jitter_slider, show_ct and (ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_jitter) == "offset" or ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_jitter) == "center" or ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_jitter) == "random" or ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_jitter) == "skitter"))
        ui.set_visible(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_jitter_slider_r, show_ct and (ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_jitter) == "left ^ right offset" or ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_jitter) == "left ^ right center" or ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_jitter) == "left ^ right random" or ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_jitter) == "left ^ right skitter"))
        ui.set_visible(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_jitter_slider_l, show_ct and (ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_jitter) == "left ^ right offset" or ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_jitter) == "left ^ right center" or ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_jitter) == "left ^ right random" or ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_jitter) == "left ^ right skitter"))

        ui.set_visible(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_slider, show_ct and ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw) ~= "off" and ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced) == "static")
        ui.set_visible(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_slider_left, show_ct and ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw) ~= "off" and ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced) == "custom desync")
        ui.set_visible(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_slider_right, show_ct and ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw) ~= "off" and ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced) == "custom desync")
        ui.set_visible(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_slider_adv_tick, show_ct and ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw) ~= "off" and (ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced) == "tick" or ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced) == "break" or ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced) == "anti-break" or ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced) == "sync"))
        ui.set_visible(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_slider_adv_delay, show_ct and ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw) ~= "off" and (ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced) == "tick"))
        ui.set_visible(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_slider_adv_left, show_ct and ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw) ~= "off" and (ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced) == "tick" or ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced) == "break" or ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced) == "anti-break" or ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced) == "sync"))
        ui.set_visible(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_slider_adv_right, show_ct and ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw) ~= "off" and (ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced) == "tick" or ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced) == "break" or ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced) == "anti-break" or ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced) == "sync"))
        ui.set_visible(ideal.menu.antiaim_elements_ct[i].antiaim_pitch, show_ct)
        ui.set_visible(ideal.menu.antiaim_elements_ct[i].antiaim_pitch_slider, show_ct and ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_pitch) == "custom")
        ui.set_visible(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_base, show_ct)
        ui.set_visible(ideal.menu.antiaim_elements_ct[i].antiaim_yaw, show_ct)
        ui.set_visible(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced, show_ct and ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw) ~= "off")
        ui.set_visible(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_jitter, show_ct)
        ui.set_visible(ideal.menu.antiaim_elements_ct[i].antiaim_body_yaw, show_ct and ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced) ~= "custom desync" and ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced) ~= "tick" and ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced) ~= "break" and ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced) ~= "anti-break" and ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced) ~= "sync")
        ui.set_visible(ideal.menu.antiaim_elements_ct[i].antiaim_body_yaw_slider, show_ct and ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced) ~= "custom desync" and ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_body_yaw) ~= "off" and ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced) ~= "tick" and ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced) ~= "break" and ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced) ~= "anti-break" and ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced) ~= "sync")
        ui.set_visible(ideal.menu.antiaim_elements_ct[i].send_to_t, show_ct)
        ui.set_visible(ideal.menu.antiaim_elements_ct[i].antiaim_defensive, show_ct and selecte ~= "fake lag")
        ui.set_visible(ideal.menu.antiaim_elements_ct[i].antiaim_body_yaw_adv_left, show_ct and ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw) ~= "off" and ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced) == "tick")
        ui.set_visible(ideal.menu.antiaim_elements_ct[i].antiaim_body_yaw_adv_right, show_ct and ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw) ~= "off" and ui.get(ideal.menu.antiaim_elements_ct[i].antiaim_yaw_advanced) == "tick")

        --TT
        
        ui.set_visible(ideal.menu.antiaim_elements_t[i].enable, anti_aim_tab and selecte == ideal.menu.builder_state[i] and i > 1 and team_selected == "terror")
        ui.set_visible(ideal.menu.antiaim_elements_t[i].antiaim_yaw_jitter_slider, show_t and (ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_jitter) == "offset" or ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_jitter) == "center" or ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_jitter) == "random" or ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_jitter) == "skitter"))
        ui.set_visible(ideal.menu.antiaim_elements_t[i].antiaim_yaw_jitter_slider_r, show_t and (ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_jitter) == "left ^ right offset" or ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_jitter) == "left ^ right center" or ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_jitter) == "left ^ right random" or ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_jitter) == "left ^ right skitter"))
        ui.set_visible(ideal.menu.antiaim_elements_t[i].antiaim_yaw_jitter_slider_l, show_t and (ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_jitter) == "left ^ right offset" or ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_jitter) == "left ^ right center" or ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_jitter) == "left ^ right random" or ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_jitter) == "left ^ right skitter"))
        
        ui.set_visible(ideal.menu.antiaim_elements_t[i].antiaim_yaw_slider, show_t and ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw) ~= "off" and ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced) == "static")
        ui.set_visible(ideal.menu.antiaim_elements_t[i].antiaim_yaw_slider_left, show_t and ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw) ~= "off" and ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced) == "custom desync")
        ui.set_visible(ideal.menu.antiaim_elements_t[i].antiaim_yaw_slider_right, show_t and ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw) ~= "off" and ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced) == "custom desync")
        ui.set_visible(ideal.menu.antiaim_elements_t[i].antiaim_yaw_slider_adv_tick, show_t and ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw) ~= "off" and (ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced) == "tick" or ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced) == "break" or ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced) == "anti-break" or ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced) == "sync"))
        ui.set_visible(ideal.menu.antiaim_elements_t[i].antiaim_yaw_slider_adv_delay, show_t and ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw) ~= "off" and (ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced) == "tick"))
        ui.set_visible(ideal.menu.antiaim_elements_t[i].antiaim_yaw_slider_adv_left, show_t and ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw) ~= "off" and (ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced) == "tick" or ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced) == "break" or ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced) == "anti-break" or ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced) == "sync"))
        ui.set_visible(ideal.menu.antiaim_elements_t[i].antiaim_yaw_slider_adv_right, show_t and ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw) ~= "off" and (ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced) == "tick" or ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced) == "break" or ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced) == "anti-break" or ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced) == "sync"))
        ui.set_visible(ideal.menu.antiaim_elements_t[i].antiaim_pitch, show_t)
        ui.set_visible(ideal.menu.antiaim_elements_t[i].antiaim_pitch_slider, show_t and ui.get(ideal.menu.antiaim_elements_t[i].antiaim_pitch) == "custom")
        ui.set_visible(ideal.menu.antiaim_elements_t[i].antiaim_yaw_base, show_t)
        ui.set_visible(ideal.menu.antiaim_elements_t[i].antiaim_yaw, show_t)
        ui.set_visible(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced, show_t and ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw) ~= "off")
        ui.set_visible(ideal.menu.antiaim_elements_t[i].antiaim_yaw_jitter, show_t)
        ui.set_visible(ideal.menu.antiaim_elements_t[i].antiaim_defensive, show_t and selecte ~= "fake lag")
        ui.set_visible(ideal.menu.antiaim_elements_t[i].antiaim_body_yaw, show_t and ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced) ~= "custom desync" and ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced) ~= "tick" and ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced) ~= "break" and ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced) ~= "anti-break" and ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced) ~= "sync") 
        ui.set_visible(ideal.menu.antiaim_elements_t[i].antiaim_body_yaw_slider, show_t and ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced) ~= "custom desync" and ui.get(ideal.menu.antiaim_elements_t[i].antiaim_body_yaw) ~= "off" and ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced) ~= "tick" and ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced) ~= "break" and ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced) ~= "anti-break" and ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced) ~= "sync")
        ui.set_visible(ideal.menu.antiaim_elements_t[i].send_to_ct, show_t)
        ui.set_visible(ideal.menu.antiaim_elements_t[i].antiaim_body_yaw_adv_left, show_t and ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw) ~= "off" and ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced) == "tick")
        ui.set_visible(ideal.menu.antiaim_elements_t[i].antiaim_body_yaw_adv_right, show_t and ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw) ~= "off" and ui.get(ideal.menu.antiaim_elements_t[i].antiaim_yaw_advanced) == "tick")
    end
    ui.set_visible(ideal.menu.antiaim_anti_knife, misc_tab)
    ui.set_visible(ideal.menu.antiaim_anti_broken, misc_tab)
    ui.set_visible(ideal.menu.antiaim_anti_sun_rise, misc_tab)
    
    ui.set_visible(ideal.menu.antiaim_legit_aa, misc_tab)
    ui.set_visible(ideal.menu.antiaim_quickpeek, misc_tab)
  --  ui.set_visible(ideal.menu.antiaim_enable_resolver, misc_tab)
  --  ui.set_visible(ideal.menu.antiaim_enable_resolver_combo, misc_tab and ui.get(ideal.menu.antiaim_enable_resolver))
    ui.set_visible(ideal.menu.antiaim_quickpeek_addons, misc_tab and ui.get(ideal.menu.antiaim_quickpeek))
    ui.set_visible(ideal.menu.antiaim_quickpeek_addons_second, misc_tab and ui.get(ideal.menu.antiaim_quickpeek) and ui.get(ideal.menu.antiaim_quickpeek_addons) == "static")
    ui.set_visible(ideal.menu.antiaim_quickpeek_addons_third, misc_tab and ui.get(ideal.menu.antiaim_quickpeek))
    ui.set_visible(ideal.menu.indicators, visuals_tab)
    ui.set_visible(ideal.menu.watermark, visuals_tab)
   -- ideal.menu.watermark
 --   ui.set_visible(ideal.menu.antiaim_button, main_tab)
    ui.set_visible(ideal.menu.antiaim_list, main_tab)
 --   ui.set_visible(ideal.menu.antiaim_combo, main_tab)
   -- ui.set_visible(ideal.menu.antiaim_discord, main_tab) 
    ui.set_visible(ideal.menu.team_site, anti_aim_tab)
    ui.set_visible(ideal.menu.aabuilder_state, anti_aim_tab)
    ui.set_visible(ideal.menu.antiaim_enable_addons, misc_tab)
    ui.set_visible(ideal.menu.antiaim_manual_left, misc_tab and yaw_addons_enabled)
    ui.set_visible(ideal.menu.antiaim_manual_right, misc_tab and yaw_addons_enabled)
    ui.set_visible(ideal.menu.antiaim_manual_forward, misc_tab and yaw_addons_enabled)
    ui.set_visible(ideal.menu.antiaim_freestanding, misc_tab and yaw_addons_enabled)
    ui.set_visible(ideal.menu.antiaim_defensive_exploit, misc_tab)
    ui.set_visible(ideal.menu.antiaim_safeknife, misc_tab)
    ui.set_visible(ideal.menu.antiaim_animation, misc_tab)
    ui.set_visible(ideal.menu.antiaim_animation_ground, misc_tab and ui.get(ideal.menu.antiaim_animation))
    ui.set_visible(ideal.menu.antiaim_animation_air, misc_tab and ui.get(ideal.menu.antiaim_animation))
    ui.set_visible(ideal.menu.antiaim_animation_extra, misc_tab and ui.get(ideal.menu.antiaim_animation))
    ui.set_visible(ideal.menu.antiaim_safeknife_options, misc_tab and ui.get(ideal.menu.antiaim_safeknife))
    ui.set_visible(ideal.menu.antiaim_defensive_type, misc_tab and ui.get(ideal.menu.antiaim_defensive_exploit))
    ui.set_visible(ideal.menu.antiaim_defensive_pitch, misc_tab and ui.get(ideal.menu.antiaim_defensive_type) == "custom" and ui.get(ideal.menu.antiaim_defensive_exploit))
    ui.set_visible(ideal.menu.antiaim_defensive_pitch_slider, misc_tab and ui.get(ideal.menu.antiaim_defensive_type) == "custom" and ui.get(ideal.menu.antiaim_defensive_exploit) and ui.get(ideal.menu.antiaim_defensive_pitch) == "custom")
    ui.set_visible(ideal.menu.antiaim_defensive_yaw, misc_tab and ui.get(ideal.menu.antiaim_defensive_type) == "custom" and ui.get(ideal.menu.antiaim_defensive_exploit))
    ui.set_visible(ideal.menu.antiaim_defensive_offset, misc_tab and ui.get(ideal.menu.antiaim_defensive_type) == "custom" and ui.get(ideal.menu.antiaim_defensive_exploit))
    ui.set_visible(ideal.menu.antiaim_defensive_byaw, misc_tab and ui.get(ideal.menu.antiaim_defensive_type) == "custom" and ui.get(ideal.menu.antiaim_defensive_exploit) )
    ui.set_visible(ideal.menu.antiaim_defensive_boffset, misc_tab and ui.get(ideal.menu.antiaim_defensive_type) == "custom" and ui.get(ideal.menu.antiaim_defensive_exploit))
  --  ui.set_visible(ideal.menu.indicators2, visuals_tab)
    ui.set_visible(ideal.menu.indicators5, visuals_tab)
    ui.set_visible(ideal.menu.debugindicators, visuals_tab)

    
end)

setup_skeet_element("elem", ideal.reference.anti_aim.master, true, nil)
setup_skeet_element("elem", ideal.menu.antiaim_elements_ct[1].enable, true, nil)
setup_skeet_element("elem", ideal.menu.antiaim_elements_t[1].enable, true, nil)
setup_skeet_element("vis_elem", ideal.menu.antiaim_elements_ct[1].enable, false, nil)
setup_skeet_element("vis_elem", ideal.menu.antiaim_elements_t[1].enable, false, nil)

--#endregion Visible

--#region Events

manipulation_tick = function(a, b, time, delay)
    local tick = globals.tickcount()
    local period = delay + time
    
    if tick % period < time then
        return a
    else
        return b
    end
end;

manipulation_break = function(a, b, time)
    return (time / 2 <= (globals.tickcount() % time)) and a or b --print
end;

get_body_yaw = function(player)
	return entity.get_prop(player, "m_flPoseParameter", 11) * 120 - 60
end

get_anti_aimbuilder_state = function ()
    local state = "" --local
    local lp = entity.get_local_player()
    local vel1, vel2, vel3 = entity.get_prop(lp, 'm_vecVelocity')
    local velocity = math.floor(math.sqrt(vel1 * vel1 + vel2 * vel2))
    local on_ground = bit.band(entity.get_prop(lp, "m_fFlags"), 1) == 1
    local not_moving = velocity < 2
    local slowwalk_key = ui.get(ideal.reference.other.slow_motion[2])
    local teamnum = entity.get_prop(lp, 'm_iTeamNum')
    local vec_velocity = { entity.get_prop(lp, 'm_vecVelocity') }
    local teamnum = entity.get_prop(lp, 'm_iTeamNum') 
    local duck_amount = entity.get_prop(lp, 'm_flDuckAmount')
    local velocity = math.floor(math.sqrt(vec_velocity[1] ^ 2 + vec_velocity[2] ^ 2) + 0.5)
    local air = bit.band(entity.get_prop(lp, 'm_fFlags'), 1) == 0
    if air == false then
        ideal.anti_aim.ground_time = ideal.anti_aim.ground_time + 1
    else
        ideal.anti_aim.ground_time = 0
    end
    if not ui.get(ideal.reference.other.bunny_hop) then
        on_ground = bit.band(entity.get_prop(lp, "m_fFlags"), 1) == 1
    end

    if not ui.get(ideal.reference.other.double_tap[2]) and not ui.get(ideal.reference.other.hide_shots[2]) then
        state = 'fake lag'
    elseif ideal.anti_aim.ground_time < 8 and duck_amount > 0 then
        state = 'air duck'
    elseif ideal.anti_aim.ground_time < 8 then
        state = 'in air'
    elseif duck_amount > 0 and velocity <= 2 then
        state = 'duck'
    elseif duck_amount > 0 and velocity >= 2 then
        state = 'move duck'
    elseif ui.get(ideal.reference.other.fakeducking)then 
        state = 'duck'
    elseif not_moving then   
        state = 'stand'
    elseif not not_moving then
        if slowwalk_key then
        state = 'slow'
    else
        state = 'run'
        end
    end
    return state
end

local native_GetClientEntity = vtable_bind("client.dll", "VClientEntityList003", 3, "uintptr_t(__thiscall*)(void*, int)");

do_defensive = function ()
    local player = entity.get_local_player( )

    if player == nil then
        return
    end

    local ptr = native_GetClientEntity(player);

    local m_flSimulationTime = entity.get_prop(player, "m_flSimulationTime");
    local m_flOldSimulationTime = ffi.cast("float*", ptr + 0x26C)[0];

    if (m_flSimulationTime - m_flOldSimulationTime < 0) then
        ideal.anti_aim.defensive_ticks = globals.tickcount() + toticks(.200);
    end
end

client.set_event_callback( "net_update_start", function(  )
    do_defensive()
end)

client.set_event_callback( "setup_command", function( arg )
    if not entity.get_local_player( ) then
        return
    end
    if globals.tickcount() - ideal.anti_aim.tick_var > 0 and arg.chokedcommands == 1 then
        ideal.anti_aim.is_invert = not ideal.anti_aim.is_invert
        ideal.anti_aim.tick_var = globals.tickcount()
    elseif globals.tickcount() - ideal.anti_aim.tick_var < -1 then
        ideal.anti_aim.tick_var = globals.tickcount()
    end
    local body_yaw = entity.get_prop(entity.get_local_player(), "m_flPoseParameter", 11) * 120 - 60
    local side = body_yaw > 0 and 1 or -1
    local m_flSimulationTime = entity.get_prop(player, "m_flSimulationTime");
    ideal.anti_aim.cur_team = entity.get_prop(entity.get_local_player(), "m_iTeamNum") -- 2 TT 3 CT
    ideal.anti_aim.state_id = ui.get(ideal.anti_aim.cur_team == 3 and ideal.menu.antiaim_elements_ct[ideal.menu.state_to_num[get_anti_aimbuilder_state()] ].enable or ideal.menu.antiaim_elements_t[ideal.menu.state_to_num[get_anti_aimbuilder_state()] ].enable) and ideal.menu.state_to_num[get_anti_aimbuilder_state()] or ideal.menu.state_to_num['global'];
    if ideal.anti_aim.cur_team == 2 then
        ideal.anti_aim.pitch = ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_pitch)
        ideal.anti_aim.pitch_value = ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_pitch_slider)
        ideal.anti_aim.yaw_base = ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_base)
        ideal.anti_aim.yaw = ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw)
        if ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_advanced) == "static" then
            ideal.anti_aim.yaw_value = ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_slider)
        elseif ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_advanced) == "custom desync" then
            ideal.anti_aim.yaw_value = ideal.anti_aim.is_invert and ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_slider_left) or ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_slider_right)
        elseif ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_advanced) == "tick" then
            ideal.anti_aim.yaw_value = manipulation_tick(ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_left), ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_right), ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_delay), ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_tick))
        elseif ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_advanced) == "break" then
            ideal.anti_aim.yaw_value = manipulation_break(ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_left), ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_right), ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_tick))
        elseif ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_advanced) == "anti-break" then
            ideal.anti_aim.yaw_value = manipulation_break(ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_left), ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_right), ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_tick))
        elseif ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_advanced) == "sync" then
            ideal.anti_aim.yaw_value = manipulation_break(ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_left), ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_right), ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_tick))
        end

        if ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_jitter) == "off" then
            ideal.anti_aim.yaw_jitter = "off"
            ideal.anti_aim.yaw_jitter_value = 0
        elseif ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_jitter) == "offset" then
            ideal.anti_aim.yaw_jitter = "offset"
            ideal.anti_aim.yaw_jitter_value = ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_jitter_slider)
        elseif ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_jitter) == "center" then
            ideal.anti_aim.yaw_jitter = "center"
            ideal.anti_aim.yaw_jitter_value = ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_jitter_slider)
        elseif ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_jitter) == "random" then
            ideal.anti_aim.yaw_jitter = "random"
            ideal.anti_aim.yaw_jitter_value = ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_jitter_slider)
        elseif ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_jitter) == "skitter" then
            ideal.anti_aim.yaw_jitter = "skitter"
            ideal.anti_aim.yaw_jitter_value = ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_jitter_slider)
        elseif ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_jitter) == "left ^ right offset" then
            ideal.anti_aim.yaw_jitter = "offset"
            ideal.anti_aim.yaw_jitter_value = ideal.anti_aim.is_invert and ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_jitter_slider_l) or ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_jitter_slider_r)
        elseif ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_jitter) == "left ^ right center" then
            ideal.anti_aim.yaw_jitter = "center"
            ideal.anti_aim.yaw_jitter_value = ideal.anti_aim.is_invert and ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_jitter_slider_l) or ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_jitter_slider_r)
        elseif ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_jitter) == "left ^ right random" then
            ideal.anti_aim.yaw_jitter = "random"
            ideal.anti_aim.yaw_jitter_value = ideal.anti_aim.is_invert and ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_jitter_slider_l) or ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_jitter_slider_r)
        elseif ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_jitter) == "left ^ right skitter" then
            ideal.anti_aim.yaw_jitter = "skitter"
            ideal.anti_aim.yaw_jitter_value = ideal.anti_aim.is_invert and ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_jitter_slider_l) or ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_jitter_slider_r)
        end

        if ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_advanced) == "static" then
            ideal.anti_aim.body_yaw = ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_body_yaw)
            ideal.anti_aim.body_yaw_value = ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_body_yaw_slider)
        elseif ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_advanced) == "custom desync" then
            ideal.anti_aim.body_yaw = "static"
            ideal.anti_aim.body_yaw_value = 0
        elseif ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_advanced) == "tick" then
            ideal.anti_aim.body_yaw = manipulation_tick(ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_body_yaw_adv_left), ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_body_yaw_adv_right), ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_delay), ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_tick))
            ideal.anti_aim.body_yaw_value = 0
        elseif ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_advanced) == "break" then
            ideal.anti_aim.body_yaw = "static"
            ideal.anti_aim.body_yaw_value = 0
        elseif ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_advanced) == "anti-break" then
            ideal.anti_aim.body_yaw = "off"
            ideal.anti_aim.body_yaw_value = 0
        elseif ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_advanced) == "sync" then
            ideal.anti_aim.body_yaw = "static"
            ideal.anti_aim.body_yaw_value = manipulation_break(-120, 120, ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_tick))
        end
        if ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_defensive) == "always on" then
            ideal.anti_aim.defensive_t = true
            ideal.anti_aim.is_active_inds = true
        elseif ui.get(ideal.menu.antiaim_elements_t[ideal.anti_aim.state_id].antiaim_defensive) == "switch cycle" then
            ideal.anti_aim.is_active_inds = true
            if globals.tickcount() % 2 == 1 then
                ideal.anti_aim.is_active_inds = true
            else
                ideal.anti_aim.defensive_t = false
            end
        else 
            ideal.anti_aim.defensive_t = false
            ideal.anti_aim.is_active_inds = false
        end
        arg.force_defensive = ideal.anti_aim.defensive_t;
        --print('tt')
    elseif ideal.anti_aim.cur_team == 3 then
        ideal.anti_aim.pitch = ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_pitch)
        ideal.anti_aim.pitch_value = ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_pitch_slider)
        ideal.anti_aim.yaw_base = ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_base)
        ideal.anti_aim.yaw = ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw)
        if ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_advanced) == "static" then
            ideal.anti_aim.yaw_value = ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_slider)
        elseif ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_advanced) == "custom desync" then
            ideal.anti_aim.yaw_value = ideal.anti_aim.is_invert and ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_slider_left) or ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_slider_right)
        elseif ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_advanced) == "tick" then
            ideal.anti_aim.yaw_value = manipulation_tick(ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_left), ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_right), ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_delay), ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_tick))
        elseif ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_advanced) == "break" then
            ideal.anti_aim.yaw_value = manipulation_break(ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_left), ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_right), ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_tick))
        elseif ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_advanced) == "anti-break" then
            ideal.anti_aim.yaw_value = manipulation_break(ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_left), ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_right), ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_tick))
        elseif ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_advanced) == "sync" then
            ideal.anti_aim.yaw_value = manipulation_break(ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_left), ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_right), ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_tick))
        end

        if ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_jitter) == "off" then
            ideal.anti_aim.yaw_jitter = "off"
            ideal.anti_aim.yaw_jitter_value = 0
        elseif ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_jitter) == "offset" then
            ideal.anti_aim.yaw_jitter = "offset"
            ideal.anti_aim.yaw_jitter_value = ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_jitter_slider)
        elseif ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_jitter) == "center" then
            ideal.anti_aim.yaw_jitter = "center"
            ideal.anti_aim.yaw_jitter_value = ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_jitter_slider)
        elseif ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_jitter) == "random" then
            ideal.anti_aim.yaw_jitter = "random"
            ideal.anti_aim.yaw_jitter_value = ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_jitter_slider)
        elseif ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_jitter) == "skitter" then
            ideal.anti_aim.yaw_jitter = "skitter"
            ideal.anti_aim.yaw_jitter_value = ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_jitter_slider)
        elseif ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_jitter) == "left ^ right offset" then
            ideal.anti_aim.yaw_jitter = "offset"
            ideal.anti_aim.yaw_jitter_value = ideal.anti_aim.is_invert and ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_jitter_slider_l) or ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_jitter_slider_r)
        elseif ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_jitter) == "left ^ right center" then
            ideal.anti_aim.yaw_jitter = "center"
            ideal.anti_aim.yaw_jitter_value = ideal.anti_aim.is_invert and ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_jitter_slider_l) or ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_jitter_slider_r)
        elseif ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_jitter) == "left ^ right random" then
            ideal.anti_aim.yaw_jitter = "random"
            ideal.anti_aim.yaw_jitter_value = ideal.anti_aim.is_invert and ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_jitter_slider_l) or ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_jitter_slider_r)
        elseif ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_jitter) == "left ^ right skitter" then
            ideal.anti_aim.yaw_jitter = "skitter"
            ideal.anti_aim.yaw_jitter_value = ideal.anti_aim.is_invert and ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_jitter_slider_l) or ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_jitter_slider_r)
        end

        if ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_advanced) == "static" then
            ideal.anti_aim.body_yaw = ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_body_yaw)
            ideal.anti_aim.body_yaw_value = ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_body_yaw_slider)
        elseif ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_advanced) == "custom desync" then
            ideal.anti_aim.body_yaw = "static"
            ideal.anti_aim.body_yaw_value = 0
        elseif ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_advanced) == "tick" then
            ideal.anti_aim.body_yaw = manipulation_tick(ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_body_yaw_adv_left), ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_body_yaw_adv_right), ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_delay), ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_tick))
            ideal.anti_aim.body_yaw_value = 0
        elseif ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_advanced) == "break" then
            ideal.anti_aim.body_yaw = "static"
            ideal.anti_aim.body_yaw_value = 0
        elseif ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_advanced) == "anti-break" then
            ideal.anti_aim.body_yaw = "off"
            ideal.anti_aim.body_yaw_value = 0
        elseif ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_advanced) == "sync" then
            ideal.anti_aim.body_yaw = "static"
            ideal.anti_aim.body_yaw_value = manipulation_break(-120, 120, ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_yaw_slider_adv_tick))
        end
        if ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_defensive) == "always on" then
            ideal.anti_aim.defensive_ct = true
            ideal.anti_aim.is_active_inds = true
        elseif ui.get(ideal.menu.antiaim_elements_ct[ideal.anti_aim.state_id].antiaim_defensive) == "switch cycle" then
            ideal.anti_aim.is_active_inds = true
            if globals.tickcount() % 2 == 1 then
                ideal.anti_aim.defensive_ct = true
            else
                ideal.anti_aim.defensive_ct = false
            end
        else
            ideal.anti_aim.defensive_ct = false
            ideal.anti_aim.is_active_inds = false
        end
        --print('ct')
        arg.force_defensive = ideal.anti_aim.defensive_ct;
    end

    ideal.anti_aim.defensive = ideal.anti_aim.defensive_ticks > globals.tickcount()
    if ideal.anti_aim.defensive then
        ideal.anti_aim.is_active = true
    else
        ideal.anti_aim.is_active = false
    end

    if ideal.anti_aim.is_active and ui.get(ideal.reference.other.double_tap[2]) and ui.get(ideal.menu.antiaim_defensive_type) == "meta" and ui.get(ideal.menu.antiaim_defensive_exploit) and not quick_peek_addons == true then
        ideal.anti_aim.pitch = "Custom"
        ideal.anti_aim.pitch_value = -45
       -- ideal.anti_aim.pitch_value = -89 
        ideal.anti_aim.yaw = "spin"
        ideal.anti_aim.yaw_value = 70 
        ideal.anti_aim.body_yaw = "opposite"
        ideal.anti_aim.body_yaw_value = 48 or -48
    end







    if ideal.anti_aim.is_active and ui.get(ideal.reference.other.double_tap[2]) and ui.get(ideal.menu.antiaim_defensive_type) == "ideal" and ui.get(ideal.menu.antiaim_defensive_exploit) and not quick_peek_addons == true then
        ideal.anti_aim.pitch = "Custom"
      --  ideal.anti_aim.pitch_value = -45
        ideal.anti_aim.pitch_value = -89 
        ideal.anti_aim.yaw = "spin"
        ideal.anti_aim.yaw_value = 70 
        ideal.anti_aim.body_yaw = "opposite"
        ideal.anti_aim.body_yaw_value = 48 or -48
    end










    if ideal.anti_aim.is_active and ui.get(ideal.reference.other.double_tap[2]) and ui.get(ideal.menu.antiaim_defensive_type) == "custom" and ui.get(ideal.menu.antiaim_defensive_exploit) and not quick_peek_addons == true then
        ideal.anti_aim.pitch = ui.get(ideal.menu.antiaim_defensive_pitch)
        ideal.anti_aim.pitch_value = ui.get(ideal.menu.antiaim_defensive_pitch_slider)
        ideal.anti_aim.yaw = ui.get(ideal.menu.antiaim_defensive_yaw)
        ideal.anti_aim.yaw_value = ui.get(ideal.menu.antiaim_defensive_offset)
        ideal.anti_aim.body_yaw = ui.get(ideal.menu.antiaim_defensive_byaw)
        ideal.anti_aim.body_yaw_value = ui.get(ideal.menu.antiaim_defensive_boffset)
    end

    if ui.get(ideal.reference.other.auto_peek[2]) and ui.get(ideal.menu.antiaim_quickpeek) then
        ideal.anti_aim.yaw_value = 0
        ideal.anti_aim.yaw_base = "At Targets"
        ideal.anti_aim.yaw_jitter = "Off"
        ideal.anti_aim.yaw_jitter_value = 0
        ideal.anti_aim.body_yaw = ui.get(ideal.menu.antiaim_quickpeek_addons)
        if ui.get(ideal.menu.antiaim_quickpeek_addons_second) == "none" and ui.get(ideal.menu.antiaim_quickpeek_addons) == "static" then
        ideal.anti_aim.body_yaw_value = 0
        elseif ui.get(ideal.menu.antiaim_quickpeek_addons_second) == "slow" and ui.get(ideal.menu.antiaim_quickpeek_addons) == "static" then
        ideal.anti_aim.body_yaw_value = manipulation_break(120, -120, 12)
        elseif ui.get(ideal.menu.antiaim_quickpeek_addons_second) == "fast" and ui.get(ideal.menu.antiaim_quickpeek_addons) == "static" then
        ideal.anti_aim.body_yaw_value = manipulation_break(120, -120, 3)
        else ideal.anti_aim.body_yaw_value = 0
        end
        if ui.get(ideal.menu.antiaim_quickpeek_addons_third) == "on" then
        ideal.anti_aim.is_active_inds = true
        end
        quick_peek_addons = true
    else quick_peek_addons = false
    end
    
 --[[   ui.set(ideal.menu.antiaim_manual_left, "On hotkey")
	ui.set(ideal.menu.antiaim_manual_right, "On hotkey")
    ui.set(ideal.menu.antiaim_manual_forward, "On hotkey")
    if ideal.anti_aim.last_press + 0.22 < globals.curtime() then
		if ideal.anti_aim.aa_dir == 0 then
			if ui.get(ideal.menu.antiaim_manual_left) then
				ideal.anti_aim.aa_dir = 1
				ideal.anti_aim.last_press = globals.curtime()
			elseif ui.get(ideal.menu.antiaim_manual_right) then
				ideal.anti_aim.aa_dir = 2
				ideal.anti_aim.last_press = globals.curtime()
			elseif ui.get(ideal.menu.antiaim_manual_forward) then
				ideal.anti_aim.aa_dir = 3
				ideal.anti_aim.last_press = globals.curtime()
			end
		elseif ideal.anti_aim.aa_dir == 1 then
			if ui.get(ideal.menu.antiaim_manual_right) then
				ideal.anti_aim.aa_dir = 2
				ideal.anti_aim.last_press = globals.curtime()
			elseif ui.get(ideal.menu.antiaim_manual_forward) then
				ideal.anti_aim.aa_dir = 3
				ideal.anti_aim.last_press = globals.curtime()
			elseif ui.get(ideal.menu.antiaim_manual_left) then
				ideal.anti_aim.aa_dir = 0
				ideal.anti_aim.last_press = globals.curtime()
			end
		elseif ideal.anti_aim.aa_dir == 2 then
			if ui.get(ideal.menu.antiaim_manual_left) then
				ideal.anti_aim.aa_dir = 1
				ideal.anti_aim.last_press = globals.curtime()
			elseif ui.get(ideal.menu.antiaim_manual_forward) then
				ideal.anti_aim.aa_dir = 3
				ideal.anti_aim.last_press = globals.curtime()
			elseif ui.get(ideal.menu.antiaim_manual_right) then
				ideal.anti_aim.aa_dir = 0
				ideal.anti_aim.last_press = globals.curtime()
			end
		elseif ideal.anti_aim.aa_dir == 3 then
			if ui.get(ideal.menu.antiaim_manual_forward) then
				ideal.anti_aim.aa_dir = 0
				ideal.anti_aim.last_press = globals.curtime()
			elseif ui.get(ideal.menu.antiaim_manual_left) then
				ideal.anti_aim.aa_dir = 1
				ideal.anti_aim.last_press = globals.curtime()
			elseif ui.get(ideal.menu.antiaim_manual_right) then
				ideal.anti_aim.aa_dir = 2
				ideal.anti_aim.last_press = globals.curtime()
			end
		end
	end


	if ideal.anti_aim.aa_dir == 1 or ideal.anti_aim.aa_dir == 2 or ideal.anti_aim.aa_dir == 3 then
		if ideal.anti_aim.aa_dir == 1 then
            ideal.anti_aim.yaw_value = -90
            ideal.anti_aim.yaw = "180"
            ideal.anti_aim.yaw_base = "At Targets"
            ideal.anti_aim.yaw_jitter = "Off"
            ideal.anti_aim.yaw_jitter_value = 0
            ideal.anti_aim.body_yaw = "Static"
		elseif ideal.anti_aim.aa_dir == 2 then
			ideal.anti_aim.yaw_value = 90
            ideal.anti_aim.yaw = "180"
            ideal.anti_aim.yaw_base = "At Targets"
            ideal.anti_aim.yaw_jitter = "Off"
            ideal.anti_aim.yaw_jitter_value = 0
            ideal.anti_aim.body_yaw = "Static"
		elseif ideal.anti_aim.aa_dir == 3 then
			ideal.anti_aim.yaw_value = 180
            ideal.anti_aim.yaw = "180"
            ideal.anti_aim.yaw_base = "At Targets"
            ideal.anti_aim.yaw_jitter = "Off"
            ideal.anti_aim.yaw_jitter_value = 0
            ideal.anti_aim.body_yaw = "Static"
		end
    end--]]






    ui.set(ideal.menu.antiaim_manual_left, "On hotkey")
	ui.set(ideal.menu.antiaim_manual_right, "On hotkey")
    ui.set(ideal.menu.antiaim_manual_forward, "On hotkey")
    local on_ground = bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"),1) == 1 and not client.key_state(0x20)
	local p_key = client.key_state(69)


    if ui.get(ideal.menu.antiaim_manual_right) and ideal.anti_aim.last_press + 0.2 < globals.curtime() then
        ideal.anti_aim.aa_dir = ideal.anti_aim.aa_dir == 2 and 0 or 2
        ideal.anti_aim.last_press = globals.curtime()
		elseif ui.get(ideal.menu.antiaim_manual_left) and ideal.anti_aim.last_press + 0.2 < globals.curtime() then
			ideal.anti_aim.aa_dir = ideal.anti_aim.aa_dir == 1 and 0 or 1
			ideal.anti_aim.last_press = globals.curtime()
		elseif ui.get(ideal.menu.antiaim_manual_forward) and ideal.anti_aim.last_press + 0.2 < globals.curtime() then
			ideal.anti_aim.aa_dir = ideal.anti_aim.aa_dir == 3 and 0 or 3
			ideal.anti_aim.last_press = globals.curtime()
		elseif ideal.anti_aim.last_press > globals.curtime() then
			ideal.anti_aim.last_press = globals.curtime()
        end




        if ideal.anti_aim.aa_dir == 1 or ideal.anti_aim.aa_dir == 2 or ideal.anti_aim.aa_dir == 3 then
            if ideal.anti_aim.aa_dir == 1 then
                ideal.anti_aim.yaw_value = -90
                ideal.anti_aim.yaw = "180"
                ideal.anti_aim.yaw_base = "Local View"
                ideal.anti_aim.yaw_jitter = "Off"
                ideal.anti_aim.yaw_jitter_value_real = 0
                ideal.anti_aim.body_yaw = "Static"
                ideal.anti_aim.body_yaw_value_real = 0
            elseif ideal.anti_aim.aa_dir == 2 then
                ideal.anti_aim.yaw_value = 90
                ideal.anti_aim.yaw = "180"
                ideal.anti_aim.yaw_base = "Local View"
                ideal.anti_aim.yaw_jitter = "Off"
                ideal.anti_aim.yaw_jitter_value_real = 0
                ideal.anti_aim.body_yaw = "Static"
                ideal.anti_aim.body_yaw_value_real = 0
            elseif ideal.anti_aim.aa_dir == 3 then
                ideal.anti_aim.yaw_value = 180
                ideal.anti_aim.yaw = "180"
                ideal.anti_aim.yaw_base = "Local View"
                ideal.anti_aim.yaw_jitter = "Off"
                ideal.anti_aim.yaw_jitter_value_real = 0
                ideal.anti_aim.body_yaw = "Static"
                ideal.anti_aim.body_yaw_value_real = 0
            end
        end




















    if ui.get(ideal.menu.antiaim_legit_aa) then
        if weaponn ~= nil and entity.get_classname(weaponn) == "CC4" then
            if arg.in_attack == 1 then
                arg.in_attack = 0 
                arg.in_use = 1
            end
        else
            if arg.chokedcommands == 0 then
                arg.in_use = 0
            end
        end
    end
    if ui.get(ideal.menu.antiaim_safeknife) then
        local lp = entity.get_local_player()
        local weapon = entity.get_player_weapon(lp)
        if table_contains(ui.get(ideal.menu.antiaim_safeknife_options), "knife") then
        if entity.get_classname(weapon) == "CKnife" then
            ideal.anti_aim.yaw_value = 4
            ideal.anti_aim.pitch = "Custom"
            ideal.anti_aim.yaw = "180"
            ideal.anti_aim.pitch_value = 89
            ideal.anti_aim.yaw_jitter = "Offset"
            ideal.anti_aim.yaw_jitter_value = 3
            ideal.anti_aim.body_yaw = "Static"
            ideal.anti_aim.body_yaw_value = 0
        end
        end
        if table_contains(ui.get(ideal.menu.antiaim_safeknife_options), "zeus") then
        if entity.get_classname(weapon) == "CWeaponTaser" then
            ideal.anti_aim.yaw_value = 4
            ideal.anti_aim.pitch = "Custom"
            ideal.anti_aim.yaw = "180"
            ideal.anti_aim.pitch_value = 89
            ideal.anti_aim.yaw_jitter = "Offset"
            ideal.anti_aim.yaw_jitter_value = 3
            ideal.anti_aim.body_yaw = "Static"
            ideal.anti_aim.body_yaw_value = 0
        end
        end
    end
    if ui.get(ideal.menu.antiaim_anti_knife) then
        local players = entity.get_players(true)
        local lx, ly, lz = entity.get_prop(entity.get_local_player(), "m_vecOrigin")
        if players == nil then return end
        for i=1, #players do
            local x, y, z = entity.get_prop(players[i], "m_vecOrigin")
            local distance = (math.sqrt((x - lx)^2 + (y - ly)^2 + (z - lz)^2))
            local weapon = entity.get_player_weapon(players[i])
            if entity.get_classname(weapon) == "CKnife" and distance <= 180 then
                ideal.anti_aim.yaw_value = 180
                ideal.anti_aim.pitch = "Off"
                ideal.anti_aim.yaw_base = "At targets"
            end
        end
    end








    ui.set(ideal.reference.anti_aim.pitch[1], ideal.anti_aim.pitch);
    ui.set(ideal.reference.anti_aim.pitch[2], ideal.anti_aim.pitch_value);
    ui.set(ideal.reference.anti_aim.yaw_base, ideal.anti_aim.yaw_base);
    ui.set(ideal.reference.anti_aim.yaw[1], ideal.anti_aim.yaw);
    ui.set(ideal.reference.anti_aim.yaw[2], ideal.anti_aim.yaw_value);
    ui.set(ideal.reference.anti_aim.yaw_jitter[1], ideal.anti_aim.yaw_jitter);
    ui.set(ideal.reference.anti_aim.yaw_jitter[2], ideal.anti_aim.yaw_jitter_value);
    ui.set(ideal.reference.anti_aim.body_yaw[1], ideal.anti_aim.body_yaw);
    ui.set(ideal.reference.anti_aim.body_yaw[2], ideal.anti_aim.body_yaw_value);
    ui.set(ideal.reference.anti_aim.freestanding[2], ui.get(ideal.menu.antiaim_freestanding) and "Always on" or "On hotkey");
    ui.set(ideal.reference.anti_aim.freestanding[1], ui.get(ideal.menu.antiaim_freestanding) and true);
    ui.set(ideal.reference.anti_aim.roll_offset, 0);
end)
client.set_event_callback("shutdown", function ()
    setup_skeet_element("vis", nil, nil, "unload")
end)
--http.get(ideal.table.visuals.picture, function(s, r)
--    if s and r.status == 200 then --return
  --      ideal.table.visuals.image_loaded = images.load(r.body)
 --   else
  --      error("Failed to load: " .. response.status_message)
 --   end
--end)





    client.set_event_callback("pre_render", function()
   if ui.get(ideal.menu.antiaim_anti_broken) then
    
                entity.set_prop(entity.get_local_player(), "m_flPoseParameter", math.random(0, 10)/10, 3)
                entity.set_prop(entity.get_local_player(), "m_flPoseParameter", math.random(0, 10)/10, 7)
                entity.set_prop(entity.get_local_player(), "m_flPoseParameter", math.random(0, 10)/10, 6)
            end
        end) 












local screen = {client.screen_size()}
local x_offset, y_offset = screen[1], screen[2]
local x, y = x_offset/2, y_offset/2
--[[info_panel = function()
    if ideal.table.visuals.image_loaded ~= "" then
    if ui.get(ideal.menu.indicators2) == "flag" then
    local r,g,b = ui.get(ideal.menu.color_picker)
    local measure_text = renderer.measure_text("-", "ideal ")
    local username_text = renderer.measure_text("-", "NAME - ")
    renderer.gradient(0, y + 4.6, 130, 20, r,g,b, 255, 50, 50, 50, 5, true)
    ideal.table.visuals.image_loaded:draw(x - 957, y + 7, 30, 15)
    renderer.text(33, y + 5, 255, 255, 255, 255, '-', nil, "ideal")
    renderer.text(33 + measure_text, y + 5, r,g,b, 255, '-', nil, "LUA")
    renderer.text(33, y + 13, 255, 255, 255, 255, '-', nil, "NAME -")
    renderer.text(33 + username_text, y + 13, r,g,b, 255, '-', nil, string.upper(username))
    end
    end
    if ui.get(ideal.menu.indicators2) == "text" then
    local r,g,b = ui.get(ideal.menu.color_picker)
    renderer.text(x, y + 530, r,g,b, 255, 'c', nil, text_fade_animation(8, r,g,b, 255, "E M O T I O N A L"))
    end
    if ui.get(ideal.menu.indicators2) == "legacy" then
    local r,g,b = ui.get(ideal.menu.color_picker)
    renderer.text(0, y - 25, 80,80,80, 255, '', nil, "ideal")
    renderer.text(0, y - 25, 255,255,255, 255, '', nil, text_fade_animation(10, r,g,b, 255, "ideal"))
    renderer.text(renderer.measure_text("", " ideal"), y - 25, r,g,b, 255, '', nil, "~ anti-aim system")
    renderer.text(0, y - 15, 180,180,180, 255, '', nil, "user: " .. string.lower(username) .. " [recode]")
    end

-----]]

info_panel = function()

    r,g,b = ui.get(ideal.menu.color_picker)
    if ui.get(ideal.menu.watermark) == "Bottom" then
     --   script.renderer:glow_module(x - 60, y_offset - 40, 120, 20, 20, 3, {r, g, b, 150}, {255, 255, 255,0})
      ---  roundedRectangle(x - renderer.measure_text("", "IDEALYAW")/2 - 2, y_offset - 35, renderer.measure_text("", "IDEALYAW") + 4, 10, 23,23,23,240,"", 7)
        renderer.text(x, y_offset - 30, 255,255,255, 255, 'c', nil, "" .. text_fade_animation(8, r,g,b, 255, "IDEALYAW"))
      --  renderer.gradient(x, y_offset - 43, renderer.measure_text("", "IDEALYAW")/2 + 5, 2, r, g, b, 150, r, g, b, 10, true)
      --  renderer.gradient(x, y_offset - 43, -renderer.measure_text("", "IDEALYAW")/2 - 5, 2, r, g, b, 150, r, g, b, 10, true)
    end
    
    if ui.get(ideal.menu.watermark) == "Side" then
    renderer.text(10, y - 15, 100,100,100, 255, '', nil, "IDEALYAW")
    renderer.text(10, y - 15, 255,255,255, 255, '', nil, text_fade_animation(8, r,g,b, 255, "IDEALYAW") .. "\aFFFFFFFF [BETA]")
    end

end



defensive_opa = 0
defensive_opa2 = 0
defensive_opa3 = 0
defensive_indicator = function()
        
        X,Y = screen[1], screen[2]
        value2 = 0
        draw_art = ideal.table.visuals.to_draw_ticks * 50/90 
        if is_active then
            value2 = 0.4
        else value2 = 5 
        end
        
        is_active = ideal.anti_aim.is_active_inds == true and ui.get(ideal.reference.other.double_tap[2]) 
        if is_active then
            defensive_opa = script.helpers:clamp(defensive_opa + globals.frametime()/0.4, 0, 1)
            defensive_opa2 = script.helpers:clamp(defensive_opa2 + globals.frametime()/0.15, 0, 1)
            defensive_opa3 =  script.helpers:clamp(defensive_opa2 + globals.frametime()/0.15, 0, 1)
        else
            defensive_opa = script.helpers:clamp(defensive_opa - globals.frametime()/0.25, 0, 1)
            defensive_opa2 = script.helpers:clamp(defensive_opa2 - globals.frametime()/0.25, 0, 1)
            defensive_opa3 = script.helpers:clamp(defensive_opa2 - globals.frametime()/0.25, 0, 1)
        end
       
        if 50 < defensive_opa * 110 then
            maxed = "yes"
        else 
            maxed = "no"
        end

        local maxed_true = maxed == "yes"
    
        local r, g, b = ui.get(ideal.menu.color_picker)
   
        local jedi_icon = '<svg t="1650815150236" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="1757" width="1000" height="1000"><path d="M398.5 373.6c95.9-122.1 17.2-233.1 17.2-233.1 45.4 85.8-41.4 170.5-41.4 170.5 105-171.5-60.5-271.5-60.5-271.5 96.9 72.7-10.1 190.7-10.1 190.7 85.8 158.4-68.6 230.1-68.6 230.1s-.4-16.9-2.2-85.7c4.3 4.5 34.5 36.2 34.5 36.2l-24.2-47.4 62.6-9.1-62.6-9.1 20.2-55.5-31.4 45.9c-2.2-87.7-7.8-305.1-7.9-306.9v-2.4 1-1 2.4c0 1-5.6 219-7.9 306.9l-31.4-45.9 20.2 55.5-62.6 9.1 62.6 9.1-24.2 47.4 34.5-36.2c-1.8 68.8-2.2 85.7-2.2 85.7s-154.4-71.7-68.6-230.1c0 0-107-118.1-10.1-190.7 0 0-165.5 99.9-60.5 271.5 0 0-86.8-84.8-41.4-170.5 0 0-78.7 111 17.2 233.1 0 0-26.2-16.1-49.4-77.7 0 0 16.9 183.3 222 185.7h4.1c205-2.4 222-185.7 222-185.7-23.6 61.5-49.9 77.7-49.9 77.7z" p-id="1758" fill="#ffffff"></path></svg>'
        local jedi_icon2 = renderer.load_svg(jedi_icon,50,50)
        if table_contains(ui.get(ideal.menu.indicators), "bar") then
        script.renderer:glow_module(X / 2 - 55, Y / 2 - 220, defensive_opa * 110, 0, 10, 0, {r, g, b, defensive_opa * 100}, {r, g, b, defensive_opa * 100})
        rounded_rectangle(X / 2 - 55, Y / 2 - 220, r, g, b, defensive_opa * 140, defensive_opa * 110, 2, 1)
        end
        charged_mes = renderer.measure_text("", "defensive manager ") + renderer.measure_text("", "ready  ")
        exploit_mes = renderer.measure_text("", "defensive manager ") 
        if table_contains(ui.get(ideal.menu.indicators), "text") then
        local ret = script.helpers:animate_text(globals.curtime(), "ready", r, g, b, defensive_opa2 * 255)
        renderer.text(X / 2, Y / 2 - 230,255, 255, 255, defensive_opa2 * 255, "c",  defensive_opa2 * charged_mes + 1, "defensive manager ", unpack(ret))
        end
        if table_contains(ui.get(ideal.menu.indicators), "icon") then
        renderer.texture(jedi_icon2, X/2 - 11, Y/2 - 260, 50, 50, r, g, b, defensive_opa * 220, 'f')
        end
        ideal.table.visuals.to_draw_ticks = ideal.table.visuals.to_draw_ticks + 1
        if ideal.table.visuals.to_draw_ticks == 200 then
            ideal.table.visuals.to_draw_ticks = 0
        end
    end
client.set_event_callback("paint", function()
    defensive_indicator()
    info_panel()
end)
local ground_ticks = 0
local end_time = 0
client.set_event_callback("pre_render", function()
    if ui.get(ideal.menu.antiaim_animation) then 
    if not entity.is_alive(entity.get_local_player()) then return end
    local on_ground = bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"), 1) == 1
    local slidewalk_directory = ui.reference("AA", "other", "leg movement")
    if ui.get(ideal.menu.antiaim_animation_ground) == "moonwalk" and on_ground then 
        entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 0, 7) 
        ui.set(slidewalk_directory, "Never Slide")
    elseif ui.get(ideal.menu.antiaim_animation_ground) == "sliding" and on_ground then 
       -- entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 0, 10)
        entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 1, 0) 
        ui.set(slidewalk_directory, "Always Slide")
    elseif ui.get(ideal.menu.antiaim_animation_ground) == "break" and on_ground then  
        entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 0, 8)
        entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 0, 9)
        entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 0, 10)
        ui.set(slidewalk_directory, "Never Slide")
    elseif ui.get(ideal.menu.antiaim_animation_ground) == "modern" and on_ground then  
        ui.set(slidewalk_directory, client.random_int(1, 2) == 1 and "Off" or "Always slide")
    --    entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 0, 8)
        entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 1 - client.random_float(0.5, 1), 0)
    else ui.set(slidewalk_directory, "Off")
    end
    local self_index = ent.new(entity.get_local_player())
    if bit.band(entity.get_prop(entity.get_local_player(), 'm_fFlags'), 1) == 0 then
    if ui.get(ideal.menu.antiaim_animation_air) == "static" then 
        entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 1, 6)
    end
    end
    if ui.get(ideal.menu.antiaim_animation_extra) == "reset pitch" then 
    local on_ground = bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"), 1)
    local fakelag = ui.reference("AA", "Fake lag", "Limit")
    if on_ground == 1 then
        ground_ticks = ground_ticks + 1
    else
        ground_ticks = 0
        end_time = globals.curtime() + 1
    end 
    if ground_ticks > ui.get(fakelag)+1 and end_time > globals.curtime() then
        entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 0.5, 12)
    end
end
else return end
end)
client.set_event_callback(
    "pre_render",
    function()
        if not ui.get(ideal.menu.antiaim_animation) then return end
        if not entity.is_alive(entity.get_local_player()) then
            return
        end
        if ui.get(ideal.menu.antiaim_animation_air) == "moonwalk" then
            local me = ent.get_local_player()
            local m_fFlags = me:get_prop("m_fFlags")
            local is_onground = bit.band(m_fFlags, 1) ~= 0
            if not is_onground then
                local my_animlayer = me:get_anim_overlay(6)
                my_animlayer.weight = 1
                entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 0, 7)
            end
        end
    end
)

client.set_event_callback(
    "pre_render",
    function()
        if not ui.get(ideal.menu.antiaim_animation) then return end
        if not entity.is_alive(entity.get_local_player()) then
            return
        end
        if ui.get(ideal.menu.antiaim_animation_air) == "running" then
            local me = ent.get_local_player()
            local m_fFlags = me:get_prop("m_fFlags")
            local is_onground = bit.band(m_fFlags, 1) ~= 0
            if not is_onground then
                local my_animlayer = me:get_anim_overlay(6)
                my_animlayer.weight = 1
            end
        end
    end
)

screen = {client.screen_size()}
center = {screen[1]/2, screen[2]/2}
state3, ground_time = 'nil', 0
alpha_pulse = 0
offset_move = 0
alpha_fade = 0
offset_dt = 0
offset_qp = 0
offset_center = 0
offset_state = 0
offset_quickpeek = 0
offset_rapid = 0
offset_center2 = 0
dtopa = 0
qpopa = 0
dtopa2 = 0
dtopa3 = 0 
dtopa4 = 0
dtopa5 = 0
dtopa6 = 0
offset_rapid2 = 0
offset_rapid3 = 0
offset_quickpeek2 = 0
dtopa7 = 0
offset_quickpeek3 = 0
mleft = 0
mright = 0
mfor = 0
offset_hs = 0
animated = function()



---Manual ind
r, g, b = ui.get(ideal.menu.color_picker)
screen = {client.screen_size()}
center = {screen[1] / 2, screen[2] / 2}
if ideal.anti_aim.aa_dir == 1 then
    mleft = script.helpers:clamp(mleft + globals.frametime() / 0.15, 0, 1)
    mright = script.helpers:clamp(mright - globals.frametime() / 0.15, 0, 1)
    mfor = script.helpers:clamp(mfor - globals.frametime() / 0.15, 0, 1)
elseif ideal.anti_aim.aa_dir == 2 then
    mleft = script.helpers:clamp(mleft - globals.frametime() / 0.15, 0, 1)
    mright = script.helpers:clamp(mright + globals.frametime() / 0.15, 0, 1)
    mfor = script.helpers:clamp(mfor - globals.frametime() / 0.15, 0, 1)
else
    mleft = script.helpers:clamp(mleft - globals.frametime() / 0.15, 0, 1)
    mright = script.helpers:clamp(mright - globals.frametime() / 0.15, 0, 1)
    mfor = script.helpers:clamp(mfor - globals.frametime() / 0.15, 0, 1)
end

--manual inds remove it if you need
renderer.text(center[1] - 60, center[2], r, g, b, mleft * 255, "+", nil, "‹")
renderer.text(center[1] + 60, center[2], r, g, b, mright * 255, "+", nil, "›")
---------







--ideal
local scrsize_x, scrsize_y = client_screensize()
local center_x, center_y = scrsize_x / 2, scrsize_y / 2
if ui.get(ideal.menu.indicators5) == "ideal" then
local aa_name = ui.get(ideal.reference.anti_aim.freestanding[1]) and "FREESTAND" or "IDEAL YAW"
local aa_name2 = ui.get(ideal.menu.antiaim_manual_left)  and "LEFT" or ui.get(ideal.menu.antiaim_manual_right) and "RIGHT" or "DYNAMIC"  
local aa_name2 = ideal.anti_aim.aa_dir == 1  and "LEFT" or ideal.anti_aim.aa_dir == 2 and "RIGHT" or "DYNAMIC"

client_draw_text(ctx, center_x, center_y+40, 215, 114, 44, 255, nil, 0,  aa_name)
client_draw_text(ctx, center_x, center_y+50, 209, 139, 230, 255, nil, 0, aa_name2)
if ui.get(ideal.reference.other.double_tap[1]) and ui.get(ideal.reference.other.double_tap[2]) then 
    client_draw_text(ctx, center_x, center_y+60, 10, 245, 5, 255, nil, 0, "DT")
else
    client_draw_text(ctx, center_x, center_y+60, 245, 10, 5, 255, nil, 0, "")

end


    if ui.get(ideal.reference.other.hide_shots[1]) and ui.get(ideal.reference.other.hide_shots[2]) and ui.get(ideal.reference.other.double_tap[1])and ui.get(ideal.reference.other.double_tap[2])then 
        client_draw_text(ctx, center_x, center_y+60, 10, 245, 5, 255, nil, 0, "DT(HS)")
    else
        client_draw_text(ctx, center_x, center_y+60, 245, 10, 5, 255, nil, 0, "")
end
end

----
local old_sun = {0,0,0}
local yes = false



local sun_prop = entity.get_all('CCascadeLight')[1]
    
    local new_sun = vector(entity.get_prop(sun_prop, "m_envLightShadowDirection"))

    if ui.get(ideal.menu.antiaim_anti_sun_rise) and yes == false then
        old_sun = vector(entity.get_prop(sun_prop, "m_envLightShadowDirection"))
        entity.set_prop(sun_prop,"m_envLightShadowDirection",0,0,0)
        yes = true
    elseif not ui.get(ideal.menu.antiaim_anti_sun_rise) then
        if yes == true then
            entity.set_prop(sun_prop,"m_envLightShadowDirection",old_sun.x,old_sun.y,old_sun.z)
            yes = false
        end
    end













local center22 = {screen[1] / 135, screen[2] / 3}
if ui.get(ideal.menu.debugindicators) == "1" then

    local guwno_x, guwno_y = renderer.measure_text("-d",string.upper("ideal["..login.build.."]    |    "..login.username.."    |    "..round(client.latency()*1000, 0).."ms"))
    renderer.gradient(center22[1], center22[2] - 5, guwno_x / 2 -1, guwno_y + 0, 0,0,0,0,0,0,0,0, true)
    renderer.gradient(center22[1] + guwno_x / 2 -1, center22[2] - 5, guwno_x / 0 + 1, guwno_y + 8, 0,0,0,0,0,0,0,0, true)
    renderer.text(center22[1], center22[2], 255,255,255,255, "-d", nil, string.upper("ideal    ["..login.build.."]    |    "..login.username.."    |    "..round(client.latency()*1000, 0).."ms"))
    --140, 125, 255
    renderer.gradient(center22[1], center22[2] + 13, guwno_x / 2 -1, 1, 140, 125, 255,0,140, 125, 255,255, true)
    renderer.gradient(center22[1] + guwno_x / 2 -1, center22[2] + 13, guwno_x / 2 + 1, 1, 140, 125, 255,255,140, 125, 255,0, true)

    renderer.text(center22[1], center22[2] + 15, 255,255,255,255, "-d", nil, string.upper("-condition: "..state3..""))
    renderer.text(center22[1], center22[2] + 25, 255,255,255,255, "-d", nil, string.upper("-target: "..entity.get_player_name(client.current_threat())..""))
    renderer.text(center22[1], center22[2] + 35, 255,255,255,255, "-d", nil, string.upper("-exploit  charge: "..antiaim_funcs.get_tickbase_shifting()..""))
    renderer.text(center22[1], center22[2] + 45, 255,255,255,255, "-d", nil, string.upper("-desync: "..math.floor(antiaim_funcs.get_desync(2))..""))
end

































if ui.get(ideal.menu.debugindicators) == "2" then
    renderer.text(center22[1], center22[2] + 4, 255, 255, 255, 255, "", 0, "idealyaw - " .. string.lower(login.username))
  --  renderer.text(center22[1], center22[2] + 14, 255, 255, 255, 255, "", 0, "version: \a" ..self.helpers:rgba_to_hex(255,255,255,255 * math.abs(math.cos(globals.curtime()*2))) .. string.lower(login.build))
    renderer.text(center22[1], center22[2] + 24, 255, 255, 255, 255, "", 0, "target: " .. string.lower(entity.get_player_name(client.current_threat())))
    renderer.text(center22[1], center22[2] + 34, 255, 255, 255, 255, "", 0, "body yaw: " .. math.floor(antiaim_funcs.get_body_yaw(2)))
    renderer.text(center22[1], center22[2] + 44, 255, 255, 255, 255, "", 0, "exploit charge: " .. antiaim_funcs.get_tickbase_shifting()) 
    renderer.text(center22[1], center22[2] + 54, 255, 255, 255, 255, "", 0, "choke: " .. globals.chokedcommands())
    renderer.text(center22[1], center22[2] + 64, 255, 255, 255, 255, "", 0, "overlap: " .. math.floor(antiaim_funcs.get_overlap() * 100))
end









if ui.get(ideal.menu.indicators5) == "modern" then
    local scoped = entity.get_prop(entity.get_local_player(), "m_bIsScoped") == 1
    if ui.get (ideal.reference.other.double_tap[2]) then 
    location = 48
    else location = 39
    end
    dted = ui.get(ideal.reference.other.double_tap[2]) == true
    qped = ui.get(ideal.reference.other.auto_peek[2]) == true  
    dtopa = ideal.table.visuals.animation_variables.movement(dtopa,dted,0,255,12)
    
    if qped and ideal.anti_aim.defensive == true then
    dtopa2 = script.helpers:clamp(dtopa2 - globals.frametime()/0.12, 0, 1)
    dtopa3 = script.helpers:clamp(dtopa3 - globals.frametime()/0.12, 0, 1)
    dtopa4 = script.helpers:clamp(dtopa4 - globals.frametime()/0.12, 0, 1)
    dtopa5 = script.helpers:clamp(dtopa5 - globals.frametime()/0.12, 0, 1)
    dtopa6 = script.helpers:clamp(dtopa6 - globals.frametime()/0.12, 0, 1)
    dtopa7 = script.helpers:clamp(dtopa7 + globals.frametime()/0.12, 0, 1)
    elseif qped and antiaim_funcs.get_double_tap() == true then
    dtopa2 = script.helpers:clamp(dtopa2 - globals.frametime()/0.12, 0, 1)
    dtopa3 = script.helpers:clamp(dtopa3 - globals.frametime()/0.12, 0, 1)
    dtopa4 = script.helpers:clamp(dtopa4 - globals.frametime()/0.12, 0, 1)
    dtopa5 = script.helpers:clamp(dtopa5 + globals.frametime()/0.12, 0, 1)
    dtopa6 = script.helpers:clamp(dtopa6 - globals.frametime()/0.12, 0, 1)
    dtopa7 = script.helpers:clamp(dtopa7 - globals.frametime()/0.12, 0, 1)
    elseif qped and antiaim_funcs.get_double_tap() == false then
    dtopa2 = script.helpers:clamp(dtopa2 - globals.frametime()/0.12, 0, 1)
    dtopa3 = script.helpers:clamp(dtopa3 - globals.frametime()/0.12, 0, 1)
    dtopa4 = script.helpers:clamp(dtopa4 - globals.frametime()/0.12, 0, 1)
    dtopa5 = script.helpers:clamp(dtopa5 - globals.frametime()/0.12, 0, 1)
    dtopa6 = script.helpers:clamp(dtopa6 + globals.frametime()/0.12, 0, 1)
    dtopa7 = script.helpers:clamp(dtopa7 - globals.frametime()/0.12, 0, 1)
    elseif dted and ideal.anti_aim.is_active_inds == true then
    dtopa2 = script.helpers:clamp(dtopa2 - globals.frametime()/0.12, 0, 1)
    dtopa3 = script.helpers:clamp(dtopa3 - globals.frametime()/0.12, 0, 1)
    dtopa4 = script.helpers:clamp(dtopa4 + globals.frametime()/0.12, 0, 1)
    dtopa5 = script.helpers:clamp(dtopa5 - globals.frametime()/0.12, 0, 1)
    dtopa6 = script.helpers:clamp(dtopa6 - globals.frametime()/0.12, 0, 1)
    dtopa7 = script.helpers:clamp(dtopa7 - globals.frametime()/0.12, 0, 1)
    elseif dted and antiaim_funcs.get_double_tap() == true then
    dtopa2 = script.helpers:clamp(dtopa2 + globals.frametime()/0.12, 0, 1)
    dtopa3 = script.helpers:clamp(dtopa3 - globals.frametime()/0.12, 0, 1)
    dtopa4 = script.helpers:clamp(dtopa4 - globals.frametime()/0.12, 0, 1)
    dtopa5 = script.helpers:clamp(dtopa5 - globals.frametime()/0.12, 0, 1)
    dtopa6 = script.helpers:clamp(dtopa6 - globals.frametime()/0.12, 0, 1)
    dtopa7 = script.helpers:clamp(dtopa7 - globals.frametime()/0.12, 0, 1)
    elseif dted and antiaim_funcs.get_double_tap() == false then
    dtopa2 = script.helpers:clamp(dtopa2 - globals.frametime()/0.12, 0, 1)
    dtopa3 = script.helpers:clamp(dtopa3 + globals.frametime()/0.12, 0, 1)
    dtopa4 = script.helpers:clamp(dtopa4 - globals.frametime()/0.12, 0, 1)
    dtopa5 = script.helpers:clamp(dtopa5 - globals.frametime()/0.12, 0, 1)
    dtopa6 = script.helpers:clamp(dtopa6 - globals.frametime()/0.12, 0, 1)
    dtopa7 = script.helpers:clamp(dtopa7 - globals.frametime()/0.12, 0, 1)
    else 
    dtopa2 = script.helpers:clamp(dtopa2 - globals.frametime()/0.12, 0, 1)
    dtopa3 = script.helpers:clamp(dtopa3 - globals.frametime()/0.12, 0, 1)
    dtopa4 = script.helpers:clamp(dtopa4 - globals.frametime()/0.12, 0, 1)
    dtopa5 = script.helpers:clamp(dtopa5 - globals.frametime()/0.12, 0, 1)
    dtopa6 = script.helpers:clamp(dtopa6 - globals.frametime()/0.12, 0, 1)
    dtopa7 = script.helpers:clamp(dtopa7 - globals.frametime()/0.12, 0, 1)
    end
    if ideal.anti_aim.is_active_inds == true then 
    dt_r, dt_g, dt_b = 155, 255, 155
    elseif antiaim_funcs.get_double_tap() == true then
    dt_r, dt_g, dt_b = 155, 255, 155
    elseif antiaim_funcs.get_double_tap() == false then
    dt_r, dt_g, dt_b =  255, 30, 30
    end
        
    qpopa = ideal.table.visuals.animation_variables.movement(qpopa,qped,0,255,12)
    rapid_mes = renderer.measure_text("", "  dt ready")/2 - 1
    rapid_mes2 = renderer.measure_text("", "  dt charging")/2 - 1
    rapid_mes3 = renderer.measure_text("", "  dt defensive")/2 - 1
    local_player = entity.get_local_player()
    if not entity.is_alive(local_player) then return end
    
    blink = math.sin(math.abs(-math.pi + (globals.realtime() * (1 / 0.5)) % (math.pi * 1))) * 255
    blink2 = math.sin(math.abs(-math.pi + (globals.realtime() * (1 / 0.5)) % (math.pi * 1))) * 120
    r,g,b = ui.get(ideal.menu.color_picker)
    cen_meas = renderer.measure_text("b", "ideal nightly")/2 - 1
    cen_meas3 = renderer.measure_text("b", "ideal nightly")/2 - 6 
    cen_meas2 = renderer.measure_text("b", "ideal nightly") - 12
    build_meas = renderer.measure_text("b", "nightly")
    state_mes = renderer.measure_text("", state3)/2 + 1
    qp_mes = renderer.measure_text("", "idealtick ready")/2 + 2
    qp_mes2 = renderer.measure_text("", "idealtick charging")/2 + 2
    qp_mes3 = renderer.measure_text("", "idealtick defensive")/2 + 1
    offset_qp = ideal.table.visuals.animation_variables.movement(offset_qp,qped,30,location,8)
    offset_center = ideal.table.visuals.animation_variables.movement(offset_center,scoped,1,cen_meas,10)
    offset_state = ideal.table.visuals.animation_variables.movement(offset_state,scoped,0,state_mes,8)
    offset_quickpeek = ideal.table.visuals.animation_variables.movement(offset_quickpeek,scoped,0,qp_mes,8)
    offset_quickpeek2 = ideal.table.visuals.animation_variables.movement(offset_quickpeek2,scoped,0,qp_mes2,8)
    offset_quickpeek3 = ideal.table.visuals.animation_variables.movement(offset_quickpeek3,scoped,0,qp_mes3,8)
    offset_rapid = ideal.table.visuals.animation_variables.movement(offset_rapid,scoped,0,rapid_mes,8)
    offset_rapid2 = ideal.table.visuals.animation_variables.movement(offset_rapid2,scoped,0,rapid_mes2,8)
    offset_rapid3 = ideal.table.visuals.animation_variables.movement(offset_rapid3,scoped,0,rapid_mes3,8)
    dtcolor = 0
    dt_mes = renderer.measure_text("", "dt ")
    p_mes = renderer.measure_text("", "idealtick ")
    if antiaim_funcs.get_double_tap() == false then
    dtcolor = 190
    else dtcolor = 255
    end
    charging_size = renderer.measure_text("", "ready ")
    charging_size2 = renderer.measure_text("", "charging ")
    charging_size3 = renderer.measure_text("", "defensive ")
    charging_size4 = renderer.measure_text("", "ready ")
    charging_size5 = renderer.measure_text("", "charging ")
    --script.renderer:glow_module(center[1] + offset_center - cen_meas3, center[2] + 30 - 10, cen_meas2, 0, 15, 0, {r, g, b, 90}, {r, g, b, 90})
    local ret = script.helpers:animate_text(globals.curtime(), "ready", dt_r, dt_g, dt_b, 255)
    local ret2 = script.helpers:animate_text(globals.curtime(), "charging", dt_r, dt_g, dt_b, 255)
    local ret3 = script.helpers:animate_text(globals.curtime(), "defensive", dt_r, dt_g, dt_b, 255)
    local ret4 = script.helpers:animate_text(globals.curtime(), "ready", 155, 255, 155, 255)
    local ret5 = script.helpers:animate_text(globals.curtime(), "charging", 255, 30, 30, 255)
    local ret6 = script.helpers:animate_text(globals.curtime(), "defensive", 155, 255, 155, 255)
    renderer.text(center[1] + offset_center - build_meas/2, center[2] + 30 - 10, 255,255,255, 255, "c", nil, "ideal")
    renderer.text(center[1] + offset_center + renderer.measure_text(" ", "ideal")/2 + 1, center[2] + 30- 10, r, g, b, 255, "c", nil, text_fade_animation(12,r, g,b,255, "recode"))
    renderer.text(center[1] + offset_state, center[2] + 40 - 10, 255, 255, 255, 255, "c" , nil, state3)
    renderer.text(center[1] + offset_rapid , center[2] + 48 + 2 - 10, 255, 255, 255, dtopa2 * 255, "c" , dt_mes + dtopa2 * charging_size, "dt \a" .. script.helpers:rgba_to_hex(155, 255, 155, dtopa2 * 255) .. "ready")
    renderer.text(center[1] + offset_rapid2, center[2] + 48 + 2 - 10, 255, 255, 255, dtopa3 * 255, "c" , dt_mes + dtopa3 * charging_size2, "dt ", unpack(ret2))
    renderer.text(center[1] + offset_rapid3, center[2] + 48 + 2 - 10, 255, 255, 255, dtopa4 * 255, "c" , dt_mes + dtopa4 * charging_size3,  "dt \a" .. script.helpers:rgba_to_hex(r, g, b, dtopa4 * 255) .. "defensive")
    renderer.text(center[1] + offset_quickpeek, center[2] + 48 + 2 - 10, 255, 255, 255, dtopa5 * 255, "c" , p_mes + dtopa5 * charging_size4, "idealtick \a" .. script.helpers:rgba_to_hex(155, 255, 155, dtopa5 * 255) .. "ready")
    renderer.text(center[1] + offset_quickpeek2 , center[2] + 48 + 2 - 10, 255, 255, 255, dtopa6 * 255, "c" , p_mes + dtopa6 * charging_size5, "idealtick ", unpack(ret5))
    renderer.text(center[1] + offset_quickpeek3, center[2] + 48 + 2 - 10, 255, 255, 255, dtopa7 * 255, "c" , p_mes + dtopa7 * charging_size3, "idealtick \a" .. script.helpers:rgba_to_hex(r, g, b, dtopa7 * 255) .. "defensive")
    end   
    end 














local function on_setup_command(cmd)
local lp = entity.get_local_player()
if not lp or not entity.is_alive(lp) then
return
end
local vec_velocity = { entity.get_prop(lp, 'm_vecVelocity') }
local flags = entity.get_prop(lp, 'm_fFlags')
              
if not vec_velocity[1] or not flags then
return
end
              
local duck_amount = entity.get_prop(lp, 'm_flDuckAmount')
local velocity = math.floor(math.sqrt(vec_velocity[1] ^ 2 + vec_velocity[2] ^ 2) + 0.5)
local air = bit.band(flags, 1) == 0         
if air == false then
ground_time = ground_time + 1
else
ground_time = 0
end
            


if ideal.anti_aim.aa_dir > 0 then
state3 = '- direction -'
elseif not ui.get(ideal.reference.other.double_tap[2]) then
state3 = '- fakelag -'
elseif ground_time < 8 and duck_amount > 0 then
state3 = '- air crouch -'
elseif ground_time < 8 then
state3 = '- in air -'
elseif duck_amount > 0 and velocity <= 2 then
state3 = '- crouch -'
elseif duck_amount > 0 and velocity >= 2 then
state3 = '- move crouch -'
elseif velocity < 3.1 then
state3 = '- stand -'
elseif velocity < 100 and ui.get(ideal.reference.other.slow_motion[2]) then
state3 = '- walking -'
else
state3 = '- run -'
end
end      
client.set_event_callback('setup_command', on_setup_command) 
client.set_event_callback("paint", animated)







