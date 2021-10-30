--[[
    Module 0, this is the actual core of our lua with all of the features & menu items.
]]

--local variables for API functions. Generated using https://github.com/sapphyrus/gamesense-lua/blob/master/generate_api.lua
local client_userid_to_entindex, client_set_event_callback, client_screen_size, client_trace_bullet, client_unset_event_callback, client_color_log, client_reload_active_scripts, client_scale_damage, client_get_cvar, client_camera_position, client_create_interface, client_random_int, client_latency, client_set_clan_tag, client_find_signature, client_log, client_timestamp, client_delay_call, client_trace_line, client_register_esp_flag, client_get_model_name, client_system_time, client_visible, client_exec, client_key_state, client_set_cvar, client_unix_time, client_error_log, client_draw_debug_text, client_update_player_list, client_camera_angles, client_eye_position, client_draw_hitboxes, client_random_float = client.userid_to_entindex, client.set_event_callback, client.screen_size, client.trace_bullet, client.unset_event_callback, client.color_log, client.reload_active_scripts, client.scale_damage, client.get_cvar, client.camera_position, client.create_interface, client.random_int, client.latency, client.set_clan_tag, client.find_signature, client.log, client.timestamp, client.delay_call, client.trace_line, client.register_esp_flag, client.get_model_name, client.system_time, client.visible, client.exec, client.key_state, client.set_cvar, client.unix_time, client.error_log, client.draw_debug_text, client.update_player_list, client.camera_angles, client.eye_position, client.draw_hitboxes, client.random_float
local entity_get_local_player, entity_is_enemy, entity_get_bounding_box, entity_get_all, entity_set_prop, entity_is_alive, entity_get_steam64, entity_get_classname, entity_get_player_resource, entity_get_esp_data, entity_is_dormant, entity_get_player_name, entity_get_game_rules, entity_get_origin, entity_hitbox_position, entity_get_player_weapon, entity_get_players, entity_get_prop = entity.get_local_player, entity.is_enemy, entity.get_bounding_box, entity.get_all, entity.set_prop, entity.is_alive, entity.get_steam64, entity.get_classname, entity.get_player_resource, entity.get_esp_data, entity.is_dormant, entity.get_player_name, entity.get_game_rules, entity.get_origin, entity.hitbox_position, entity.get_player_weapon, entity.get_players, entity.get_prop
local globals_realtime, globals_absoluteframetime, globals_chokedcommands, globals_oldcommandack, globals_tickcount, globals_commandack, globals_lastoutgoingcommand, globals_curtime, globals_mapname, globals_tickinterval, globals_framecount, globals_frametime, globals_maxplayers = globals.realtime, globals.absoluteframetime, globals.chokedcommands, globals.oldcommandack, globals.tickcount, globals.commandack, globals.lastoutgoingcommand, globals.curtime, globals.mapname, globals.tickinterval, globals.framecount, globals.frametime, globals.maxplayers
local ui_new_slider, ui_new_combobox, ui_reference, ui_set_visible, ui_new_textbox, ui_new_color_picker, ui_new_checkbox, ui_mouse_position, ui_new_listbox, ui_new_multiselect, ui_is_menu_open, ui_new_hotkey, ui_set, ui_update, ui_menu_size, ui_name, ui_menu_position, ui_set_callback, ui_new_button, ui_new_label, ui_new_string, ui_get = ui.new_slider, ui.new_combobox, ui.reference, ui.set_visible, ui.new_textbox, ui.new_color_picker, ui.new_checkbox, ui.mouse_position, ui.new_listbox, ui.new_multiselect, ui.is_menu_open, ui.new_hotkey, ui.set, ui.update, ui.menu_size, ui.name, ui.menu_position, ui.set_callback, ui.new_button, ui.new_label, ui.new_string, ui.get
--end of local variables

-- LUA library requirements
local http = require "gamesense/http"
local images = require "gamesense/images"

--[[
    Menu items
]]
ui_new_label("LUA", "B", "-----------QQ932084933-----------")
local master_switch = ui_new_checkbox("LUA", "B", "Master switch")
ui_new_label("LUA", "B", "Primary gradient color")
local primary_gradient = ui_new_color_picker("LUA", "B", "Primary gradient", 255, 166, 180, 255)
ui_new_label("LUA", "B", "Secondary gradient color")
local secondary_gradient = ui_new_color_picker("LUA", "B", "Secondary gradient", 52, 52, 52, 0)
local override_antiaim = ui_new_checkbox("LUA", "B", "Override anti-aim")
local reset_stages = ui_new_hotkey("LUA", "B", "Reset bruteforce stages")
local adaptive_fs = ui_new_checkbox("LUA", "B", "Adaptive freestanding")
local manual_aa = ui_new_checkbox("LUA", "B", "Manual anti-aim")
local manual_aa_clr = ui_new_color_picker("LUA", "B", "Manual anti-aim", 255, 166, 180, 255)
local manual_left = ui_new_hotkey("LUA", "B", "Left")
local manual_right = ui_new_hotkey("LUA", "B", "Right")
local manual_state = ui_new_slider("LUA", "B", "Manual direction", 0, 2, 0)
local faster_dt = ui_new_checkbox("LUA", "B", "Faster doubletap")
local adaptive_dt = ui_new_checkbox("LUA", "B", "Latency based doubletap")
local dt_ind = ui_new_checkbox("LUA", "B", "Doubletap indicator")
local dt_ind_clr = ui_new_color_picker("LUA", "B", "Doubletap indicator color", 219, 171, 114, 255)
ui_new_label("LUA", "B", "Secondary doubletap color")
local dt_ind_clr_alt = ui_new_color_picker("LUA", "B", "Doubletap indicator color alt", 250, 219, 162, 255)
local predict_dt = ui_new_checkbox("LUA", "B", "Predict doubletap damage")
local optimize_predict_dt = ui_new_checkbox("LUA", "B", "Optimize predict doubletap")
local adaptive_fakelag = ui_new_checkbox("LUA", "B", "Fakelag")
local side_arrows = ui_new_checkbox("LUA", "B", "Side arrows")
local side_arrows_clr = ui_new_color_picker("LUA", "B", "Side arrows color", 255, 166, 180, 255)
local indicators = ui_new_multiselect("LUA", "B", "Indicator list", "Yaw status", "Doubletap", "Fakeduck", "Safepoint", "Hideshots", "Force body aim")
local hide_default_inds = ui_new_checkbox("LUA", "B", "Hide default indicators")
ui_new_label("LUA", "B", "ZHW-YAW color")
local Godx_yaw_clr = ui_new_color_picker("LUA", "B", "ZHW yaw color", 255, 166, 180, 255)
ui_new_button("LUA", "B", "Import recommended settings", function()
    ui_set(master_switch, true)
    ui_set(override_antiaim, true)
    ui_set(adaptive_fs, true)
    ui_set(faster_dt, true)
    ui_set(predict_dt, true)
    ui_set(optimize_predict_dt, false)
    ui_set(adaptive_fakelag, true)
    ui_set(legit_aa_use, true)
end)
ui_new_label("LUA", "B", "-----------QQ932084933-----------")

