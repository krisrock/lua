 --------------------------
 local ui_new_slider, ui_new_combobox, ui_reference, ui_set_visible, ui_new_textbox, ui_new_color_picker, ui_new_checkbox, ui_mouse_position, ui_new_listbox, ui_new_multiselect, ui_is_menu_open, ui_new_hotkey, ui_set, ui_update, ui_menu_size, ui_name, ui_menu_position, ui_set_callback, ui_new_button, ui_new_label, ui_new_string, ui_get = ui.new_slider, ui.new_combobox, ui.reference, ui.set_visible, ui.new_textbox, ui.new_color_picker, ui.new_checkbox, ui.mouse_position, ui.new_listbox, ui.new_multiselect, ui.is_menu_open, ui.new_hotkey, ui.set, ui.update, ui.menu_size, ui.name, ui.menu_position, ui.set_callback, ui.new_button, ui.new_label, ui.new_string, ui.getlocal client_userid_to_entindex, client_set_event_callback, client_screen_size, client_trace_bullet, client_unset_event_callback, client_color_log, client_reload_active_scripts, client_scale_damage, client_get_cvar, client_camera_position, client_create_interface, client_random_int, client_latency, client_set_clan_tag, client_find_signature, client_log, client_timestamp, client_delay_call, client_trace_line, client_register_esp_flag, client_get_model_name, client_system_time, client_visible, client_exec, client_key_state, client_set_cvar, client_unix_time, client_error_log, client_draw_debug_text, client_update_player_list, client_camera_angles, client_eye_position, client_draw_hitboxes, client_random_float = client.userid_to_entindex, client.set_event_callback, client.screen_size, client.trace_bullet, client.unset_event_callback, client.color_log, client.reload_active_scripts, client.scale_damage, client.get_cvar, client.camera_position, client.create_interface, client.random_int, client.latency, client.set_clan_tag, client.find_signature, client.log, client.timestamp, client.delay_call, client.trace_line, client.register_esp_flag, client.get_model_name, client.system_time, client.visible, client.exec, client.key_state, client.set_cvar, client.unix_time, client.error_log, client.draw_debug_text, client.update_player_list, client.camera_angles, client.eye_position, client.draw_hitboxes, client.random_float
local native_GetClientEntity = vtable_bind("client_panorama.dll", "VClientEntityList003", 3, "void*(__thiscall*)(void*,int)")
local native_IsWeapon = vtable_thunk(165, "bool(__thiscall*)(void*)")
local native_GetInaccuracy = vtable_thunk(483, "float(__thiscall*)(void*)")
local num = 20





dmg = ui.reference("RAGE", "Aimbot", "Minimum damage")

client.set_event_callback("paint", function()
	xx, yy = client.screen_size()
	y = yy / 2
	x = xx / 2
	renderer.text(x+10,y-20,255,250,250,255,"C",0, ui.get(dmg))
end)

local ffi = require "ffi" or client.exec("quit");
local js = panorama.open() or client.exec("quit");
local http = require "gamesense/http" or client.exec("quit");
local discord = require "gamesense/discord_webhooks" or client.exec("quit");
local images = require "gamesense/images" or client.exec("quit");
local bit = require "bit" or client.exec("quit");
local csgo_weapons = require "gamesense/csgo_weapons" or client.exec("quit");
local js = panorama.open() or client.exec("quit");


local ref_unload = ui.reference("MISC", "Settings", "Unload") or client.exec("quit");


local function includes(table, key)
    local state = false
    for i = 1, #table do
        if table[i] == key then
            state = true
            break
        end
    end
    return state
end

local function multicolor_log(...)
    args = { ... }
    len = #args
    for i = 1, len do
        arg = args[i]
        r, g, b = unpack(arg)

        msg = {}

        if #arg == 3 then
            table.insert(msg, " ")
        else
            for i = 4, #arg do
                table.insert(msg, arg[i])
            end
        end
        msg = table.concat(msg)

        if len > i then
            msg = msg .. "\0"
        end

        client.color_log(r, g, b, msg)
    end
end

local screen = { client.screen_size() }
local center = { screen[1] / 2, screen[2] / 2 }

--[[
    Script:
    - Menu
]]

--ui.new_label("LUA", "B", "⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯")

--ui.new_label("LUA", "B", "                ４２０ － Ｓｙｎｃ")

local master_switch = ui.new_checkbox("AA", "Anti-aimbot angles", "\a1F72EEFFSmile-Yaw")
local aa_override = ui.new_checkbox("AA", "Anti-aimbot angles", "Anti-aim Smile-Yaw")
----------------------------Antiaim
local aa_options = ui.new_multiselect("AA", "Anti-aimbot angles", "Anti-aim options", "Jitter options", "Dynamic fake-yaw",  "Legit aa", "Manual anti-aim", "Dynamic fake-lag")
local aa_jitter = ui.new_multiselect("AA", "Anti-aimbot angles", "Jitter options", "Dormant", "When vulnerable", "Until vulnerable", "On miss", "On legit aa")
local aa_prediction = ui.new_slider("AA", "Anti-aimbot angles", "Freestanding", 0, 2, 0, true, "", 1, {[0] = "Normal", [1] = "Reversed", [2] = "Predictive"})
local aa_left = ui.new_hotkey("AA", "Anti-aimbot angles", "Manual left", false)
local aa_right = ui.new_hotkey("AA", "Anti-aimbot angles", "Manual right", false)
local aa_edgeyaw = ui.new_hotkey("AA", "Anti-aimbot angles", "Edge yaw", false)

--[[
    Script:
    - References
]]
local ref = {
    -- interface references.
    dtlimit = ui.reference("RAGE", "Other", "Double tap fake lag limit"),
    dtmode = ui.reference("RAGE", "Other", "Double tap mode"),
    menu = ui.reference("MISC", "Settings", "Menu color"),
    rage = { ui.reference("RAGE", "Aimbot", "Enabled") },
    damage = ui.reference("RAGE", "Aimbot", "Minimum damage"),
    dt = { ui.reference("RAGE", "Other", "Double tap") },
    dt_hc = ui.reference("RAGE", "Other", "Double tap hit chance"),
    fd = ui.reference("RAGE", "Other", "Duck peek assist"),
    mupc = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks"),
    anti_aim = { ui.reference("AA", "Anti-aimbot angles", "Enabled") },
    pitch = ui.reference("AA", "Anti-aimbot angles", "Pitch"),
    yaw = {ui.reference("AA", "Anti-aimbot angles", "Yaw")},
    yaw_base = ui.reference("AA", "Anti-aimbot angles", "Yaw Base"),
    jitter = { ui.reference("AA", "Anti-aimbot angles", "Yaw jitter") },
    body_yaw = { ui.reference("AA", "Anti-aimbot angles", "Body yaw") },
    fs = { ui.reference("AA", "Anti-aimbot angles", "Freestanding")},
    fs_body_yaw = ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw"),
    fake_limit = ui.reference("AA", "Anti-aimbot angles", "Fake yaw limit"),
    legs = ui.reference("AA", "Other", "Leg movement"),
    slow = { ui.reference("AA", "other", "slow motion") },
    third_person = { ui.reference("VISUALS", "Effects", "Force third person (alive)") },
    wall = ui.reference("VISUALS", "Effects", "Transparent walls"),
    prop = ui.reference("VISUALS", "Effects", "Transparent props"),
    skybox = ui.reference("VISUALS", "Effects", "Remove Skybox"),
    edge = ui.reference("AA", "Anti-aimbot angles", "Edge yaw"),
    fl = ui.reference("AA", "Fake lag", "Enabled"),
    fl_amt = ui.reference("AA", "Fake lag", "Amount"),
    fl_var = ui.reference("AA", "Fake lag", "Variance"),
    fl_limit = ui.reference("AA", "Fake lag", "Limit"),
    hs = { ui.reference("AA", "Other", "On shot anti-aim") },
}



local function on_show_hide_menu()
	local state = ui.get(ref.enabled)
	local active_i = var.state_to_idx[ui.get(anti_aim[0].player_state)]

	ui.set_visible(ref.fs[1],state)
	ui.set_visible(ref.fs[2],state)


	ui.set_visible(ref.double_tap[1],state)
	ui.set_visible(ref.double_tap[2],state)

	ui.set_visible(ref.os[1],state)
	ui.set_visible(ref.os[2],state)
    end
--[[
    Script:
    - Modules
]]
local eventcb, ui_set, ui_ref = client.set_event_callback, ui.set, ui.reference
local build = {
    user = lp_ign,
    ver = "1.0.3",
    type = "Debug",
}

local vars = {
    -- storage.
    status = "default",

    -- player-based.
    target = nil,
    distance = nil,
    phase = nil,

    -- on-miss.
    info = {},
    miss = globals.curtime(),

    -- fractions.
    lby_fraction = nil,
    radius_fraction = nil,

    -- freestanding.
    left_data = {},
    right_data = {},
    hit_side = nil,

    fs_data = {},
    fs_side = nil,

    -- anti-bruteforce.
    bf_side = 1,
    bf_timer = globals.curtime(),

    -- vulnerability.
    vulnerable = false,
}

--[[
    Script:
    - Helpers v2
]]

local function get_velocity(ent)
    -- Get velocity prop of entity parameter.
    local x, y, z = entity.get_prop(ent, "m_vecVelocity")
    -- Return a consistent number.
    return (x * x) + (y * y)
end

vars.get_target = function()
    -- Reset our collected data on each callback.
    vars.target = nil
    vars.distance = 8192.0

    -- Retrieve our local player index.
    local me = entity.get_local_player()

    -- Now we return the local players position (x, y, z) to the following variables.
    local l_x, l_y, l_z = entity.get_prop(me, "m_vecOrigin")

    -- Retrieve the index of all available enemies.
    local enemies = entity.get_players(true)

    -- Create variables that will be used in later comparisions.
    local max_dist = 8192.0

    -- Begin a for loop to sort through our collected enemy index (beginning increment of 1, maximum value is set to the amount of collected enemies).
    for i=1, #enemies do
        -- Now we can retrieve an individuals enemy's position (x, y, z) and assign it to the following variables.
        local e_x, e_y, e_z = entity.get_prop(enemies[i], "m_vecOrigin")

        -- Now we perform basic math to calculate our distance to our minimised enemy index.
        local dist = (e_x - l_x) + (e_y - l_y)

        -- Now we compare variables and minimise our enemy index even further to retrieve a target.
        if max_dist > dist then
            -- Reassign new values to our variables.
            max_dist = dist

            -- Update our module data.
            vars.target = enemies[i]
            vars.distance = distance
        end
    end
end

vars.freestand_trace = function(points, increment, max_dist)
    -- Retrieve our local player index.
    local me = entity.get_local_player()

    -- Get how many points we will place on both sides.
    local amt_left = math.floor(math.min(points / 2))
    local amt_right = math.floor(math.min(points / 2))

    -- Retrieve our locals eye pos and assign to variables.
    local eye_x, eye_y, eye_z = client.eye_position()
    -- Retrieve our locals camera pos and assign to variables.
    local pitch, yaw, roll = client.camera_position()

    -- Assign our maximums for later comparisions.
    local max_dist = 8192.0

    for i=0, amt_left, increment do
        local left = { client.trace_line(i, eye_x, eye_y, eye_z, pitch, yaw, roll) }
        local left_dist = left[1] * max_dist

        vars.left_data[0] = left[1]
        vars.left_data[1] = left[2]
        vars.left_data[2] = left_dist
    end

    for i=0, amt_right, increment do
        local right = { client.trace_line(i, eye_x, eye_y, eye_z, pitch, yaw, roll) }
        local right_dist = right[1] * max_dist

        vars.right_data[0] = right[1]
        vars.right_data[1] = -right[2]
        vars.right_data[2] = right_dist
    end
end

vars.miss_info = function(e)
    local me = entity.get_local_player() -- retrieve local player index

    if entity.is_alive(me) == false then return end -- if local player is not alive then return end

    if vars.target == nil then return end -- if no enemy is available then quit

    local enemy = client.userid_to_entindex(e.userid) -- user shot data

    if not entity.is_enemy(enemy) or entity.is_dormant(enemy) then return end

    local lx, ly, lz = entity.hitbox_position(me, "head_0")

    local ex,ey,ez = entity.get_prop(enemy, "m_vecOrigin") -- get enemy positions
    local mx,my,mz = entity.get_prop(me, "m_vecOrigin") -- get local player positions

    local dist = ((e.y - ey)*lx - (e.x - ex)*ly + e.x*ey - e.y*ex) / math.sqrt((e.y-ey)^2 + (e.x - ex)^2) -- calculating bullet miss radius

    if dist <= 125 then -- shot radious is within the assigned
        vars.info[vars.target] = dist
        vars.bf_side = vars.bf_side * -1
        vars.radius_fraction = (dist / 125)
        vars.miss = globals.curtime() + 2.5
    end
end

local function normalize_yaw(yaw)
	while yaw > 180 do yaw = yaw - 360 end
	while yaw < -180 do yaw = yaw + 360 end
	return yaw
end

local function clamp(num, min, max)
    if num > max then
        return max
    elseif min > num then
        return min
    end
    return num
end

local function world2scren(xdelta, ydelta)
	if xdelta == 0 and ydelta == 0 then
		return 0
	end
	return math.deg(math.atan2(ydelta, xdelta))
end

-- shit code for an indicator preview that can be seen later.
local desync_preview = 0
local desync_up = false
client.set_event_callback("paint_ui", function()
    if desync_up == false then
        if desync_preview == 57 then
            desync_preview = 57
            desync_up = true
        else
            desync_preview = desync_preview + 0.25
        end
    elseif desync_up == true then
        if desync_preview == 0 then
            desync_preview = 0
            desync_up = false
        else
            desync_preview = desync_preview - 0.25
        end
    end
end)