--[[
    Menu references
]]
local ref_md = ui_reference("RAGE", "Aimbot", "Minimum damage")
local ref_sp_key = ui_reference("RAGE", "Aimbot", "Force safe point")
local ref_baim_key = ui_reference("RAGE", "Other", "Force body aim")
local ref_fd = ui_reference("RAGE", "Other", "Duck peek assist")
local ref_dt, ref_dt_key = ui_reference("RAGE", "Other", "Double tap")
local ref_dt_mode = ui_reference("RAGE", "Other", "Double tap mode")
local ref_dt_hc = ui_reference("RAGE", "Other", "Double tap hit chance")
local ref_dt_fl = ui_reference("RAGE", "Other", "Double tap fake lag limit")
local ref_pitch = ui_reference("AA", "Anti-aimbot angles", "Pitch")
local ref_yaw, ref_yawadd = ui_reference("AA", "Anti-aimbot angles", "Yaw")
local ref_yaw_base = ui_reference("AA", "Anti-aimbot angles", "Yaw base")
local ref_yawj, ref_yawjadd = ui_reference("AA", "Anti-aimbot angles", "Yaw jitter")
local ref_bodyyaw, ref_bodyyawadd = ui_reference("AA", "Anti-aimbot angles", "Body yaw")
local ref_fs_bodyyaw = ui_reference("AA", "Anti-aimbot angles", "Freestanding body yaw")
--local ref_lby_target = ui_reference("AA", "Anti-aimbot angles", "Lower body yaw target")
local ref_fakelimit = ui_reference("AA", "Anti-aimbot angles", "Fake yaw limit")
local ref_hs, ref_hs_key = ui_reference("AA", "Other", "On shot anti-aim")
local ref_fl = ui_reference("AA", "Fake lag", "Enabled")
local ref_fl_amt = ui_reference("AA", "Fake lag", "Amount")
local ref_fl_var = ui_reference("AA", "Fake lag", "Variance")
local ref_fl_limit = ui_reference("AA", "Fake lag", "Limit")
local ref_maxprocessticks = ui_reference("MISC", "Settings", "sv_maxusrcmdprocessticks")

local username = "Ivan"

local best_enemy = nil

local brute = {
    yaw_status = "default",
    indexed_angle = 0,
    last_miss = 0,
    best_angle = 0,
    misses = { },
    hit_reverse = { }
}

local function includes(table, key)
    for i=1, #table do
        if table[i] == key then
            return true
        end
    end
    return false
end

local wnd = {
    x = database.read("dt_x") or 250,
    y = database.read("dt_y") or 25,
    w = 150,
    dragging = false,
    rx = 0,
}

local function intersect(x, y, w, h, debug) 
    local cx, cy = ui_mouse_position()
    debug = debug or false
    if debug then 
        renderer.rectangle(x, y, w, h, 255, 0, 0, 50)
    end
    return cx >= x and cx <= x + w and cy >= y and cy <= y + h
end

local function normalize_yaw(yaw)
	while yaw > 180 do yaw = yaw - 360 end
	while yaw < -180 do yaw = yaw + 360 end
	return yaw
end

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

local function ang_on_screen(x, y)
    if x == 0 and y == 0 then return 0 end

    return math.deg(math.atan2(y, x))
end

local vec_3 = function(_x, _y, _z) 
	return { x = _x or 0, y = _y or 0, z = _z or 0 } 
end

local function angle_vector(angle_x, angle_y)
	local sy = math.sin(math.rad(angle_y))
	local cy = math.cos(math.rad(angle_y))
	local sp = math.sin(math.rad(angle_x))
	local cp = math.cos(math.rad(angle_x))
	return cp * cy, cp * sy, -sp
end