local function calc_angle(local_x, local_y, enemy_x, enemy_y)
	local ydelta = local_y - enemy_y
	local xdelta = local_x - enemy_x
	local relativeyaw = math.atan( ydelta / xdelta )
	relativeyaw = normalize_yaw( relativeyaw * 180 / math.pi )
	if xdelta >= 0 then
		relativeyaw = normalize_yaw(relativeyaw + 180)
	end
	return relativeyaw
end

local function make_dsy(x)
    local x_length = #tostring(x)
    local divis_factor = x_length - 1
  
    local divis_val = 1
  
    for i=2,divis_factor,1 do
        divis_val = divis_val * 12
    end
  
    local val_one = x / divis_val
  
    if val_one > 58 then
        return val_one / 2
    else
        return val_one
    end
    
end

local function make_byaw(x)
    local x_length = #tostring(x)
    local divis_factor = x_length - 2
  
    local divis_val = 1
  
    for i=2,divis_factor,1 do
        divis_val = divis_val * 10
    end
  
    local val_one = x / divis_val
  
    if val_one > 360 then
        return normalize_yaw(val_one / 2)
    else
        return normalize_yaw(val_one)
    end
    
end --]]

-- will return nil sometimes
local function select_mode(num,modes)
    local table_data = #modes
    local x_length = #tostring(num)
    local divis_factor = x_length
  
    local divis_val = 1
  
    for i=2,divis_factor,1 do
        divis_val = divis_val * 10
    end
  
    local val_one = num / divis_val
  
    if val_one > table_data then
        return modes[math.floor(val_one / x_length)]
    else
        return modes[math.floor(val_one)]
    end

end

local function round(x)
    return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end

local function dtr(x)
    return x / 180 * math.pi
end

local function rtd(x)
    return x * 180 / math.pi
end

local function angle_to_vec( pitch, yaw )
    local p = dtr(pitch)
    local y = dtr(yaw)
    local sin_p = math.sin( p );
    local cos_p = math.cos( p );
    local sin_y = math.sin( y );
    local cos_y = math.cos( y );
    return cos_p * cos_y, cos_p * sin_y, -sin_p
end

-- this failed so dont use
vars.trace_wall = function(entity_id,int,entity_angles)
    local evec_x,evec_y,evec_z = angle_to_vec(int, entity_angles[1])
    local epox_x,epos_y,epos_z = entity.get_prop(entity_id, "m_vecOrigin")
    
    -- epos_z = epos_z + 50
    local stop = {  evec_x + evec_x * 8192, epos_y + evec_y * 8192, epos_z + evec_z * 8192 }
    
    local trace_result = client.trace_line(entity_id, epox_x, epos_y, epos_z, stop[1], stop[2], stop[3])
    if trace_result == 1 then return end

    stop = { epox_x + evec_x * trace_result * 8192, epos_y + evec_y * trace_result * 8192, epos_z + evec_z * trace_result * 8192 }

    local distance = math.sqrt((epox_x - stop[1] ) * (epox_x - stop[1] ) + (epos_y - stop[2] ) * (epos_y - stop[2] ) + (epos_z - stop[3] ) * (epos_z - stop[3] ) )

    return distance
end

vars.damage = function(me,enemy,x,y,z,ticks)
    -- Create 3 tables to contain x, y, and z offsets.
    local mx = {}
    local my = {}
    local mz = {}

    -- Tamper with the inputted offsets and assign them a position in the previously defined tables.
    local e_h = { entity.hitbox_position(enemy, 1) }

    -- Default X,Y,Z
    mx[1],my[1],mz[1] = e_h[1], e_h[2], e_h[3]

    -- Extrapolated X
    mx[2],my[2],mz[2] = e_h[1] + ticks, e_h[2], e_h[3] -- Positive
    mx[3],my[3],mz[3] = e_h[1] - ticks, e_h[2], e_h[3] -- Negative

    -- Extrapolated Y
    mx[4],my[4],mz[4] = e_h[1], e_h[2] + ticks, e_h[3] -- Positive
    mx[5],my[5],mz[5] = e_h[1], e_h[2] - ticks, e_h[3] -- Negative

    -- Extrapolated Z
    mx[6],my[6],mz[6] = e_h[1], e_h[2], e_h[3] + ticks -- Positive
    mx[7],my[7],mz[7] = e_h[1], e_h[2], e_h[3] - ticks -- Negative

    -- Loop through previously defined tables.
    for i=1, 7, 1 do
        -- Define a damage variable for later comparisions.
        local damage = 0

        -- Simplistic trace.bullet to get approximate damage that can be dealt.
        local trace_ent, trace_damage = client.trace_bullet(enemy, mx[i], my[i], mz[i], x, y, z, false)

        -- Trace damage is over previously defined damage then update said damage variable.
        if trace_damage > damage then
            damage = trace_damage
            vars.hit_damage = trace_damage
        end

        -- Return approximate damage.
        return damage
    end
end

local function get_airstate(ent)
    if ent == nil then return false, 0 end
    local flags = entity.get_prop(ent, "m_fFlags")
    if bit.band(flags, 1) == 0 then
        return true
    end
    return false
end

--[[
    Script:
    - Anti-aim
]]

local last_pressed_manual = globals.curtime()
local last_dsy_save = 0
local movement_trigger = false
local movement_timer = globals.curtime()
local function anti_aim()
    if ui.get(master_switch) == false or ui.get(aa_override) == false then return end
  --  if ui.get(master_switch) == false or ui.get(enabled) == false then return end
    vars.lby_fraction = math.abs(entity.get_prop(entity.get_local_player(), "m_flLowerBodyYawTarget") / 180)

    local is_manualing = false
    local is_left = false
    local is_right = false

    if get_velocity(entity.get_local_player()) > 110 then
        movement_trigger = false
        movement_timer = globals.curtime() + 0.5
    else
        if movement_timer > globals.curtime() then
            movement_trigger = true
        else
            movement_trigger = false
        end
    end

    if ui.get(aa_left) then
        is_left = true
        is_right = false
        is_manualing = true
        last_pressed_manual = globals.curtime() + 0.1
    end

    if ui.get(aa_right) then
        is_left = false
        is_right = true
        is_manualing = true
        last_pressed_manual = globals.curtime() + 0.1
    end

    if is_left or is_right then
        ui.set(ref.edge, false)
    elseif ui.get(aa_edgeyaw) then
        ui.set(ref.edge, true)
    else
        ui.set(ref.edge, false)
    end

    if includes(ui.get(aa_options), "Dynamic fake-lag") then
        local weapon = entity.get_prop(entity.get_local_player(), "m_hActiveWeapon")
        local next_attack = 0
        local next_primary_attack = 0
        if weapon ~= nil then
            next_attack = entity.get_prop(entity.get_local_player(), "m_flNextAttack") + 0.25
            next_primary_attack = entity.get_prop(weapon, "m_flNextPrimaryAttack") + 0.25
        end

        if ui.get(ref.fd) then
            ui.set(ref.fl_var, 0)
            ui.set(ref.fl_limit, 14)
        elseif next_attack > globals.curtime() or next_primary_attack > globals.curtime() and not get_airstate(entity.get_local_player()) then
            ui.set(ref.fl_var, 0)
            ui.set(ref.fl_limit, 1)
        else
            ui.set(ref.fl_var, vars.vulnerable == true and 30 or 15)
            ui.set(ref.fl_limit, 14)
        end

        if ui.get(ref.fd) then
            ui.set(ref.fl_amt, "Dynamic")
        elseif vars.miss > globals.curtime() and not get_airstate(entity.get_local_player()) then
            ui.set(ref.fl_amt, "Fluctuate")
        elseif vars.hit_side ~= nil and (vars.hit_side == 0.5 or vars.hit_side == -0.5) and not get_airstate(entity.get_local_player()) then
            ui.set(ref.fl_amt, "Maximum")
        else
            ui.set(ref.fl_amt, "Dynamic")
        end
    end

    vars.status = "static"

    -- if we have no rendered players out of dormancy then a large majority of our helpers will perform nothing so we will just seperate it with another antiaim mode
    if vars.target == nil then
        vars.status = "dormant"

        ui.set(ref.pitch, "Minimal")
        ui.set(ref.yaw[1], "180")
        if is_left and last_pressed_manual > globals.curtime() and includes(ui.get(aa_options), "Manual anti-aim") then
            ui.set(ref.yaw[2], -90)
        elseif is_right and last_pressed_manual > globals.curtime() and includes(ui.get(aa_options), "Manual anti-aim") then
            ui.set(ref.yaw[2], 90)
        else
            ui.set(ref.yaw[2], -3)
        end
        ui.set(ref.jitter[1], "Center")
        ui.set(ref.jitter[2], -25)
        if includes(ui.get(aa_options), "Jitter options") and includes(ui.get(aa_jitter), "Dormant") then
            ui.set(ref.body_yaw[1], "Jitter")
            ui.set(ref.body_yaw[2], 0)
            ui.set(ref.fs_body_yaw, false)
        else
            ui.set(ref.body_yaw[1], "Static")
            ui.set(ref.body_yaw[2], 30)
            ui.set(ref.fs_body_yaw, true)
        end
        if includes(ui.get(aa_options), "Legit aa") and client.key_state(0x45) and includes(ui.get(aa_jitter), "On legit aa") then
            ui.set(ref.body_yaw[1], "Jitter")
            
        end
        ui.set(ref.fake_limit, 60)
    else
        --[[
            Variable setting below:
        ]]

        -- vars.vulnerable | vars.hit_side
        local lx, ly, lz = client.eye_position()
        local view_x, view_y, roll = client.camera_angles()
        local e_x, e_y, e_z = entity.hitbox_position(vars.target, 0)
    
        local yaw = calc_angle(lx, ly, e_x, e_y)
        local rdir_x, rdir_y, rdir_z = angle_to_vec(0, (yaw + 90))
        local rend_x = lx + rdir_x * 10
        local rend_y = ly + rdir_y * 10
    
        local ldir_x, ldir_y, ldir_z = angle_to_vec(0, (yaw - 90))
        local lend_x = lx + ldir_x * 10
        local lend_y = ly + ldir_y * 10

        local yaw = calc_angle(lx, ly, e_x, e_y)
        local rdir_x_two, rdir_y_two, rdir_z_two = angle_to_vec(0, (yaw + 90))
        local rend_x_two = lx + rdir_x_two * 100
        local rend_y_two = ly + rdir_y_two * 100
    
        local ldir_x_two, ldir_y_two, ldir_z_two = angle_to_vec(0, (yaw - 90))
        local lend_x_two = lx + ldir_x_two * 100
        local lend_y_two = ly + ldir_y_two * 100

        local left_trace = vars.damage(entity.get_local_player(), vars.target, rend_x, rend_y, lz, 40)
        local right_trace = vars.damage(entity.get_local_player(), vars.target, lend_x, lend_y, lz, 40)
        local left_trace_two = vars.damage(entity.get_local_player(), vars.target, rend_x_two, rend_y_two, lz, 40)
        local right_trace_two = vars.damage(entity.get_local_player(), vars.target, lend_x_two, lend_y_two, lz, 40)

        if left_trace > 0 or right_trace > 0 or left_trace_two > 0 or right_trace_two > 0 then
            vars.vulnerable = true
            if left_trace > right_trace then
                vars.hit_side = 0.5
            elseif right_trace > left_trace then
                vars.hit_side = -0.5
            elseif left_trace_two > right_trace_two then
                vars.hit_side = 1
            elseif right_trace_two > left_trace_two then
                vars.hit_side = -1
            end
        else
            vars.vulnerable = false
            vars.hit_side = nil
        end

        --[[
            Fully dynamic anti-aim below:
        ]]

        local head_side = 1

        local lx,ly,lz = entity.hitbox_position(entity.get_local_player(), "head_0")
        local ex,ey,ez = entity.hitbox_position(vars.target, "head_0")
        local head_comparision = (lx - ex) + (ly - ey)

        local pitch,yaw,roll = client.camera_position()
        local head_pos_camera_pos = ((lx - ex) * pitch) + ((ly - ey) * yaw)

        local x,y,z = client.eye_position()
        local head_pos_eye_pos = ((lx - ex) * x) + ((ly - ey) * y)

        -- Standard
        if (head_pos_camera_pos - head_pos_eye_pos) * head_comparision > 0 then
            head_side = 1
        else
            head_side = -1
        end

        local use_lby_fract = vars.lby_fraction > 0.5 and true or false

        -- no need to modify pitch ofc
        ui.set(ref.pitch, "Minimal")

        -- same story with yaw
        ui.set(ref.yaw[1], "180")
        -- manual antiaim
        if is_left and last_pressed_manual > globals.curtime() and includes(ui.get(aa_options), "Manual anti-aim") then
            ui.set(ref.yaw[2], -90)
        elseif is_right and last_pressed_manual > globals.curtime() and includes(ui.get(aa_options), "Manual anti-aim") then
            ui.set(ref.yaw[2], 90)
        else
            -- horrible yaw offsets
            ui.set(ref.yaw[2], -vars.target)
        end
        
        -- random jitter if recently stopped moving
        if movement_trigger then
            ui.set(ref.jitter[1], "Random")
            ui.set(ref.jitter[2], 19)
        -- center -11 jitter if we are using jitter body yaw
        elseif ui.get(ref.body_yaw[1]) == "Jitter" then
            ui.set(ref.jitter[1], "Center")
            ui.set(ref.jitter[2], -25)
        else
            -- wow much shit code here
            -- chooses a jitter type and range based off of our eye's x position
            local jitter_type = {"Offset", "Center", "Random"}
            local select_jitter = select_mode(lx, jitter_type)

            if select_jitter ~= nil then
                ui.set(ref.jitter[1], select_jitter)
                ui.set(ref.jitter[2], round(make_byaw(lx) / 9) * head_side)
            else
                ui.set(ref.jitter[1], "Off")
                ui.set(ref.jitter[2], 0)
            end
        end
        
        -- #atoz x teamskeet jitter body yaw **ideas** executed perfectly :clown:
        if includes(ui.get(aa_options), "Jitter options") then
            if includes(ui.get(aa_options), "Legit aa") and client.key_state(0x45) and includes(ui.get(aa_jitter), "On legit aa") then
                ui.set(ref.body_yaw[1], "Jitter")
                
            end
            if (includes(ui.get(aa_jitter), "When vulnerable") and vars.vulnerable == true)
            or (includes(ui.get(aa_jitter), "Until vulnerable") and vars.vulnerable == false)
            or (includes(ui.get(aa_jitter), "On miss") and vars.miss > globals.curtime()) then
                ui.set(ref.body_yaw[1], "Jitter")
            else
                if (ui.get(ref.body_yaw[2]) > 59 or ui.get(ref.body_yaw[2]) < -59) or entity.get_prop(entity.get_local_player(), "m_flDuckAmount") <= 0.4 then
                    ui.set(ref.body_yaw[1], "Static")
                else
                    ui.set(ref.body_yaw[1], "Opposite")
                end
            end

        else
            ui.set(ref.body_yaw[1], "Static")
        end

        local eye_pos = { client.eye_position() }
        local wall_trace_one = vars.trace_wall(entity.get_local_player(), 0, eye_pos)

        vars.fs_data = {}

        if vars.hit_side ~= nil then
            vars.fs_side = vars.hit_side
        else
            if ui.get(aa_prediction) == 0 then
                vars.fs_data[1] = vars.left_data[1] == nil and 1 or vars.left_data[1]
            elseif ui.get(aa_prediction) == 1 then
                vars.fs_data[1] = vars.right_data[1] == nil and 1 or vars.right_data[1]
            else
                vars.fs_data[1] = vars.left_data[1] == nil and 1 or vars.left_data[1]
            end
            vars.fs_data[2] = vars.bf_timer > globals.curtime() and vars.bf_side or 1
            vars.fs_data[3] = head_side == nil and 1 or head_side

            vars.fs_side = ((clamp(vars.left_data[1], -1, 1) * vars.fs_data[2]) * vars.fs_data[3])
        end

    

        -- freestanding body yaw and more shit
        -- randomisation is actually good - Ivan 2021
        if vars.hit_side ~= nil and vars.hit_side == 0.5 and vars.hit_side == -0.5 and ui.get(ref.body_yaw[1]) == "Jitter" then
            ui.set(ref.body_yaw[2], round(math.random(0,180) * -vars.fs_side))
        else
            if vars.info[vars.target] ~= nil and ui.get(aa_prediction) == 2 then
                ui.set(ref.body_yaw[2], round(31 * -vars.fs_side))
            else
                ui.set(ref.body_yaw[2], round(31 * vars.fs_side))
            end
        end

        -- no need to use this
        ui.set(ref.fs_body_yaw, false)

        if includes(ui.get(aa_options), "Dynamic fake-yaw") then
            if vars.info[vars.target] ~= nil then -- if we have a recorded miss record then
                if entity.get_prop(entity.get_local_player(), "m_flDuckAmount") > 0.4 then
                    -- goofy yaw duck aa
                    vars.status = "safe-duck"
                    ui.set(ref.fake_limit, 47)
                elseif vars.miss >= globals.curtime() then
                    -- this should usually return a largely low delta
                    -- will initiate after a recent miss
                    vars.status = "dodge"
                    ui.set(ref.fake_limit, round(make_dsy(vars.info[vars.target])))
                else
                    -- otherwise we use the miss information as a base for our fake yaw and add our other modifiers (fractions :muscle:)
                    vars.status = "safe"
                    if vars.lby_fraction > 0.5 then
                        ui.set(ref.fake_limit, 38)
                    else
                        last_dsy_save = 32
                        ui.set(ref.fake_limit, round(last_dsy_save - make_dsy(vars.info[vars.target])))
                    end
                end
            else
                -- no recorded miss record
                if entity.get_prop(entity.get_local_player(), "m_flDuckAmount") > 0.4 and get_airstate(entity.get_local_player()) == false then
                    -- goofy yaw duck aa (i love kami <3)
                    vars.status = "duck"
                    ui.set(ref.fake_limit, 57)
                else
                    if use_lby_fract == true then
                        -- really premium name, this phase just uses some cool fractions defined and created previously
                        vars.status = "stout"
                        ui.set(ref.fake_limit, round(58 * vars.lby_fraction))
                        last_dsy_save = round(58 * vars.lby_fraction)
                        ui.set(ref.fake_limit, 43)

                    else
                        -- hittability section
                        if vars.hit_side == 0.5 or vars.hit_side == -0.5 then
                            -- hittable w/ no extrapolation so we will go to some degree of low delta
                            vars.status = "impact"
                            ui.set(ref.fake_limit, 23)
                            last_dsy_save = 23
                        elseif vars.hit_side == 1 or vars.hit_side == -1 then
                            -- hittable with extrapolation so we will swap the previous value cause logic moment
                            vars.status = "early"
                            ui.set(ref.fake_limit, 32)
                            last_dsy_save = 32
                        else
                            -- just high delta if idling a condition
                            ui.set(ref.fake_limit, 57)
                            last_dsy_save = 57
                        end
                    end
                end
            end
        else
            if vars.info[vars.target] ~= nil then
                -- this target has missed us lets become a onetap scripter and permanently force low delta
                vars.status = "safe"
                ui.set(ref.fake_limit, 13)
            else
                if vars.hit_side == 1 then
                    if entity.get_prop(entity.get_local_player(), "m_flDuckAmount") > 0.4 and get_airstate(entity.get_local_player()) == false then
                        -- goofy yaw aa
                        vars.status = "safe-duck"
                        ui.set(ref.fake_limit, 47)
                    else
                        -- hittable on the right so 23
                        vars.status = "right"
                        ui.set(ref.fake_limit, 23)
                    end
                elseif vars.hit_side == -1 then
                    if entity.get_prop(entity.get_local_player(), "m_flDuckAmount") > 0.4 and get_airstate(entity.get_local_player()) == false then
                        -- goofy moment
                        vars.status = "safe-duck"
                        ui.set(ref.fake_limit, 47)
                    else
                        -- extend more for left values as it is more easily safepointable
                        vars.status = "left"
                        ui.set(ref.fake_limit, 32)
                    end
                else
                    -- idle high delta
                    ui.set(ref.fake_limit, 57)
                end
            end
        end

        -- :clown:
        if ui.get(ref.body_yaw[1]) == "Jitter" then
            vars.status = "jitter"
        end
    end

    -- split value if over 28 mid delta
 --[[  if includes(ui.get(aa_options), "Avoid high delta") and ui.get(ref.fake_limit) > 28 then
        ui.set(ref.fake_limit, ui.get(ref.fake_limit) / 2)
    end--]]

    -- crazy hotfix instead of like 10 checks :sunglasses:
    if ui.get(ref.fake_limit) < 10 then
        ui.set(ref.fake_limit, ui.get(ref.fake_limit) * 2)
    end