local function get_damage(me, enemy, x, y,z)
	local ex = { }
	local ey = { }
	local ez = { }
	ex[0], ey[0], ez[0] = entity_hitbox_position(enemy, 1)
	ex[1], ey[1], ez[1] = ex[0] + 40, ey[0], ez[0]
	ex[2], ey[2], ez[2] = ex[0], ey[0] + 40, ez[0]
	ex[3], ey[3], ez[3] = ex[0] - 40, ey[0], ez[0]
	ex[4], ey[4], ez[4] = ex[0], ey[0] - 40, ez[0]
	ex[5], ey[5], ez[5] = ex[0], ey[0], ez[0] + 40
	ex[6], ey[6], ez[6] = ex[0], ey[0], ez[0] - 40
	local bestdamage = 0
	local bent = nil
	for i=0, 6 do
		local ent, damage = client_trace_bullet(enemy, ex[i], ey[i], ez[i], x, y, z)
		if damage > bestdamage then
			bent = ent
			bestdamage = damage
		end
	end
	return bent == nil and client_scale_damage(me, 1, bestdamage) or bestdamage
end

local function is_auto_vis(local_player,lx,ly,lz,px,py,pz)
	entindex,dmg = client_trace_bullet(local_player,lx,ly,lz,px,py,pz)
	if entindex == nil then
		return false
	end
	if entindex == local_player then
		return false
	end
	if not entity_is_enemy(entindex) then
		return false
	end
		if dmg >  ref_md then
			return true
		else
			return false
		end
end

local function trace_positions(px,py,pz,px1,py1,pz1,px2,py2,pz2,lx2,ly2,lz2)
	if is_auto_vis(local_player,lx2,ly2,lz2,px,py,pz) then
		return true
	end
	if is_auto_vis(local_player,lx2,ly2,lz2,px1,py1,pz1) then
		return true
	end
	if is_auto_vis(local_player,lx2,ly2,lz2,px2,py2,pz2) then
		return true
	end
	return false
end

local function extrapolate_position(xpos,ypos,zpos,ticks,ent)
	x,y,z = entity_get_prop(ent, "m_vecVelocity")
	for i=0, ticks do
		xpos =  xpos + (x*globals_tickinterval())
		ypos =  ypos + (y*globals_tickinterval())
		zpos =  zpos + (z*globals_tickinterval())
	end
	return xpos,ypos,zpos
end

local function get_best_enemy()
    -- We store the best target in a global variable so we don't have to re run the calculations every time we want to find the best target.
    best_enemy = nil

    local enemies = entity_get_players(true)
    local best_fov = 180

    local lx, ly, lz = client_eye_position()
    local view_x, view_y, roll = client_camera_angles()
    
    for i=1, #enemies do
        local cur_x, cur_y, cur_z = entity_get_prop(enemies[i], "m_vecOrigin")
        local cur_fov = math.abs(normalize_yaw(ang_on_screen(lx - cur_x, ly - cur_y) - view_y + 180))
        if cur_fov < best_fov then
			best_fov = cur_fov
			best_enemy = enemies[i]
		end
    end
end

local function get_best_angle()
    -- Since we run this from run_command no need to check if we are alive or anything.
    local me = entity_get_local_player()

    brute.best_angle = 0

    if not ui_get(override_antiaim) then return end

    if best_enemy == nil then return end

    local lx, ly, lz = client_eye_position()
    local view_x, view_y, roll = client_camera_angles()
    
    local e_x, e_y, e_z = entity_hitbox_position(best_enemy, 0)

    local yaw = calc_angle(lx, ly, e_x, e_y)
    local rdir_x, rdir_y, rdir_z = angle_vector(0, (yaw + 90))
	local rend_x = lx + rdir_x * 10
    local rend_y = ly + rdir_y * 10
            
    local ldir_x, ldir_y, ldir_z = angle_vector(0, (yaw - 90))
	local lend_x = lx + ldir_x * 10
    local lend_y = ly + ldir_y * 10
            
	local r2dir_x, r2dir_y, r2dir_z = angle_vector(0, (yaw + 90))
	local r2end_x = lx + r2dir_x * 100
	local r2end_y = ly + r2dir_y * 100

	local l2dir_x, l2dir_y, l2dir_z = angle_vector(0, (yaw - 90))
	local l2end_x = lx + l2dir_x * 100
    local l2end_y = ly + l2dir_y * 100      
            
	local ldamage = get_damage(me, best_enemy, rend_x, rend_y, lz)
	local rdamage = get_damage(me, best_enemy, lend_x, lend_y, lz)

	local l2damage = get_damage(me, best_enemy, r2end_x, r2end_y, lz)
	local r2damage = get_damage(me, best_enemy, l2end_x, l2end_y, lz)

    if l2damage > r2damage or ldamage > rdamage then
        if ui_get(adaptive_fs) then
            brute.best_angle = (brute.hit_reverse[best_enemy] == nil and 1 or 2)
        else
            brute.best_angle = 1
        end
	elseif r2damage > l2damage or rdamage > ldamage then
        if ui_get(adaptive_fs) then
            brute.best_angle = (brute.hit_reverse[best_enemy] == nil and 2 or 1)
        else
            brute.best_angle = 2
        end
	end
end