end 

client.set_event_callback("setup_command",function(e)
    if ui.get(aa_override) == false or ui.get(master_switch) == false then return end
 --   if ui.get(enabled) == false or ui.get(master_switch) == false then return end
  
    local weaponn = entity.get_player_weapon()
    if includes(ui.get(aa_options), "Legit aa") and client.key_state(0x45) then
        if weaponn ~= nil and entity.get_classname(weaponn) == "CC4" then
            if e.in_attack == 1 then
                e.in_attack = 0 
                e.in_use = 1
            end
        else
            if e.chokedcommands == 0 then
                e.in_use = 0
            end
        end
    end
end)





--[[
    Script:
    - Doubletap
]]

local dt_shift = 16
local dt_hc = 0
local dt_cc = 0
local damage_cache = 0
local reset_dt = false
local function double_tap(cmd)
    if ui.get(master_switch) == false then return end

	local weapon_ent = entity.get_player_weapon(entity.get_local_player())
	if weapon_ent == nil then return end

	local weapon = csgo_weapons(weapon_ent)
	if weapon == nil then return end

	local weapon_idx = entity.get_prop(weapon_ent, "m_iItemDefinitionIndex")
	local weapon = csgo_weapons[weapon_idx]


end

--[[
    Script:
    - Visuals
]]