local function doubletap_charged()
    -- Make sure we have doubletap enabled, are holding our doubletap key & we aren't fakeducking.
    if not ui_get(ref_dt) or not ui_get(ref_dt_key) or ui_get(ref_fd) then return false end

    -- Get our local player.
    local me = entity_get_local_player()

    -- Sanity checks on local player (since paint & a few other events run even when dead).
    if me == nil or not entity_is_alive(me) then return false end

    -- Get our local players weapon.
    local weapon = entity_get_prop(me, "m_hActiveWeapon")

    -- Make sure that it is valid.
    if weapon == nil then return false end

    -- Basic definitions used to calculate if we have recently shot or swapped weapons.
    local next_attack = entity_get_prop(me, "m_flNextAttack") + 0.25
    local next_primary_attack = entity_get_prop(weapon, "m_flNextPrimaryAttack") + 0.5

    -- Make sure both values are valid.
    if next_attack == nil or next_primary_attack == nil then return false end

    -- Return if both are under 0 meaning our doubletap is charged / we can fire (you can also use these values as a 2nd return parameter to get the charge %).
    return next_attack - globals_curtime() < 0 and next_primary_attack - globals_curtime() < 0
end

local nonweapons_c = 
{
	"CKnife",
	"CHEGrenade",
    "CMolotovGrenade",
    "CIncendiaryGrenade",
	"CFlashbang",
	"CDecoyGrenade",
	"CSmokeGrenade",
    "CWeaponTaser",
    "CC4"
}