local i_index = 0
local kk_index = 0
local function visuals()
    local scrx, scry = client.screen_size()
    local x, y = scrx / 2, scry / 2
    local h_index = 0
    local k_index = 0
    local cock = 0
    local debug_index = 0

    local local_player = entity.get_local_player()

   -- local p_r, p_g, p_b, p_a = ui.get(prim_picker)



    
    if local_player == nil then return end

    if not entity.is_alive(local_player) then return end

    local desync = math.min(57, math.abs(entity.get_prop(entity.get_local_player(), "m_flPoseParameter", 11)*120-60))

    local e_pose_param = math.min(57, entity.get_prop(entity.get_local_player(), "m_flPoseParameter", 11)*120-60)

    local weapon = entity.get_prop(entity.get_local_player(), "m_hActiveWeapon")
    local next_attack = 0
    local next_primary_attack = 0
    if weapon ~= nil then
        next_attack = entity.get_prop(entity.get_local_player(), "m_flNextAttack") + 0.25
        next_primary_attack = entity.get_prop(weapon, "m_flNextPrimaryAttack") + 0.25
    end

    local exploit_charge = math.abs(1 - math.abs(globals.curtime() - next_attack))

    local pulse = round(math.sin(math.abs((math.pi * -1) + (globals.curtime() * (1 / 0.3)) % (math.pi * 2))) * 155) --]]


end

--[[
    Script:
    - Miscellaneous
]]




--[[
    Script:
    - Elements
]]

local function handle_menu(reset)
    if reset == false then
        ui.set_visible(aa_override, ui.get(master_switch))
    --    ui.set_visible(enabled, ui.get(master_switch))
        ui.set_visible(aa_options, ui.get(aa_override) and ui.get(master_switch))
        ui.set_visible(aa_jitter, ui.get(aa_override) and includes(ui.get(aa_options), "Jitter options") and ui.get(master_switch))
        ui.set_visible(aa_prediction, ui.get(aa_override) and ui.get(master_switch))
       
        
        ui.set_visible(aa_left, ui.get(aa_override) and includes(ui.get(aa_options), "Manual anti-aim") and ui.get(master_switch))
        ui.set_visible(aa_right, ui.get(aa_override) and includes(ui.get(aa_options), "Manual anti-aim") and ui.get(master_switch))
        ui.set_visible(aa_edgeyaw, ui.get(aa_override) and ui.get(master_switch))
    end
    end


        client.set_event_callback("run_command", function()
            -- helpers
            vars.get_target()
            vars.freestand_trace(20,1,2000)
            -- script
            anti_aim()
            double_tap()
        end)
        
        client.set_event_callback("paint", function()
            -- script
            visuals()
        end)
        
        client.set_event_callback("paint_ui", function()
            -- helpers
            handle_menu(false)
        end)
        
        client.set_event_callback("bullet_impact", function(e)
            -- helpers
            vars.miss_info(e)
        end)
        
        client.set_event_callback("aim_fire", function()
            vars.bf_side = vars.bf_side * -1
            vars.bf_timer = globals.curtime() + 3
        end)

client.set_event_callback("player_death", function(event)
  --  if ui.get(misc_override) == false or ui.get(master_switch) == false then return end



    if entity.get_local_player() == client.userid_to_entindex(event.userid) then
        -- on-miss.
        vars.info = {}
        vars.miss = globals.curtime()

        -- fractions.
        vars.lby_fraction = nil
        vars.radius_fraction = nil

        -- freestanding.
        vars.left_data = {}
        vars.right_data = {}
        vars.hit_side = nil

        vars.fs_data = {}
        vars.fs_side = nil

        -- vulnerability.
        vars.vulnerable = false
    end

end)


-------------cus aa
local function get_distance(x1, y1, z1, x2, y2, z2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2 + (z2 - z1)^2)
end
local function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    if num >= 0 then return math.floor(num * mult + 0.5) / mult
    else return math.ceil(num * mult - 0.5) / mult end
  end
  
  local hsv_to_rgb = function(b,c,d,e)local f,g,h;local i=math.floor(b*6)local j=b*6-i;local k=d*(1-c)local l=d*(1-j*c)local m=d*(1-(1-j)*c)i=i%6;if i==0 then f,g,h=d,m,k elseif i==1 then f,g,h=l,d,k elseif i==2 then f,g,h=k,d,m elseif i==3 then f,g,h=k,l,d elseif i==4 then f,g,h=m,k,d elseif i==5 then f,g,h=d,k,l end;return f*255,g*255,h*255,e*255 end
local function get_bar_color()
    local r, g, b, a = 255,255,255,255
    local rgb_split_ratio = 100 / 100
    local h = globals.realtime() * 30 / 100 or 60 / 1000
    r, g, b = hsv_to_rgb(h, 1, 1, 1)
    r, g, b = r * rgb_split_ratio,g * rgb_split_ratio,b * rgb_split_ratio
    return r, g, b, a
  end
  
  local function gradient_text(r1, g1, b1, a1, r2, g2, b2, a2, text)
      local output = ''
      local len = #text-1
      local rinc = (r2 - r1) / len
      local ginc = (g2 - g1) / len
      local binc = (b2 - b1) / len
      local ainc = (a2 - a1) / len
      for i=1, len+1 do
          output = output .. ('\a%02x%02x%02x%02x%s'):format(r1, g1, b1, a1, text:sub(i, i))
          r1 = r1 + rinc
          g1 = g1 + ginc
          b1 = b1 + binc
          a1 = a1 + ainc
      end
  
      return output
  end
  local x,y = client.screen_size()