local function dt_indicator()
    if not ui_get(dt_ind) then return end

    -- Return if we aren't holding our doubletap key
    if not ui_get(ref_dt_key) or not ui_get(ref_dt) then return end

    local me = entity_get_local_player()

    -- The paint event (where we are calling this) gets triggered even while the localplayer is dead, so it's nice to have this check.
    if me == nil or not entity_is_alive(me) then return end

    -- Get our weapon index (stored in a variable for later use)
    local weapon_idx = entity_get_player_weapon(me)
    -- Get our weapons item definition index.
    local weapon = entity_get_prop(weapon_idx, "m_iItemDefinitionIndex")

    -- Return if our weapon does not exist.
    if weapon == nil then return end

    -- Get our weapon name for later use relating to if we are using an auto or not. (makes the code alot more readable)
    local weapon_name = entity_get_classname(weapon_idx)
    -- Get our current weapons icon.
    local weapon_icon = images.get_weapon_icon(weapon)
    -- Get a bullet icon.
    local bullet_icon = images.get_panorama_image("icons/ui/bullet.svg")

    -- Define our current cursor position to check if the user is attempting to drag the widget.
    local cx, cy = ui_mouse_position()

    local left_click = client_key_state(0x01)

    -- This is where our drag handling is done (credits: 'sl-001')
    if ui_is_menu_open() then 
        if wnd.dragging and not left_click then
            wnd.dragging = false
        end
    
        if wnd.dragging and left_click then
            wnd.x = cx - wnd.drag_x
            wnd.y = cy - wnd.drag_y
        end
    
        if intersect(wnd.x, wnd.y, wnd.w, 25) and left_click then 
            wnd.dragging = true
            wnd.drag_x = cx - wnd.x
            wnd.drag_y = cy - wnd.y
        end
    end

    -- Get our weapon & bullet width to dynamically make it smaller/larger without using ghetto hardcoded values when drawing.
    local weapon_w, weapon_h = weapon_icon:measure()
    local bullet_w, bullet_h = bullet_icon:measure()

    -- Get our colors for the gradient bar.
    local dt_r, dt_g, dt_b, dt_a = ui_get(dt_ind_clr)
    local dta_r, dta_g, dta_b, dta_a = ui_get(dt_ind_clr_alt)

    -- Draw our gradient bar which is displayed above the transparent black rect & weapon icon (we draw it twice so that it's multi directional)
    renderer.gradient(wnd.x, wnd.y, wnd.w / 2, 2, dt_r, dt_g, dt_b, dt_a, dta_r, dta_g, dta_b, dta_a, true)
    renderer.gradient(wnd.x + wnd.w / 2, wnd.y, wnd.w / 2, 2, dta_r, dta_g, dta_b, dta_a, dt_r, dt_g, dt_b, dt_a, true)

    -- Our transparent black rect that we will display the text ontop of.
    renderer.rectangle(wnd.x, wnd.y + 2, wnd.w, 16, 0, 0, 0, 60)

    -- Our text which displays our hitchance & ideal shift amount.
    renderer.text(wnd.x + wnd.w / 2, wnd.y + 9, 255, 255, 255, 255, "c", 0, string.format("DT (Debug) | ticks: 20", ui_get(ref_dt_hc), ui_get(ref_maxprocessticks)))

    -- Draw the localplayers current weapon icon.
    weapon_icon:draw(wnd.x + 5, wnd.y + 20, weapon_w / 2, weapon_h / 2)

    -- Flashing/pulsing alpha to indicate a recharge.
    local alpha = math.floor(math.sin(globals_realtime() * 12) * (255/2-1) + 255/2) or 255

    -- Check if we have a valid weapon out
    for i=1, #nonweapons_c do
        if weapon_name == nonweapons_c[i] then
            -- It's fine to return here since the last part of this function is for the bullet icons anyway.
			return
		end
    end
    
    -- Check if our doubletap is fully charged/ready to shoot.
    if doubletap_charged() then
        -- Display 2 bullet icons next to eachother
        bullet_icon:draw(wnd.x + weapon_w / 2 + 5, wnd.y + 20, bullet_w / 2, bullet_h / 2)
        bullet_icon:draw(wnd.x + weapon_w / 2 + bullet_w / 2 + 5, wnd.y + 20, bullet_w / 2, bullet_h / 2)
    elseif not ui_get(ref_fd) then
        -- Display 2 bullet icons next to eachwither with a flashing alpha.
        bullet_icon:draw(wnd.x + weapon_w / 2 + 5, wnd.y + 20, bullet_w / 2, bullet_h / 2, 255, 255, 255, alpha)
        bullet_icon:draw(wnd.x + weapon_w / 2 + bullet_w / 2 + 5, wnd.y + 20, bullet_w / 2, bullet_h / 2, 255, 255, 255, alpha)
    end
end

local multi_exec = function(func, list)
    if func == nil then
        return
    end
    
    for ref, val in pairs(list) do
        func(ref, val)
    end
end

local compare = function(tab, val)
    for i = 1, #tab do
        if tab[i] == val then
            return true
        end
    end
    
    return false
end

local bind_system = {
    left = false,
    right = false,
}

multi_exec(ui_set_visible, {
    [manual_aa_clr] = false,
    [manual_left] = false,
    [manual_right] = false,
    [manual_state] = false,
})

function bind_system:update()
    ui_set(manual_left, "On hotkey")
    ui_set(manual_right, "On hotkey")

    local m_state = ui_get(manual_state)

    local left_state, right_state = 
        ui_get(manual_left), 
        ui_get(manual_right)

    if  left_state == self.left and 
        right_state == self.right then
        return
    end

    self.left, self.right = 
        left_state, 
        right_state

    if (left_state and m_state == 1) or (right_state and m_state == 2) then
        ui_set(manual_state, 0)
        return
    end

    if left_state and m_state ~= 1 then
        ui_set(manual_state, 1)
    end

    if right_state and m_state ~= 2 then
        ui_set(manual_state, 2)
    end
end

local on_manual_enabled = function(e, menu_call)
    local state = not ui_get(manual_aa)
    multi_exec(ui_set_visible, {
        [manual_aa_clr] = not state,
        [manual_left] = not state,
        [manual_right] = not state,
        [manual_state] = false,
    })
end

ui_set_callback(manual_aa, on_manual_enabled)

local function manual_aa_sc()
    if not ui_get(manual_aa) then
        return
    end

    local direction = ui_get(manual_state)

    local manual_yaw = {
        [0] = 0,
        [1] = -90, [2] = 90
    }

    if direction == 1 or direction == 2 then
        ui_set(ref_yaw_base, "Local view")
    else
        ui_set(ref_yaw_base, "At targets")
    end

    ui_set(ref_yawadd, manual_yaw[direction])
end

local function manual_aa_paint()
    on_manual_enabled(true, true)
    bind_system:update()

    local me = entity_get_local_player()
    
    if not entity_is_alive(me) or not ui_get(manual_aa) then
        return
    end

    local w, h = client_screen_size()
    local r, g, b, a = ui_get(manual_aa_clr)
    local m_state = ui_get(manual_state)
    
    local realtime = globals_realtime() % 3
    local alpha = math.floor(math.sin(realtime * 4) * (a/2-1) + a/2) or a

    if m_state == 1 then renderer.text(w/2 - 40, h / 2 - 1, 0, 0, 0, 125, "+c", 0, "⯇") end
    if m_state == 2 then renderer.text(w/2 + 40, h / 2 - 1, 0, 0, 0, 125, "+c", 0, "⯈") end

    if m_state == 1 then renderer.text(w/2 - 40, h / 2 - 1, r, g, b, alpha, "+c", 0, "⯇") end
    if m_state == 2 then renderer.text(w/2 + 40, h / 2 - 1, r, g, b, alpha, "+c", 0, "⯈") end
end

local function set_anti_aim(type)
    if type == "jitter" then
        ui_set(ref_yaw, "180")
        ui_set(ref_yawadd, 0)
        ui_set(ref_yawj, "Offset")
        ui_set(ref_yawjadd, -10)
        ui_set(ref_bodyyaw, "Jitter")
        ui_set(ref_bodyyawadd, 0)
        ui_set(ref_fs_bodyyaw, false)
   --     ui_set(ref_lby_target, "Eye yaw")
        ui_set(ref_fakelimit, 60)
    elseif type == "left" then
        ui_set(ref_yaw, "180")
        ui_set(ref_yawadd, 0)
        ui_set(ref_yawj, "Off")
        ui_set(ref_yawjadd, 0)
        ui_set(ref_bodyyaw, "Static")
        ui_set(ref_bodyyawadd, 90)
        ui_set(ref_fs_bodyyaw, false)
     --   ui_set(ref_lby_target, "Eye yaw")
        ui_set(ref_fakelimit, 60)
    elseif type == "right" then
        ui_set(ref_yaw, "180")
        ui_set(ref_yawadd, 0)
        ui_set(ref_yawj, "Off")
        ui_set(ref_yawjadd, 0)
        ui_set(ref_bodyyaw, "Static")
        ui_set(ref_bodyyawadd, -90)
        ui_set(ref_fs_bodyyaw, false)
      --  ui_set(ref_lby_target, "Eye yaw")
        ui_set(ref_fakelimit, 60)
    elseif type == "safe" then
        ui_set(ref_yaw, "180")
        ui_set(ref_yawj, "Off")
        ui_set(ref_yawjadd, 0)
        ui_set(ref_bodyyaw, "Static")
        ui_set(ref_bodyyawadd, 90)
        ui_set(ref_fs_bodyyaw, false)
      --  ui_set(ref_lby_target, "Eye yaw")
        ui_set(ref_fakelimit, 23)
    end
end

local function anti_aim()
    brute.yaw_status = "default"

    if not ui_get(override_antiaim) then return end

    if ui_get(reset_stages) then
        brute.misses = { }
        brute.hit_reverse = { }
    end

    if ui_get(manual_aa) and ui_get(manual_state) ~= 0 then
        brute.yaw_status = "safe"
        set_anti_aim("safe")
        return
    end
    
    if brute.best_angle == 0 then
        if best_enemy == nil then
            brute.yaw_status = "jitter"
            brute.indexed_angle = 0
            set_anti_aim("jitter")
        elseif brute.indexed_angle ~= 0 then
            if brute.indexed_angle == 1 then
                if brute.misses[best_enemy] == nil then
                    brute.yaw_status = "indexed"
                    set_anti_aim("left")
                elseif brute.misses[best_enemy] == 1 then
                    brute.yaw_status = "indexed : S"
                    set_anti_aim("right")
                else
                    brute.yaw_status = "indexed : S"
                    set_anti_aim("left")
                end
            else
                if brute.misses[best_enemy] == nil then
                    brute.yaw_status = "indexed"
                    set_anti_aim("right")
                else
                    brute.yaw_status = "indexed : S"
                    set_anti_aim("left")
                end
            end
        end
    elseif brute.best_angle == 1 then
        brute.indexed_angle = 1
        if brute.misses[best_enemy] == nil then
            brute.yaw_status = "left"
            set_anti_aim("left")
        elseif brute.misses[best_enemy] == 1 then
            brute.yaw_status = "right : S"
            set_anti_aim("right")
        else
            brute.yaw_status = "left : S"
            set_anti_aim("left")
        end
    else
        brute.indexed_angle = 2
        if brute.misses[best_enemy] == nil then
            brute.yaw_status = "right"
            set_anti_aim("right")
        else
            brute.yaw_status = "left : S"
            set_anti_aim("left")
        end
    end
end

local function draw()
    if not entity_is_alive(entity_get_local_player()) then return end

    local w, h = client_screen_size()

    local p_r, p_g, p_b, p_a = ui_get(primary_gradient)
    local a_r, a_g, a_b, a_a = ui_get(secondary_gradient)
    local s_r, s_g, s_b, s_a = ui_get(side_arrows_clr)
    local m_r, m_g, m_b, m_a = ui_get(Godx_yaw_clr)

    local desync_strength = math.floor(math.min(58, math.abs(entity_get_prop(entity_get_local_player(), "m_flPoseParameter", 11)*120-60)))

    -- Desync bar
    renderer.gradient(w / 2 - desync_strength, h / 2 + 30, desync_strength, 3, a_r, a_g, a_b, a_a, p_r, p_g, p_b, p_a, true)
    renderer.gradient(w / 2, h / 2 + 30, desync_strength, 3, p_r, p_g, p_b, p_a, a_r, a_g, a_b, a_a, true)

    -- Desync degrees indicator
    renderer.text(w / 2, h / 2 + 20, 255, 255, 255, 255, "c", 0, string.format(" %s°", desync_strength))

    -- Lua name (center screen)
    renderer.text(w / 2, h / 2 + 40, m_r, m_g, m_b, 255, "c", 0, "predict")

    -- Side arrows
    if ui_get(side_arrows) then
        if not ui_get(manual_aa) or ui_get(manual_state) == 0 then
            if brute.best_angle ~= 0 or brute.indexed_angle ~= 0 then
                -- Way easier to just do the body yaw check rather than checking indexed angles and stuff.
                if ui_get(ref_bodyyawadd) == 90 then
                    renderer.text(w / 2 + 40, h / 2, 255, 255, 255, 255, "cb+", 0, ">")
                    renderer.text(w / 2 - 40, h / 2, s_r, s_g, s_b, s_a, "cb+", 0, "<")
                else
                    renderer.text(w / 2 + 40, h / 2, s_r, s_g, s_b, s_a, "cb+", 0, ">")
                    renderer.text(w / 2 - 40, h / 2, 255, 255, 255, 255, "cb+", 0, "<")
                end
            end
        end
    end

    if ui_get(hide_default_inds) then
        for i = 1, 400 do
            renderer.indicator(0, 0, 0, 0, "predict")
        end
    end

    -- Indicators
    local h_index = 0

    if includes(ui_get(indicators), "Yaw status") then
        renderer.text(w / 2, h / 2 + 55 + (h_index * 12), 255, 255, 255, 255, "c", 0, brute.yaw_status)
        h_index = h_index + 1
    end

    if includes(ui_get(indicators), "Doubletap") and ui_get(ref_dt_key) and ui_get(ref_dt) then
        if doubletap_charged() then
            renderer.text(w / 2, h / 2 + 55 + (h_index * 12), 255, 255, 255, 255, "c", 0, string.format("[ready]", ui_get(ref_maxprocessticks) - 2))
        else
            renderer.text(w / 2, h / 2 + 55 + (h_index * 12), 255, 255, 255, 255, "c", 0, " [Storage]")
        end
        h_index = h_index + 1
    end

    if includes(ui_get(indicators), "Fakeduck") and ui_get(ref_fd) then
        local duck_amt = entity_get_prop(entity_get_local_player(), "m_flDuckAmount")
        renderer.text(w / 2, h / 2 + 55 + (h_index * 12), 255, 255, 255, 255 - duck_amt * 155, "c", 0, "duck")
        h_index = h_index + 1
    end

    if includes(ui_get(indicators), "Safepoint") and ui_get(ref_sp_key) then
        renderer.text(w / 2, h / 2 + 55 + (h_index * 12), 255, 255, 255, 255, "c", 0, "safe")
        h_index = h_index + 1
    end

    if includes(ui_get(indicators), "Hideshots") and ui_get(ref_hs) and ui_get(ref_hs_key) then
        renderer.text(w / 2, h / 2 + 55 + (h_index * 12), 255, 255, 255, 255, "c", 0, "hide")
        h_index = h_index + 1
    end

    if includes(ui.get(indicators), "Force body aim") and ui.get(ref_baim_key) then
        renderer.text(w / 2, h / 2 + 55 + (h_index * 12), 255, 255, 255, 255, "c", 0, "baim")
        h_index = h_index + 1
    end
end

brute.impact = function(e)
    if not ui_get(override_antiaim) then return end

    local me = entity_get_local_player()

    -- Since bullet_impact gets triggered even while we're dead having this check is a good idea.
    if not entity_is_alive(me) then return end

    local shooter_id = e.userid
    local shooter = client_userid_to_entindex(shooter_id)

    -- Distance calculations can sometimes bug when the entity is dormant hence the 2nd check.
    if not entity_is_enemy(shooter) or entity_is_dormant(shooter) then return end

    local lx, ly, lz = entity_hitbox_position(me, "head_0")
    
	local ox, oy, oz = entity_get_prop(me, "m_vecOrigin")
    local ex, ey, ez = entity_get_prop(shooter, "m_vecOrigin")

    local dist = ((e.y - ey)*lx - (e.x - ex)*ly + e.x*ey - e.y*ex) / math.sqrt((e.y-ey)^2 + (e.x - ex)^2)
    
    -- 32 is our miss detection radius and the 2nd check is to avoid adding more than 1 miss for a singular bullet (bullet_impact gets called mulitple times per shot).
    if math.abs(dist) <= 32 and globals_curtime() - brute.last_miss > 0.015 then
        brute.last_miss = globals_curtime()
        if brute.misses[shooter] == nil then
            brute.misses[shooter] = 1 
        elseif brute.misses[shooter] >= 2 then
            brute.misses[shooter] = nil
        else
            brute.misses[shooter] = brute.misses[shooter] + 1
        end
    end
end

local dt_latency = 0
local function doubletap()
    if not ui_get(faster_dt) then
        ui_set(ref_maxprocessticks, 16)
        cvar.cl_clock_correction:set_int(1)
        return
    end

    ui_set(ref_dt_fl, 1)
    ui_set(ref_fl_limit, math.min(14, ui_get(ref_fl_limit)))

    if ui_get(ref_fd) or not ui_get(ref_dt_key) then
        ui_set(ref_maxprocessticks, 16)
        cvar.cl_clock_correction:set_int(1)
        ui_set(ref_dt_hc, 0)
    else
        if ui_get(adaptive_dt) then
            if dt_latency <= 20 then
                ui_set(ref_maxprocessticks, 20)
                cvar.cl_clock_correction:set_int(0)
                ui_set(ref_dt_hc, 15)
            elseif dt_latency <= 40 then
                ui_set(ref_maxprocessticks, 20)
                cvar.cl_clock_correction:set_int(1)
                ui_set(ref_dt_hc, 20)
            elseif dt_latency <= 65 then
                ui_set(ref_maxprocessticks, 20)
                cvar.cl_clock_correction:set_int(1)
                ui_set(ref_dt_hc, 10)
            elseif dt_latency <= 95 then
                ui_set(ref_maxprocessticks, 17)
                cvar.cl_clock_correction:set_int(1)
                ui_set(ref_dt_hc, 20)
            else
                ui_set(ref_maxprocessticks, 17)
                cvar.cl_clock_correction:set_int(1)
                ui_set(ref_dt_hc, 15)
            end
        else
            ui_set(ref_maxprocessticks, 18)
            cvar.cl_clock_correction:set_int(0)
            ui_set(ref_dt_hc, 20)
        end
    end
end

local end_choke_cycle = 0
local function fakelag()
    if not ui_get(adaptive_fakelag) then return end

    if best_enemy == nil or ui_get(ref_fd) then
        ui_set(ref_fl_amt, "Dynamic")
        ui_set(ref_fl_limit, 14)
        ui_set(ref_fl_var, 0)
        ui_set(ref_fl, true)
        return
    elseif end_choke_cycle == 1 then
        ui_set(ref_fl_limit, 1)
        ui_set(ref_fl, false)
        end_choke_cycle = 2
        return
    else
        ui_set(ref_fl, true)
    end

    local local_pos = vec_3(client_eye_position())
    local extrap_pos = vec_3(extrapolate_position(local_pos.x, local_pos.y, local_pos.z, 14, entity_get_local_player()))

    local player_pos = vec_3(entity_hitbox_position(best_enemy, 0))
    local player_pos_2 = vec_3(entity_hitbox_position(best_enemy, 4))
    local player_pos_3 = vec_3(entity_hitbox_position(best_enemy, 2))

    if trace_positions(player_pos.x, player_pos.y, player_pos.z, player_pos_2.x, player_pos_2.y, player_pos_2.z, player_pos_3.x, player_pos_3.y, player_pos_3.z, extrap_pos.x, extrap_pos.y, extrap_pos.z) then
        if end_choke_cycle ~= 2 then
            end_choke_cycle = 1
        else
            ui_set(ref_fl_amt, "Maximum")
            ui_set(ref_fl_limit, 14)
            ui_set(ref_fl_var, 0)
        end
    else
        end_choke_cycle = 0

        local x, y = entity_get_prop( entity_get_local_player(), 'm_vecVelocity')
        local speed = x ~= nil and math.floor(math.sqrt( x * x + y * y + 0.5 )) or 0

        ui_set(ref_fl_amt, "Dynamic")
        ui_set(ref_fl_limit, 14)
        ui_set(ref_fl_var, 40)
    end
end

brute.reset = function()
    brute.indexed_angle = 0
    brute.last_miss = 0
    brute.best_angle = 0
    brute.misses = { }
end

local function predict_dt_dmg()
    if not ui_get(predict_dt) then return end

    -- Return if we aren't holding our doubletap key or if doubletap is not enabled.
    if not ui_get(ref_dt_key) or not ui_get(ref_dt) then return end

    -- Get our localplayer, since run_command is not triggered when we're dead no need for sanity checks here.
    local me = entity_get_local_player()

    -- Return if we have no available target.
    if best_enemy == nil or not entity_is_alive(best_enemy) then return end

    -- Get our localplayers weapon, you can use the item definition index for this but the name improves readability.
    local weapon_name = entity_get_classname(entity_get_player_weapon(me))

    -- Return if we aren't using an auto.
    if weapon_name ~= "CWeaponSCAR20" and weapon_name ~= "CWeaponG3SG1" then return end

    -- Get the local players eye position.
    local local_pos = vec_3(entity_hitbox_position(me, 0))

    -- Check if it's nil so we don't run into issues when attempting to extrapolate/calculate damage.
    if local_pos == nil then return end

    -- Get our extrapolated position (4th argument is how many ticks we want to predict)
    local extrapolated_pos = vec_3(extrapolate_position(local_pos.x, local_pos.y, local_pos.z, 24, me))

    -- Get our targets pelvis position.
    local enemy_pos = vec_3(entity_hitbox_position(best_enemy, 2))

    -- Check if either are nil.
    if enemy_pos == nil or extrapolated_pos == nil then return end

    -- Calculate the damage our extrapolated shot will do to our current targets position.
    local hit_ent, hit_dmg = client_trace_bullet(me, extrapolated_pos.x, extrapolated_pos.y, extrapolated_pos.z, enemy_pos.x, enemy_pos.y, enemy_pos.z, (ui_get(optimize_predict_dt) and true or false))

    -- Get our enemies current health.
    local enemy_hp = entity_get_prop(best_enemy, "m_IHealth")

    -- Check if our predicted damage will result in a 1 shot kill to the pelvis.
    if hit_dmg >= enemy_hp then
        -- Force our minimum damage to the enemies health.
        ui_set(ref_md, enemy_hp)
    -- If we can't kill them in 1 shot to the pelvis, check if we can 2 shot them.
    elseif hit_dmg >= enemy_hp / 2 then
        -- Force our minimum damage to half of the enemies health.
        ui_set(ref_md, enemy_hp / 2)
    -- If both checks have failed, try the checks again with unextrapolated positions.
    elseif not ui_get(optimize_predict_dt) then
        -- Calculate the damage for our unextrapolated position.
        local hit_ent2, hit_dmg2 = client_trace_bullet(me, local_pos.x, local_pos.y, local_pos.z, enemy_pos.x, enemy_pos.y, enemy_pos.z)

        -- Re-do our damage checks. (comments above)
        if hit_dmg2 >= enemy_hp then
            ui_set(ref_md, enemy_hp)
        elseif hit_dmg2 >= enemy_hp / 2 then
            ui_set(ref_md, enemy_hp / 2)
        end
    end
end

brute.death = function(e)
    if not ui_get(override_antiaim) then return end
    
    local victim_id = e.userid
    local victim = client_userid_to_entindex(victim_id)

    if victim ~= entity_get_local_player() then return end

    local attacker_id = e.attacker
    local attacker = client_userid_to_entindex(attacker_id)

    if not entity_is_enemy(attacker) then return end

    if not e.headshot then return end

    if brute.misses[attacker] == nil or (globals_curtime() - brute.last_miss < 0.06 and brute.misses[attacker] == 1) then
        if brute.hit_reverse[attacker] == nil then
            brute.hit_reverse[attacker] = true
        else
            brute.hit_reverse[attacker] = nil
        end
    end
end

legit_e_key = ui.new_checkbox("AA", "Anti-aimbot angles", "Legit anti-aim (on E key)")
freestanding_body_yaw = ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw")

client.set_event_callback("setup_command",function(e)
    local weaponn = entity.get_player_weapon()
    if ui.get(legit_e_key) then
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
        ui.set(freestanding_body_yaw, true)
end
end)

local string_meta = getmetatable('')

function string_meta:__index( key )
    local val = string[ key ]
    if ( val ) then
        return val
    elseif ( tonumber( key ) ) then
        return self:sub( key, key )
    end
end

local function main()
    -- Our main function where we do our base authentication and event callbacks.

    client_set_event_callback("paint", function()
        if not ui_get(master_switch) then return end

        draw()
        dt_indicator()
        manual_aa_paint()
    end)

    client_set_event_callback("run_command", function()
        if not ui_get(master_switch) then return end

        get_best_enemy()
        get_best_angle()
        manual_aa_sc()
        anti_aim()
        predict_dt_dmg()
        doubletap()
        fakelag()
    end)


    client_set_event_callback("bullet_impact", function(e)
        if not ui_get(master_switch) then return end

        brute.impact(e)
    end)

    client_set_event_callback("player_death", function(e)
        if not ui_get(master_switch) then return end

        brute.death(e)
    end)

    client_set_event_callback("round_start", function()
        if not ui_get(master_switch) then return end
        
        dt_latency = client.latency() * 1000
        brute.reset()
    end)

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

    client_set_event_callback("shutdown", function()
        ui_set(ref_maxprocessticks, 16)
        cvar.cl_clock_correction:set_int(1)
        database.write("dt_x", wnd.x)
        database.write("dt_y", wnd.y)
    end)
end
main()