local function on_paint()
    local r,g,b,a = get_bar_color()
    local realtime = globals.realtime() % 3
    local alpha = math.floor(math.sin(realtime * 4) * (255 / 2 - 1) + 255 / 2)
    local text = gradient_text(g,b,r,a,r,g,b,a,"Smile-Yaw")
    local text1 = gradient_text(g,b,r,a,r,g,b,a,"Smile")
      local _player = entity.get_local_player()
      if _player == nil then return end
      local _weapon = entity.get_player_weapon(_player)
      if _weapon == nil then return end
      local _ent = native_GetClientEntity(_weapon)
      if _ent == nil then return end
      local _inaccuracy = native_GetInaccuracy(_ent)
      if _inaccuracy == nil then return end
      if manual_state == 1 then
		renderer.text(x/2-50-_inaccuracy*100, y/2-2, _inaccuracy*400, 255-_inaccuracy*300, 60, 200, "bc+", 0, "<")
		renderer.text(x/2+46+_inaccuracy*100, y/2-2, 255, 255, 255, 200, "bc+", 0, ">")
	elseif manual_state == 2 then
		renderer.text(x/2-50-_inaccuracy*100, y/2-2,255, 255, 255, 200, "bc+", 0, "<")
		renderer.text(x/2+46+_inaccuracy*100, y/2-2, _inaccuracy*400, 255-_inaccuracy*300, 60, 200, "bc+", 0, ">")
	else
		renderer.text(x/2-50-_inaccuracy*100, y/2-2,255, 255, 255, 200, "bc+", 0, "<")
		renderer.text(x/2+46+_inaccuracy*100, y/2-2, 255, 255, 255, 200, "bc+", 0, ">")
	end
      local screen = {client.screen_size()}
      local center = {screen[1]/2, screen[2]/2}
      renderer.text(screen[1] - 30, 0, 50, 255, 50, 255, nil, 0, text1 )
      renderer.text(x/2+-10, y/2+15, 255, 255, 255, 255, "C-", 0, text)
  
      local num_round = function(x, n)
          n = math.pow(10, n or 0); x = x * n
          x = x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
          return x / n
      end
      local me = entity.get_local_player()
      local body_pos = entity.get_prop(me, "m_flPoseParameter", 11) or 0
      local body_yaw = math.max(-60, math.min(60, num_round(body_pos*120-60+0.5, 1)))
      local x,y,z = entity.get_prop(me, "m_vecAbsOrigin")
      local x1, y1 = renderer.world_to_screen(x , y , z)
      local w,h = client.screen_size()
      local window_x,window_y = w/2,h/2
      local abs_yaw = math.floor(math.abs(body_yaw))
      local alpha = 1 + math.sin(math.abs(-math.pi + (globals.realtime() * (1 / 0.5)) % (math.pi * 2))) * 219
     -- renderer.text(x/2+30, y/2+20, 255, 255, 255, alpha, "-", 0, "")
      if num<=60 then
          num = num+1
          if num == 60 then
              num = 20;
          end
      end
  end
  client.set_event_callback('paint_ui',on_paint) 
-----------------------fl
local list = { "Normal", "In air", "On peek" }
local alpha = 0
local enabled = ui.new_checkbox("AA", "Fake lag", "Fake lag ind")
local condition = ui.new_multiselect("AA", "Fake lag", "\n lagcomp_shifter_condition", list)

local amount = ui.reference("AA", "Fake lag", "Amount")
local variance = ui.reference("AA", "Fake lag", "Variance")

local phases = {
    { amount = "Maximum", variance = 0 },
    { amount = "Dynamic", variance = 0 },
    { amount = "Maximum", variance = 36 },
    { amount = "Dynamic", variance = 0 },
    { amount = "Maximum", variance = 68 },
    { amount = "Dynamic", variance = 0 },
    { amount = "Fluctuate", variance = 0 },
    -- { amount = "Fluctuate", variance = 100 },
}

local data = {
    current_phase = 0,
    prev_choked = 14,
}

local cache = { }
local ui_get, ui_set = ui.get, ui.set
local entity_is_alive = entity.is_alive
local renderer_measure_text = renderer.measure_text
local renderer_indicator = renderer.indicator
local renderer_rectangle = renderer.rectangle

local bit_band = bit.band
local math_sqrt = math.sqrt
local entity_get_prop = entity.get_prop
local entity_get_local_player = entity.get_local_player

local cache_process = function(name, condition, should_call, VAR)
    local hotkey_modes = {
        [0] = "always on",
        [1] = "on hotkey",
        [2] = "toggle",
        [3] = "off hotkey"
    }
	
    local _type = type(_cond)
    local finder = mode ~= nil and mode or (_type == "boolean" and tostring(_cond) or _cond)
    cache[name] = cache[name] ~= nil and cache[name] or finder
        if cache[name] ~= nil then
            local _cache = cache[name]
            
            if _type == "boolean" then
                if _cache == "true" then _cache = true end
                if _cache == "false" then _cache = false end
            end

            ui_set(condition, mode ~= nil and hotkey_modes[_cache] or _cache)
            cache[name] = nil
        end
    end

local function compare(tab, val)
    for i = 1, #tab do
        if tab[i] == val then
            return true
        end
    end
    
    return false
end

client.set_event_callback("setup_command", function(c)
    local get_prop = function(...) 
        return entity_get_prop(entity_get_local_player(), ...)
    end

    local conditions = ui_get(condition)

    local x, y, z = get_prop("m_vecVelocity")
    local in_air = c.in_jump == 1 or bit_band(get_prop("m_fFlags"), 1) ~= 1

    local is_active = ui_get(enabled) and (
        (compare(conditions, list[1]) and not in_air and math.sqrt(x^2 + y^2) > 1) or 
        (compare(conditions, list[2]) and in_air)
    )

    if is_active then
        if alpha < 248 then
            alpha = alpha + 8
        end
    else
        if alpha > 7 then
            alpha = alpha - 8
        end
    end

    if c.chokedcommands < data.prev_choked then
        data.current_phase = data.current_phase + 1

        if data.current_phase > #phases then
            data.current_phase = 1
        end
    end

    -- cache_process("onshot_fakelag", onshot_fakelag, is_active, true)
    cache_process("custom_triggers", custom_triggers, is_active, false)
    cache_process("amount", amount, is_active, phases[data.current_phase].amount)
    cache_process("variance", variance, is_active, phases[data.current_phase].variance)

    data.prev_choked = c.chokedcommands
end)

client.set_event_callback("paint", function(c)
    local me = entity_get_local_player()

    if not ui_get(enabled) or not entity_is_alive(me) then
        return
    end

    if alpha > 0 then
    local text = "FL"
	local width, height = renderer_measure_text("+", text)
	local y = renderer_indicator(255, 255, 255, alpha > 150 and 150 or alpha, text)

	renderer_rectangle(19, y + 30, width, 0, 0, 0, 0, alpha > 150 and 150 or alpha)
	renderer_rectangle(20, y + 31, ((width - 2) / #phases) * data.current_phase, 3, 255, 255, 255, alpha)
    end
end)

local _callback = function(self)
    ui.set_visible(condition, ui_get(self))
end

ui.set_callback(enabled, _callback)
_callback(enabled)





--------------------menu hide
pitch = ui.reference("AA", "Anti-aimbot angles", "Pitch")
enable_anti  = ui.reference("aa", "anti-aimbot angles", "Enabled")
yaw, yaw_slider = ui.reference("AA", "Anti-aimbot angles", "Yaw")
yawbase = ui.reference("AA", "Anti-aimbot angles", "Yaw base")
yawjitter, yawjitter_slider = ui.reference("AA", "Anti-aimbot angles", "Yaw jitter")
bodyyaw, bodyyaw_slider = ui.reference("AA", "Anti-aimbot angles", "Body yaw")
freebody = ui.reference("aa", "anti-aimbot angles", "Freestanding body yaw")
free,free_key  = ui.reference("aa", "anti-aimbot angles", "Freestanding")
edge = ui.reference("aa", "anti-aimbot angles", "Edge yaw")
limit = ui.reference("AA", "Anti-aimbot angles", "Fake Yaw Limit")
bodyaim = ui.reference("rage","other","force body aim")
safepoint = ui.reference("rage","aimbot","force safe point")
slidewalk = ui.reference("AA", "other", "leg movement")



local function main()

	--	client_set_event_callback("player_death", function(e)
		--	if not ui_get(enable) then return end
			
		--	brute.death(e)
		--	end) 
		--	client_set_event_callback("round_start", function()
			--	if not ui_get(enable) then return end
				
			--	dt_latency = client.latency() * 1000
			--	brute.reset()
			--	end)
				 
				client_set_event_callback("client_disconnect", function()
				if not ui_get(master_switch) then return end
				
				brute.reset()
				end)
				
				client_set_event_callback("game_newmap", function()
				if not ui_get(master_switch) then return end
				
				brute.reset()
				end)
				
				client_set_event_callback("cs_game_disconnected", function()
				if not ui_get(master_switch) then return end
				
				brute.reset()
				end)
				
			end
	
	main()
	function set_visible_on_elements()
	ui.set_visible (pitch, not ui.get(master_switch))
	ui.set_visible(yaw, not ui.get(master_switch))
	ui.set_visible(yaw_slider, not ui.get(master_switch))
	ui.set_visible(yawbase, not ui.get(master_switch))
	ui.set_visible (yawjitter_slider, not ui.get(master_switch))
	ui.set_visible(bodyyaw, not ui.get(master_switch))
	ui.set_visible(bodyyaw_slider, not ui.get(master_switch))
	ui.set_visible(limit, not ui.get(master_switch))
	ui.set_visible(yawjitter, not ui.get(master_switch))
	ui.set_visible(freebody, not ui.get(master_switch))
	ui.set_visible(free, not ui.get(master_switch))
	ui.set_visible(edge, not ui.get(master_switch))
	ui.set_visible(enable_anti, not ui.get(master_switch))
	
	
	
	end 
	
	
	client.set_event_callback("paint_menu", set_visible_on_elements)
	client.set_event_callback("paint", set_visible_on_elements) 







    ----------------------------------------------------
    local ind = ui.new_checkbox("LUA","B","Gofor1t Anti-Aim Indicator")
local arrows_color = ui.new_color_picker('LUA', 'B', 'Gofor1t Anti-Aim Indicator Color', 255, 255, 255, 255)
local arrows_color2 = ui.new_color_picker('LUA', 'B', 'Gofor1t Anti-Aim Indicator Color', 255, 255, 255, 255)
local label1 = ui.new_label("LUA", "B", "Line Color")
local label2 = ui.new_label("LUA", "B", "Text Color")
local textcolor = ui.new_color_picker('LUA', 'B', 'Gofor1t Anti-Aim Indicator Color', 255, 255, 255, 255)
local label3 = ui.new_label("LUA", "B", "° Color")
local label4 = ui.new_label("LUA", "B", "Manual Color")
local sbcolor = ui.new_color_picker('LUA', 'B', 'Gofor1t Anti-Aim Indicator Color', 255, 255, 255, 255)
local manualcolor = ui.new_color_picker('LUA', 'B', 'Gofor1t Anti-Aim Indicator Color', 255, 255, 255, 255)
local yawmode,yawslider = ui.reference("AA","Anti-aimbot angles","Yaw")
local max_alpha = ui.new_slider("LUA", "B", "Maximum shadow alpha", 25, 255, 175, true)
local threshold = ui.new_slider("LUA", "B", "Alpha threshold", 1, 99, 25, false)
local speed = ui.new_slider("LUA", "B", "Alpha speed", 1, 99, 1, true, "%")
local act = 1
local alpha = 0
	
client.set_event_callback("paint", function()

	ui.set_visible(max_alpha,ui.get(ind))
	ui.set_visible(threshold,ui.get(ind))
	ui.set_visible(speed,ui.get(ind))


	
	local r5,g5,b5,a5 = ui.get(manualcolor)

	local max_alpha = ui.get(max_alpha)
    local threshold = ui.get(threshold)

    local factor = 255 / ((101 - ui.get(speed)) / 100) * globals.frametime()

    if alpha > max_alpha + threshold then act = -factor end
    if alpha < -threshold then act = factor end

    alpha = alpha + act

    local ret = alpha

    if ret < 0 then ret = 0 end
    if ret > max_alpha or ret > 255 then
        ret = max_alpha
    end
	
	ui.set(manualcolor,r5,g5,b5,ret)
	


local body_yaw = entity.get_prop(entity.get_local_player(), 'm_flPoseParameter', 11)
	if not body_yaw then return end
	
	local w, h = client.screen_size()
    local x, y = w / 2, h / 2





if ui.get(yawslider) > 50 then
	renderer.text(x +75, y, r5, g5, b5, a5, "c+", 0 , ">")
end

if ui.get(yawslider) < -50 then
	renderer.text(x -75, y, r5, g5, b5, a5, "c+", 0 , ">")
end 

ui.set_visible(arrows_color,ui.get(ind))
ui.set_visible(arrows_color2,ui.get(ind))
ui.set_visible(label1,ui.get(ind))
ui.set_visible(label2,ui.get(ind))
ui.set_visible(label3,ui.get(ind))
ui.set_visible(label4,ui.get(ind))
ui.set_visible(textcolor,ui.get(ind))
ui.set_visible(sbcolor,ui.get(ind))
ui.set_visible(manualcolor,ui.get(ind))

if ui.get(ind) then
        body_yaw = body_yaw * 120 - 60
		
        local first_r, first_g, first_b, first_a = 255, 0, 127, 0
        local second_r, second_g, second_b, second_a = 255, 0, 127, 255
		local r,g,b,a =  ui.get(arrows_color) 
		local r2,g2,b2,a2 = ui.get(arrows_color2)
		local r3,g3,b3,a3 = ui.get(textcolor)
		local r4,g4,b4,a4 = ui.get(sbcolor)
    
        local line_width = math.abs(math.floor(body_yaw + 0.5))
    
        renderer.text(x, y + 30, r4, g4, b4, a4, 'c', 0, string.format('%s°', line_width))
    
        renderer.gradient(x - line_width, y + 40, line_width, 3, r, g, b, 0, r2, g2, b2, a2, true)
        renderer.gradient(x, y + 40, line_width, 3, r2, g2, b2, a2, r, g, b, 0, true)
		
		
end
end)