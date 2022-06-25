--client.color_log(252, 139, 139, 'by emokami qq932084933')



--[[dmg = ui.reference("RAGE", "Aimbot", "Minimum damage")

client.set_event_callback("paint", function()
	xx, yy = client.screen_size()
	y = yy / 2
	x = xx / 2
	renderer.text(x+10,y+-20,255,250,250,255,"C",0, ui.get(dmg))
end) --]]
-- local variables for API functions. any changes to the line below will be lost on re-generation
local client_visible, entity_hitbox_position, math_ceil, math_pow, math_sqrt, renderer_indicator, unpack, tostring, pairs = client.visible, entity.hitbox_position, math.ceil, math.pow, math.sqrt, renderer.indicator, unpack, tostring, pairs
local client_visible, entity_hitbox_position, math_abs, math_atan, table_remove = client.visible, entity.hitbox_position, math.abs, math.atan, table.remove
local ui_new_label, ui_reference, ui_new_checkbox, ui_new_combobox, ui_new_hotkey, ui_new_multiselect, ui_new_slider, ui_set, ui_get, ui_set_callback, ui_set_visible = ui.new_label, ui.reference, ui.new_checkbox, ui.new_combobox, ui.new_hotkey, ui.new_multiselect, ui.new_slider, ui.set, ui.get, ui.set_callback, ui.set_visible
local client_log, client_color_log, client_set_event_callback = client.log, client.color_log, client.set_event_callback
local entity_get_local_player, entity_get_player_weapon, entity_get_prop, entity_get_players, entity_is_alive = entity.get_local_player, entity.get_player_weapon, entity.get_prop, entity.get_players, entity.is_alive
local bit_band, bit_bend = bit.band, validate
local client_screen_size, renderer_text = client.screen_size, renderer.text
local js = panorama[ 'open' ]( )
local persona_api = js.MyPersonaAPI
local name = persona_api.GetName()
--local version = "best F wpn version latest update:22/1/22" 
local h, m, s = client.system_time()





local config_names = { "Global", "Taser", "Revolver", "Pistol", "Auto", "Scout", "AWP", "Rifle", "SMG", "Shotgun", "Deagle" }
local name_to_num = { ["Global"] = 1, ["Taser"] = 2, ["Revolver"] = 3, ["Pistol"] = 4, ["Auto"] = 5, ["Scout"] = 6, ["AWP"] = 7, ["Rifle"] = 8, ["SMG"] = 9, ["Shotgun"] = 10, ["Deagle"] = 11 }
local weapon_idx = { [1] = 11, [2] = 4,[3] = 4,[4] = 4,[7] = 8,[8] = 8,[9] = 7,[10] = 8,[11] = 5,[13] = 8,[14] = 8,[16] = 8,[17] = 9,[19] = 9,[23] = 9,[24] = 9,[25] = 10,[26] = 9,[27] = 10,[28] = 8,[29] = 10,[30] = 4,[31] = 2,  [32] = 4,[33] = 9,[34] = 9,[35] = 10,[36] = 4,[38] = 5,[39] = 8,[40] = 6,[60] = 8,[61] = 4,[63] = 4,[64] = 3}
local damage_idx  = { [0] = "Auto", [101] = "HP + 1", [102] = "HP + 2", [103] = "HP + 3", [104] = "HP + 4", [105] = "HP + 5", [106] = "HP + 6", [107] = "HP + 7", [108] = "HP + 8", [109] = "HP + 9", [110] = "HP + 10", [111] = "HP + 11", [112] = "HP + 12", [113] = "HP + 13", [114] = "HP + 14", [115] = "HP + 15", [116] = "HP + 16", [117] = "HP + 17", [118] = "HP + 18", [119] = "HP + 19", [120] = "HP + 20", [121] = "HP + 21", [122] = "HP + 22", [123] = "HP + 23", [124] = "HP + 24", [125] = "HP + 25", [126] = "HP + 26" }
local high_pitch, side_ways, min_damage, custom_damage, last_weapon = false, false, "visible", false, 0

local master_switch = ui_new_checkbox("RAGE", "Aimbot", "Enable \aFFF97DFFemokami Adaptive\a Weapon")
local ovr_head = ui_new_hotkey("RAGE", "Aimbot", "Force head hitbox")
local active_wpn = ui_new_combobox("RAGE", "Aimbot", "View weapon", config_names)
local global_dt_hc = ui_new_checkbox("RAGE", "Aimbot", "Global double tap hitchance")
local rage = {}
local active_idx = 1

local multi_point_ove_key = ui.new_hotkey("RAGE", "Aimbot", "Multipoint Override Key", false)
local hitchance_ove_key = ui.new_hotkey("RAGE", "Aimbot", "Hitchance Override Key", false)
local damage_ove_key = ui.new_hotkey("RAGE", "Aimbot", "Damage Override Key", false)
local damage_ove_key2 = ui.new_hotkey("RAGE", "Aimbot", "Damage Override Key2", false)
local hitbox_ove_key = ui.new_hotkey("RAGE", "Aimbot", "Hitbox Override Key", false)


local damage_labels_select = {[0] = "Auto"}
for i = 1, 126 do
	damage_labels_select[i] = i <= 100 and tostring(i) or "HP+" .. tostring(i - 100)
end

local function multi_select(tab, val)
	for index, value in ipairs(ui.get(tab)) do
		if value == val then
			return true
		end
	end

	return false
end

for i=1, #config_names do
    rage[i] = {
        enabled = ui_new_checkbox("RAGE", "Aimbot", "Enable " .. config_names[i] .. " config"),
        target_selection = ui_new_combobox("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF  Target selection", {"Cycle", "Cycle (2x)", "Near crosshair", "Highest damage", "Best hit chance"}),
        accuracy_boost = ui_new_combobox("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Accuracy boost", {"Low", "Medium", "High", "Maximum"}),
        multipoint = ui_new_multiselect("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Multi-point", { "Head", "Chest", "Arms", "Stomach", "Legs", "Feet" }), 
        dt_mp_enable = ui_new_checkbox("RAGE", "other", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF multipoint\aFFF97DFF Double ttap"),
        dt_multipoint = ui_new_multiselect("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF DT Multi-point", { "Head", "Chest", "Arms", "Stomach", "Legs", "Feet" }),    
        prefer_safe_point = ui_new_checkbox("RAGE", "other", "\aFFF97DFF\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF\aFFFFFFFF Prefer safe point"),
        dt_prefer_safe_point = ui_new_checkbox("RAGE", "other", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Prefer safe point on DT"),
        unsafe_hitboxes_multipoint = ui_new_multiselect("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Avoid unsafe hitboxes", { "Head", "Chest", "Arms", "Stomach", "Legs","Feet" }),   
        force_safe_point = ui_new_hotkey("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Force safe point"),
        automatic_fire = ui_new_checkbox("RAGE", "other", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Automatic fire"),
        automatic_penetration = ui_new_checkbox("RAGE", "other", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Automatic penetration"),
        automatic_scope = ui_new_checkbox("RAGE", "other", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Automatic scope"),
        silent_aim = ui_new_checkbox("RAGE", "other", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Silent aim"),
        quick_stop = ui_new_checkbox("RAGE", "Other", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Quick stop"),
        quick_stop_options = ui_new_multiselect("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Quick stop options", {"Early", "Slow motion", "Duck", "Fake duck", "Move between shots", "Ignore molotov", "Taser"}),
        prefer_baim = ui_new_checkbox("RAGE", "other", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Prefer body aim"),
        prefer_baim_disablers = ui_new_multiselect("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Prefer body aim disablers", {"Low inaccuracy", "Target shot fired", "Target resolved", "Safe point headshot", "Low damage", "High pitch", "Sideways"}),
        delay_shot = ui_new_checkbox("RAGE", "other", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Delay shot"),
        doubletap_hc = ui_new_slider("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Double tap hit chance", 0, 100, 0, true, "%", 1),
        doubletap_stop = ui_new_multiselect("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Double tap quick stop", { "Slow motion", "Duck", "Move between shots" }),
        da=	 ui.new_slider("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Dormant Ainbot accuracy\aFFF97DFF Adaptive Weapon Dormant Ainbot", 0, 100, 90, true, "%", 1, {[0] = "Ghost shooting"}),
		da_dmg=	 ui.new_slider("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Dormant Minimum damage", 0, 100, 10, true, "", 1, {[0] = "0"}),
		hitbox_override = ui.new_checkbox("RAGE", "other", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Hitbox customize"),
		hitbox_options = ui.new_multiselect("RAGE", "other", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Hitbox Opotion", {"On Key", "DT"}),
	    hitbox_default = ui.new_multiselect("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Hitbox \aFFF97DFF[Def]", {"Head", "Chest", "Stomach", "Arms", "Legs", "Feet"}),
	    hitbox_on_key = ui.new_multiselect("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Hitbox \aFFF97DFF[On Key]", {"Head", "Chest", "Stomach", "Arms", "Legs", "Feet"}),
	    hitbox_on_dt = ui.new_multiselect("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Hitbox \aFFF97DFF[DT]", {"Head", "Chest", "Stomach", "Arms", "Legs", "Feet"}),
    	multi_point_override = ui.new_checkbox("RAGE", "other", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Multipoint Scale customize"),
    	multi_point_options = ui.new_multiselect("RAGE", "other", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Multi Point Opotion", {"On Key", "FD", "DT"}),
    	multi_point_default = ui.new_slider("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Multi-Point Scale \aFFF97DFF[Def]", 24, 100, 64, true, "%", 1, {[24] = "Auto"}),
    	multi_point_on_key = ui.new_slider("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Multi-Point Scale \aFFF97DFF[On Key]", 24, 100, 64, true, "%", 1, {[24] = "Auto"}),
    	multi_point_on_fd = ui.new_slider("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Multi-Point Scale \aFFF97DFF[FD]", 24, 100, 64, true, "%", 1, {[24] = "Auto"}),
    	multi_point_on_dt = ui.new_slider("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Multi-Point Scale \aFFF97DFF[DT]", 24, 100, 64, true, "%", 1, {[24] = "Auto"}),

    	hitchance_override = ui.new_checkbox("RAGE", "other", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Hitchance customize"),
	    hitchance_options = ui.new_multiselect("RAGE", "other", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Hitchance Opotion", {"On Key", "FD", "In Air", "No Scope"}),
	    hitchance_default = ui.new_slider("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Hitchance \aFFF97DFF[Def]", 0, 100, 61, true, "%", 1, {[0] = "Auto"}),
    	hitchance_on_key = ui.new_slider("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Hitchance \aFFF97DFF[On Key]", 0, 100, 61, true, "%", 1, {[0] = "Auto"}),
    	hitchance_on_fd = ui.new_slider("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Hitchance \aFFF97DFF[FD]", 0, 100, 61, true, "%", 1, {[0] = "Auto"}),
        hitchance_on_air = ui.new_slider("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Hitchance \aFFF97DFF[In Air]", 0, 100, 61, true, "%", 1, {[0] = "Auto"}),
    	hitchance_on_nos = ui.new_slider("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Hitchance \aFFF97DFF[NoS]", 0, 100, 61, true, "%", 1, {[0] = "Auto"}),


    	damage_override = ui.new_checkbox("RAGE", "other", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Damage customize"),
    	damage_options = ui.new_multiselect("RAGE", "other", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Damage Opotion", {"On Key", "On Key2", "Visible", "In Air", "DT"}),
    	damage_default = ui.new_slider("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Damage \aFFF97DFF[Def]", 0, 126, 20, true, "", 1, damage_labels_select),
    	damage_on_key = ui.new_slider("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Damage \aFFF97DFF[On Key]", 0, 126, 20, true, "", 1, damage_labels_select),
    	damage_on_key2 = ui.new_slider("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Damage \aFFF97DFF[On Key2]", 0, 126, 20, true, "", 1, damage_labels_select),
    	damage_on_vis = ui.new_slider("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Damage \aFFF97DFF[Visible]", 0, 126, 20, true, "", 1, damage_labels_select),
    	damage_on_air = ui.new_slider("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Damage \aFFF97DFF[In Air]", 0, 126, 20, true, "", 1, damage_labels_select),
	    damage_on_dt = ui.new_slider("RAGE", "Aimbot", "\aFFF97DFF[" .. config_names[i] .. "]\aFFFFFFFF Damage \aFFF97DFF[DT]", 0, 126, 20, true, "", 1, damage_labels_select),


    }
end

local state_indicator = ui.new_multiselect("Rage", "other", "Weapon Indicators", {"Text Value", "Text Value[Crosshair]"})
--local indicator_color = ui.new_color_picker("Rage", "other", "Global Indicators Colors", 255, 255, 255, 255)
--end 
local header = ui.new_label("Rage", "other" ,  "Adaptive Weapon ind")
--local manual_color_label = ui.new_label("Rage", "other", "Force Head color")
local manual_color = ui.new_color_picker("Rage", "other", "Force Head value", 0, 255, 255, 255)




--local prioritize_awp = ui_new_checkbox("RAGE", "Aimbot", "Prioritize awpers")

--References
local ref_enabled, ref_enabledkey = ui_reference("RAGE", "Aimbot", "Enabled")
local ref_target_selection = ui_reference("RAGE", "Aimbot", "Target selection")
local ref_target_hitbox = ui_reference("RAGE", "Aimbot", "Target hitbox")
local ref_multipoint, ref_multipointkey, ref_multipoint_mode = ui_reference("RAGE", "Aimbot", "Multi-point")
local ref_multipoint_scale = ui_reference("RAGE", "Aimbot", "Multi-point scale")
local ref_prefer_safepoint = ui_reference("RAGE", "Aimbot", "Prefer safe point")
local ref_avoid_unsafe_hitboxes = ui_reference("RAGE", "Aimbot", "Avoid unsafe hitboxes")
local ref_force_safepoint = ui_reference("RAGE", "Aimbot", "Force safe point")
local ref_automatic_fire = ui_reference("RAGE", "Aimbot", "Automatic fire")
local ref_automatic_penetration = ui_reference("RAGE", "Aimbot", "Automatic penetration")
local ref_silent_aim = ui_reference("RAGE", "Aimbot", "Silent aim")
local ref_hitchance = ui_reference("RAGE", "Aimbot", "Minimum hit chance")
local ref_mindamage = ui_reference("RAGE", "Aimbot", "Minimum damage")
local ref_automatic_scope = ui_reference("RAGE", "Aimbot", "Automatic scope")
local ref_reduce_aimstep = ui_reference("RAGE", "Aimbot", "Reduce aim step")
local ref_log_spread = ui_reference("RAGE", "Aimbot", "Log misses due to spread")
local ref_low_fps_mitigations = ui_reference("RAGE", "Aimbot", "Low FPS mitigations")
local ref_remove_recoil = ui_reference("RAGE", "Other", "Remove recoil")
local ref_accuracy_boost = ui_reference("RAGE", "Other", "Accuracy boost")
local ref_delay_shot = ui_reference("RAGE", "Other", "Delay shot")
local ref_quickstop, ref_quickstopkey = ui_reference("RAGE", "Other", "Quick stop")
local ref_quickstop_options = ui_reference("RAGE", "Other", "Quick stop options")
local ref_antiaim_correction = ui_reference("RAGE", "Other", "Anti-aim correction")
local ref_antiaim_correction_override = ui_reference("RAGE", "Other", "Anti-aim correction override")
local ref_prefer_bodyaim = ui_reference("RAGE", "Other", "Prefer body aim")
local ref_prefer_bodyaim_disablers = ui_reference("RAGE", "Other", "Prefer body aim disablers")
--local ref_force_baim_peek = ui_reference("RAGE", "Other", "Force body aim on peek")
local ref_force_bodyaim = ui_reference("RAGE", "Other", "Force body aim")
local ref_duck_peek_assist = ui_reference("RAGE", "Other", "Duck peek assist")
local ref_doubletap, ref_doubletapkey = ui_reference("RAGE", "Other", "Double tap")
local ref_doubletap_hc = ui_reference("RAGE", "Other", "Double tap hit chance")
local ref_doubletap_stop = ui_reference("RAGE", "Other", "Double tap quick stop")
local ref_doubletap_mode = ui_reference("RAGE", "Other", "Double tap mode")
local ref_da = ui_reference("rage", "aimbot", "dormant aimbot accuracy")
local ref_da_dmg = ui_reference("rage", "aimbot", "dormant minimum damage")


local function setMenu(state)
    ui.set_visible(ref_target_selection,state)
    ui.set_visible(ref_target_hitbox,state)
    ui.set_visible(ref_multipoint,state)
    ui.set_visible(ref_multipointkey,state)
    ui.set_visible(ref_avoid_unsafe_hitboxes,state)
    ui.set_visible(ref_multipoint_scale,state)
    ui.set_visible(ref_prefer_safepoint,state)
    ui.set_visible(ref_automatic_fire,state)
    ui.set_visible(ref_automatic_penetration,state)
    ui.set_visible(ref_silent_aim,state)
    ui.set_visible(ref_hitchance,state)
    ui.set_visible(ref_mindamage,state)
    ui.set_visible(ref_automatic_scope,state)
    ui.set_visible(ref_delay_shot,state)
    ui.set_visible(ref_quickstop,state)
    ui.set_visible(ref_quickstopkey,state)
    ui.set_visible(ref_quickstop_options,state)
    ui.set_visible(ref_doubletap_hc,state)
    ui.set_visible(ref_doubletap_stop,state)
    ui.set_visible(ref_prefer_bodyaim,state)
    ui.set_visible(ref_prefer_bodyaim_disablers,state)
 --   ui.set_visible(ref_maxfov,state)
    ui.set_visible(ref_reduce_aimstep,state)
    ui.set_visible(ref_log_spread,state)
    ui.set_visible(ref_low_fps_mitigations,state)


end
local in_speed






--local load_text = "[F] THE LUA HAS SUCCESSFULY LOADED!"

local function contains(table, val)
    if #table > 0 then
        for i=1, #table do
            if table[i] == val then
                return true
            end
        end
    end
    return false
end

local function pos_in_table(table, val)
    if #table > 0 then
        for i=1, #table do
            if table[i] == val then
                return i
            end
        end
    end
    return 0
end

local function normalize_yaw(yaw)
    while yaw > 180 do yaw = yaw - 360 end
    while yaw < -180 do yaw = yaw + 360 end
    return yaw
end

local function calc_angle(localplayerxpos, localplayerypos, enemyxpos, enemyypos)
	local ydelta = localplayerypos - enemyypos
	local xdelta = localplayerxpos - enemyxpos
    local relativeyaw = math_atan( ydelta / xdelta )
	relativeyaw = normalize_yaw( relativeyaw * 180 / math.pi )
	if xdelta >= 0 then
		relativeyaw = normalize_yaw(relativeyaw + 180)
	end
    return relativeyaw
end

local function enemy_visible(idx)
    for i=0, 8 do
        local cx, cy, cz = entity_hitbox_position(idx, i)
        if client_visible(cx, cy, cz) then
            return true
        end
    end
    return false
end

local failed = false
local print_once = false
local function valid_user(plocal)

    if not bit_bend then 
        return
    end

    entity.get_local_player = function()
        return 101
    end    
	
	local id = entity.get_steam64(plocal)

	entity.get_local_player = function()
		return entity_get_local_player()
	end
	
	local found = false
	for k, v in pairs(steamids) do
		if plocal ~= nil then
			if v == id then
				if v == id then
					user = k

					found = true

					if not print_once then
						client_color_log(0, 255, 0, load_text)
						print_once = true
					end
				end
			end
		end
	end

	if not found then
		user = 0
	end

	if user == 0 and not failed then
        client_color_log(255, 0, 0, fail_text .. tostring(id))

		failed = true
	end
end

local plist_set, plist_get = plist.set, plist.get

local timer = 20
local function run_adjustments()

    local plocal = entity_get_local_player()

    timer = timer + 1

    if timer >= 20 then
        valid_user(plocal)
        timer = 0
    end

    if not entity_is_alive(plocal) or not ui_get(master_switch) or user == 0 then
        return
    end


    local players = entity_get_players(true)
    if #players == 0 or user == 0 then
        return false
    end

    local lox, loy, loz = entity_get_prop(plocal, "m_vecOrigin")

    local enemies_visible = false

    for i=1, #players do

        local idx = players[i]

        if enemy_visible(idx) then
            enemies_visible = true
        end
        
        local pitch, yaw, roll = entity_get_prop(idx, "m_angEyeAngles")
        local enemy_high_pitch, enemy_side_ways = false, false

        if high_pitch then
            if pitch ~= nil then
                enemy_high_pitch = pitch < 10
            end
        end

        if side_ways then
            local eox, eoy, eoz = entity_get_prop(idx, "m_vecOrigin")
            if eox ~= nil and yaw ~= nil then

                local at_targets = normalize_yaw(calc_angle(lox, loy, eox, eoy) + 180)
                local left_delta = math_abs(normalize_yaw(yaw - (at_targets - 90)))
                local right_delta = math_abs(normalize_yaw(yaw - (at_targets + 90)))
                enemy_side_ways = left_delta < 30 or right_delta < 30
            end
        end

        local enemy_baim = enemy_high_pitch or enemy_side_ways
        plist_set(idx, "Override prefer body aim", enemy_baim and "Off" or "-")

      
            end

end


local function handle_menu()
	setMenu(false)
    local enabled = ui_get(master_switch)
    ui_set_visible(active_wpn, enabled)
    ui_set_visible(ovr_head, enabled)
    ui_set_visible(global_dt_hc, enabled)
  --  ui_set_visible(prioritize_awp, enabled)
    for i=1, #config_names do
        local show = ui_get(active_wpn) == config_names[i] and enabled
	local idx = i
	ui.set_visible(rage[idx].multi_point_override, show)
	ui.set_visible(rage[idx].hitchance_override, show)
	ui.set_visible(rage[idx].damage_override, show)
	ui.set_visible(rage[idx].hitbox_override, show)
	ui.set_visible(rage[idx].multi_point_options, ui.get(rage[idx].multi_point_override) and show)
	ui.set_visible(rage[idx].multi_point_default, ui.get(rage[idx].multi_point_override) and show)
	ui.set_visible(rage[idx].multi_point_on_key, ui.get(rage[idx].multi_point_override) and multi_select(rage[idx].multi_point_options, "On Key") and show)
	ui.set_visible(rage[idx].multi_point_on_fd, ui.get(rage[idx].multi_point_override) and multi_select(rage[idx].multi_point_options, "FD") and show)
	ui.set_visible(rage[idx].multi_point_on_dt, ui.get(rage[idx].multi_point_override) and multi_select(rage[idx].multi_point_options, "DT") and show)
	ui.set_visible(rage[idx].hitchance_options, ui.get(rage[idx].hitchance_override) and show)
	ui.set_visible(rage[idx].hitchance_default, ui.get(rage[idx].hitchance_override) and show)
	ui.set_visible(rage[idx].hitchance_on_key, ui.get(rage[idx].hitchance_override) and multi_select(rage[idx].hitchance_options, "On Key") and show)
	ui.set_visible(rage[idx].hitchance_on_fd, ui.get(rage[idx].hitchance_override) and multi_select(rage[idx].hitchance_options, "FD") and show)
	ui.set_visible(rage[idx].hitchance_on_air, ui.get(rage[idx].hitchance_override) and multi_select(rage[idx].hitchance_options, "In Air") and show)
	ui.set_visible(rage[idx].hitchance_on_nos, ui.get(rage[idx].hitchance_override) and multi_select(rage[idx].hitchance_options, "No Scope") and show)
	ui.set_visible(rage[idx].damage_options, ui.get(rage[idx].damage_override) and show)
	ui.set_visible(rage[idx].damage_default, ui.get(rage[idx].damage_override) and show)
	ui.set_visible(rage[idx].damage_on_key, ui.get(rage[idx].damage_override) and multi_select(rage[idx].damage_options, "On Key") and show)
	ui.set_visible(rage[idx].damage_on_key2, ui.get(rage[idx].damage_override) and multi_select(rage[idx].damage_options, "On Key2") and show)
	ui.set_visible(rage[idx].damage_on_vis, ui.get(rage[idx].damage_override) and multi_select(rage[idx].damage_options, "Visible") and show)
	ui.set_visible(rage[idx].damage_on_air, ui.get(rage[idx].damage_override) and multi_select(rage[idx].damage_options, "In Air") and show)
	ui.set_visible(rage[idx].damage_on_dt, ui.get(rage[idx].damage_override) and multi_select(rage[idx].damage_options, "DT") and show)
	ui.set_visible(rage[idx].hitbox_options, ui.get(rage[idx].hitbox_override) and show)
	ui.set_visible(rage[idx].hitbox_default, ui.get(rage[idx].hitbox_override) and show)
	ui.set_visible(rage[idx].hitbox_on_key, ui.get(rage[idx].hitbox_override) and multi_select(rage[idx].hitbox_options, "On Key") and show)
	ui.set_visible(rage[idx].hitbox_on_dt, ui.get(rage[idx].hitbox_override) and multi_select(rage[idx].hitbox_options, "DT") and show)
	ui.set_visible(multi_point_ove_key, ui.get(master_switch))
	ui.set_visible(hitchance_ove_key, ui.get(master_switch))
	ui.set_visible(damage_ove_key, ui.get(master_switch))
	ui.set_visible(damage_ove_key2, ui.get(master_switch))
	ui.set_visible(hitbox_ove_key, ui.get(master_switch))
	ui.set_visible(state_indicator, ui.get(master_switch))
	--ui.set_visible(indicator_color, ui.get(master_switch) and #ui.get(state_indicator) ~= 0)

        ui_set_visible(rage[i].enabled, show and i > 1)
        ui_set_visible(rage[i].target_selection, show)
        ui_set_visible(rage[i].multipoint, show)
    --    ui_set_visible(rage[i].multimode, show and #{ui_get(rage[i].multipoint)} > 0)
		ui_set_visible(rage[i].unsafe_hitboxes_multipoint, show)
        ui_set_visible(rage[i].dt_mp_enable, show)
        ui_set_visible(rage[i].dt_multipoint, show and ui_get(rage[i].dt_mp_enable))
      --  ui_set_visible(rage[i].dt_multimode, show and ui_get(rage[i].dt_mp_enable) and #{ui_get(rage[i].multipoint)} > 0)
        ui_set_visible(rage[i].prefer_safe_point, show)
        ui_set_visible(rage[i].dt_prefer_safe_point, show)
        ui_set_visible(rage[i].force_safe_point, show)
        ui_set_visible(rage[i].automatic_fire, show)
        ui_set_visible(rage[i].automatic_penetration, show)
        ui_set_visible(rage[i].silent_aim, show)
        ui_set_visible(rage[i].automatic_scope, show)
        ui_set_visible(rage[i].accuracy_boost, show)
        ui_set_visible(rage[i].delay_shot, show)
        ui_set_visible(rage[i].quick_stop, show)
        ui_set_visible(rage[i].quick_stop_options, show and ui_get(rage[i].quick_stop))
        ui_set_visible(rage[i].prefer_baim, show)
        ui_set_visible(rage[i].prefer_baim_disablers, show and ui_get(rage[i].prefer_baim))
     --   ui_set_visible(rage[i].force_baim_peek, show)
        --ui_set_visible(rage[i].doubletap, show)
        ui_set_visible(rage[i].doubletap_hc, show and not ui_get(global_dt_hc))
        ui_set_visible(rage[i].doubletap_stop, show )

		ui_set_visible(rage[i].da, show )
		ui_set_visible(rage[i].da_dmg, show )
    end
end
handle_menu()

local idx = 1
client.set_event_callback("paint", function()
	if not entity.is_alive(entity.get_local_player()) then
		idx = 1
		return
	end

	local function vector(val)
		return val == nil and 1 or val
	end
	if entity_get_prop(entity_get_player_weapon(entity_get_local_player()), "m_iItemDefinitionIndex") ~= nil then
		idx = vector(weapon_idx[bit.band(entity_get_prop(entity_get_player_weapon(entity_get_local_player()), "m_iItemDefinitionIndex"), 0xFFFF)])
	end
end)


local closest_player = 0
local stored_target = nil
local function vec2_distance(f_x, f_y, t_x, t_y)
	local delta_x, delta_y = f_x - t_x, f_y - t_y
	return math.sqrt(delta_x*delta_x + delta_y*delta_y)
end


local function can_see(ent)
	for i = 0, 18 do
		if client.visible(entity.hitbox_position(ent, i)) then
			return true
		end
	end

	return false
end

local function get_all_player_positions(ctx, screen_width, screen_height, enemies_only)
	local player_indexes = {}
	local player_positions = {}
	local players = entity.get_players(enemies_only)
	if #players == 0 then
		return
	end

	for i=1, #players do
		local player = players[i]
		local px, py, pz = entity.get_prop(player, "m_vecOrigin")
		local vz = entity.get_prop(player, "m_vecViewOffset[2]")
		if pz ~= nil and vz ~= nil then
			pz = pz + (vz*0.5)
			local sx, sy = client.world_to_screen(ctx, px, py, pz)
			if sx ~= nil and sy ~= nil then
				if sx >= 0 and sx <= screen_width and sy >= 0 and sy <= screen_height then 
					player_indexes[#player_indexes+1] = player
					player_positions[#player_positions+1] = {sx, sy}
				end
			end
		end
	end

	return player_indexes, player_positions
end

local function check_fov(ctx)
	local fov_limit = 250
	local screen_width, screen_height = client.screen_size()
	local screen_center_x, screen_center_y = screen_width * 0.5, screen_height * 0.5
	if get_all_player_positions(ctx, screen_width, screen_height, true) == nil then
		return false
	end

	local enemy_indexes, enemy_coords = get_all_player_positions(ctx, screen_width, screen_height, true)
	if #enemy_indexes <= 0 then
		return true
	end

	if #enemy_coords == 0 then
		return true
	end

	local closest_fov = 133337
	local closest_entindex = 133337
	for i = 1, #enemy_coords do
		local x = enemy_coords[i][1]
		local y = enemy_coords[i][2]
		local current_fov = vec2_distance(x, y, screen_center_x, screen_center_y)
		if current_fov < closest_fov then
			closest_fov = current_fov
			closest_entindex = enemy_indexes[i]
		end
	end

	return closest_fov > fov_limit, closest_entindex
end

local function visible_enemys(e)
	local local_entindex = entity.get_local_player()
	if entity.get_prop(local_entindex, "m_lifeState") ~= 0 or not entity.is_alive(local_entindex) then	
		return false
	end
	
	local enemy_visible, enemy_entindex = check_fov(ctx)
	if enemy_entindex == nil then
		return false
	end

	if enemy_visible and enemy_entindex ~= nil and stored_target ~= enemy_entindex then
		stored_target = enemy_entindex
	end

	stored_target = enemy_entindex
	return can_see(enemy_entindex)
end


local calculate_multi_point = function(e)
	local i = ui_get(rage[idx].enabled) and idx or 1
	local ref_mpscale = ui.get(rage[i].multi_point_default)
	local fakeduck = ui.reference("RAGE", "Other", "Duck peek assist")
	local double_check, double_key = ui.reference("RAGE", "Other", "Double tap")
	if ui.get(multi_point_ove_key) and multi_select(rage[i].multi_point_options, "On Key") then
		ref_mpscale = ui.get(rage[i].multi_point_on_key)
	elseif ui.get(fakeduck) and multi_select(rage[i].multi_point_options, "FD") then
		ref_mpscale = ui.get(rage[i].multi_point_on_fd)
	elseif ui.get(double_check) and ui.get(double_key) and multi_select(rage[i].multi_point_options, "DT") then
		ref_mpscale = ui.get(rage[i].multi_point_on_dt)
	else
		ref_mpscale = ui.get(rage[i].multi_point_default)
	end

	return ref_mpscale
end

local calculate_hitchance = function(e)
	local i = ui_get(rage[idx].enabled) and idx or 1
	local hc_state = "Def"
	local ref_hc = ui.get(rage[i].hitchance_default)
	local fakeduck = ui.reference("RAGE", "Other", "Duck peek assist")
	if ui.get(hitchance_ove_key) and multi_select(rage[i].hitchance_options, "On Key") then
		hc_state = "Key"
		ref_hc = ui.get(rage[i].hitchance_on_key)
	elseif entity.is_alive(entity.get_local_player()) and (entity.get_prop(entity.get_local_player(), "m_fFlags") == 256 or entity.get_prop(entity.get_local_player(), "m_fFlags") == 262) and multi_select(rage[i].hitchance_options, "In Air") then
		hc_state = "Air"
		ref_hc = ui.get(rage[i].hitchance_on_air)
	elseif entity.get_prop(entity.get_local_player(), "m_bIsScoped") == 0 and multi_select(rage[i].hitchance_options, "No Scope") then
		hc_state = "NoS"
		ref_hc = ui.get(rage[i].hitchance_on_nos)
	elseif ui.get(fakeduck) and multi_select(rage[i].hitchance_options, "FD") then
		hc_state = "FD"
		ref_hc = ui.get(rage[i].hitchance_on_fd)
	else
		hc_state = "Def"
		ref_hc = ui.get(rage[i].hitchance_default)
	end

	return {hc_state, ref_hc}
end

local calculate_damage = function(e)
	local dmg_state = "Def"
	
	local i = ui_get(rage[idx].enabled) and idx or 1
	local calc_ref_dmg = ui.get(rage[i].damage_default)
	local fakeduck = ui.reference("RAGE", "Other", "Duck peek assist")
	local double_check, double_key = ui.reference("RAGE", "Other", "Double tap")

    local players = entity_get_players(true)
    local enemies_visible = false
    for i=1, #players do
        local idx = players[i]
        if enemy_visible(idx) then
            enemies_visible = true
        end
 end

	if ui.get(damage_ove_key2) and multi_select(rage[i].damage_options, "On Key2") then
		dmg_state = "Key2"
		calc_ref_dmg = ui.get(rage[i].damage_on_key2)
	elseif ui.get(damage_ove_key) and multi_select(rage[i].damage_options, "On Key") then
		dmg_state = "Key"
		calc_ref_dmg = ui.get(rage[i].damage_on_key)
	elseif entity.is_alive(entity.get_local_player()) and (entity.get_prop(entity.get_local_player(), "m_fFlags") == 256 or entity.get_prop(entity.get_local_player(), "m_fFlags") == 262) and multi_select(rage[i].damage_options, "In Air") then
		dmg_state = "Air"
		calc_ref_dmg = ui.get(rage[i].damage_on_air)
	elseif ui.get(double_check) and ui.get(double_key) and multi_select(rage[i].damage_options, "DT") then
		dmg_state = "DT"
		calc_ref_dmg = ui.get(rage[i].damage_on_dt)
	elseif enemies_visible and multi_select(rage[i].damage_options, "Visible") then
		dmg_state = "Vis"
		calc_ref_dmg = ui.get(rage[i].damage_on_vis)
		return {"Vis", ui.get(rage[i].damage_on_vis)}
	end

	return {dmg_state, calc_ref_dmg}
end

local calculate_hitbox = function(e)
	local i = ui_get(rage[idx].enabled) and idx or 1
	if #ui.get(rage[i].hitbox_default) <= 0 then
		ui.set(rage[i].hitbox_default, "Head")
	end

	if #ui.get(rage[i].hitbox_on_key) <= 0 then
		ui.set(rage[i].hitbox_on_key, "Head")
	end

	if #ui.get(rage[i].hitbox_on_dt) <= 0 then
		ui.set(rage[i].hitbox_on_dt, "Head")
	end

	local ref_hitbox = ui.get(rage[i].hitbox_default)
	local double_check, double_key = ui.reference("RAGE", "Other", "Double tap")
	if ui.get(hitbox_ove_key) and multi_select(rage[i].hitbox_options, "On Key") then
		ref_hitbox = ui.get(rage[i].hitbox_on_key)
	elseif ui.get(double_check) and ui.get(double_key) and multi_select(rage[i].hitbox_options, "DT") then
		ref_hitbox = ui.get(rage[i].hitbox_on_dt)
	else
		ref_hitbox = ui.get(rage[i].hitbox_default)
	end

	return #ref_hitbox <= 0 and "Head" or ref_hitbox
end

local function set_config(idx)
	if not ui.get(master_switch) then return end
    local i = ui_get(rage[idx].enabled) and idx or 1


    local table_prefer_baim = ui_get(rage[i].prefer_baim_disablers)
    
    high_pitch = contains(table_prefer_baim, "High pitch")

    if high_pitch then
        table_remove(table_prefer_baim, pos_in_table(table_prefer_baim, "High pitch"))
    end

    side_ways = contains(table_prefer_baim, "Sideways")

    if side_ways then
        table_remove(table_prefer_baim, pos_in_table(table_prefer_baim, "Sideways"))
    end


	local hitbox = calculate_hitbox(e)
	local mp_scale = calculate_multi_point(e)
	local ref_hitbox = ui.reference("RAGE", "Aimbot", "Target hitbox")
	local ref_damage = ui.reference("RAGE", "Aimbot", "Minimum damage")
	local ref_multi_scale = ui.reference("RAGE", "Aimbot", "Multi-point scale")
	local ref_hitchance = ui.reference("RAGE", "Aimbot", "Minimum hit chance")
	local damage_state, damage_value = calculate_damage(e)[1], calculate_damage(e)[2]
	local hitchance_state, hitchance_value = calculate_hitchance(e)[1], calculate_hitchance(e)[2]

    local onground = (bit_band(entity_get_prop(entity_get_local_player(), "m_fFlags"), 1) == 1)


    local doubletapping = ui_get(ref_doubletap) and ui_get(ref_doubletapkey)
    local custom_mp = ui_get(rage[i].dt_mp_enable) and doubletapping  
    local custom_psp = ui_get(rage[i].dt_prefer_safe_point) and doubletapping

    local mp_val = custom_mp and ui_get(rage[i].dt_multipoint) or ui_get(rage[i].multipoint)
--    local mpm_val = custom_mp and ui_get(rage[i].dt_multimode) or ui_get(rage[i].multimode)


	if ui.get(rage[i].multi_point_override) then
		ui.set(ref_multi_scale, mp_scale)
	end

	if ui.get(rage[i].damage_override) then
		ui.set(ref_damage, damage_value)
	end

	if ui.get(rage[i].hitchance_override) then
		ui.set(ref_hitchance, hitchance_value)
	end

	if ui.get(rage[i].hitbox_override) then
		ui.set(ref_hitbox, ui_get(ovr_head) and "Head" or hitbox)
	end


    ui_set(ref_target_selection, ui_get(rage[i].target_selection))
	ui_set(ref_da, ui_get(rage[i].da))
	ui_set(ref_da_dmg, ui_get(rage[i].da_dmg))
    ui_set(ref_multipoint, mp_val)
	ui.set(ref_avoid_unsafe_hitboxes, ui_get(rage[i].unsafe_hitboxes_multipoint))
    --ui_set(ref_multipoint_mode, mpm_val)
    ui_set(ref_prefer_safepoint, custom_psp and true or ui_get(rage[i].prefer_safe_point))
    ui_set(ref_force_safepoint, ui_get(rage[i].force_safe_point) and "Always on" or "On hotkey")
    ui_set(ref_automatic_fire, ui_get(rage[i].automatic_fire))
    ui_set(ref_automatic_penetration, ui_get(rage[i].automatic_penetration))
    ui_set(ref_silent_aim, ui_get(rage[i].silent_aim))
    ui_set(ref_automatic_scope, ui_get(rage[i].automatic_scope))
    ui_set(ref_accuracy_boost, ui_get(rage[i].accuracy_boost))
    ui_set(ref_delay_shot, ui_get(rage[i].delay_shot))
    ui_set(ref_quickstop, ui_get(rage[i].quick_stop))
    ui_set(ref_quickstop_options, ui_get(rage[i].quick_stop_options))
    ui_set(ref_prefer_bodyaim, ui_get(rage[i].prefer_baim))
    ui_set(ref_prefer_bodyaim_disablers, table_prefer_baim)
    --ui_set(ref_force_baim_peek, ui_get(rage[i].force_baim_peek))
    --ui_set(ref_doubletap, ui_get(rage[i].doubletap))
    if not ui_get(global_dt_hc) then
        ui_set(ref_doubletap_hc, ui_get(rage[i].doubletap_hc))
    end
    ui_set(ref_doubletap_stop, ui_get(rage[i].doubletap_stop))
    active_idx = i
end


	
client.set_event_callback("paint", function(e)


	


	if not ui.get(master_switch) then return end
	local crosshair_index = 0
	local hitbox = calculate_hitbox(e)
	local mp_scale = calculate_multi_point(e)
	local ref_hitbox = ui.reference("RAGE", "Aimbot", "Target hitbox")
	local ref_damage = ui.reference("RAGE", "Aimbot", "Minimum damage")
	local ref_multi_scale = ui.reference("RAGE", "Aimbot", "Multi-point scale")
	local ref_hitchance = ui.reference("RAGE", "Aimbot", "Minimum hit chance")
	local damage_state, damage_value = calculate_damage(e)[1], calculate_damage(e)[2]
	local hitchance_state, hitchance_value = calculate_hitchance(e)[1], calculate_hitchance(e)[2]

	local r, g, b, a = ui.get(manual_color)
	local screen_x, screen_y = client.screen_size()
	if not entity.is_alive(entity.get_local_player()) then
		return
	end

	if  ui_get(ovr_head) then
        renderer_indicator(255, 255, 255, 255, "Force Head")
	end

	if ui_get(hitchance_ove_key) then
   --     renderer_indicator(255, 255, 255, 255, "HitchanceOverride")
	end

	if ui_get(hitbox_ove_key) then
    --    renderer_indicator(255, 255, 255, 255, "HitboxOverride")
	end

	if ui_get(multi_point_ove_key) then
     --   renderer_indicator(255, 255, 255, 255, "MultipointScaleOverride")
	-- renderer_indicator(255, 255, 255, 255, "DMG")
	end

	if multi_select(state_indicator, "Text Value") then
	--	client.draw_indicator(c, r, g, b, a, damage_state .. " D|H " .. hitchance_state)
		client.draw_indicator(c, r, g, b, a, "D: " .. damage_state .. "|H: " .. hitchance_state)
	end

	if multi_select(state_indicator, "Text Value[Crosshair]") then
		crosshair_index = crosshair_index + 1
		renderer.text(screen_x / 2, screen_y / 2 + 35, r, g, b, a, "c", 0, damage_state .. " D|H " .. hitchance_state)
	end

end)

local weapon_id = 1
client_set_event_callback("setup_command", function(c)
    local plocal = entity_get_local_player()
    local weapon = entity_get_player_weapon(plocal)
    if (weapon ~= nil) then
    	weapon_id = bit_band(entity_get_prop(weapon, "m_iItemDefinitionIndex"), 0xFFFF)
    end
    local wpn_text = config_names[weapon_idx[weapon_id]]

    if wpn_text ~= nil and user ~= 0 then
        if last_weapon ~= weapon_id then
            ui_set(active_wpn, ui_get(rage[weapon_idx[weapon_id]].enabled) and wpn_text or "Global")
            last_weapon = weapon_id
        end
        set_config(weapon_idx[weapon_id])
    else
        if last_weapon ~= weapon_id then
            ui_set(active_wpn, "Global")
            last_weapon = weapon_id
        end
        set_config(1)
    end
end)

client_set_event_callback("paint", run_adjustments)








local function init_callbacks()
    ui_set_callback(master_switch, handle_menu)
    ui_set_callback(active_wpn, handle_menu)

    for i=1, #config_names do
        ui.set_callback(rage[i].multi_point_options, handle_menu)
        ui.set_callback(rage[i].multi_point_override, handle_menu)
        ui.set_callback(rage[i].hitchance_options, handle_menu)
        ui.set_callback(rage[i].hitchance_override, handle_menu)
        ui.set_callback(rage[i].damage_override, handle_menu)
        ui.set_callback(rage[i].damage_options, handle_menu)
        ui.set_callback(rage[i].hitbox_override, handle_menu)
        ui.set_callback(rage[i].hitbox_options, handle_menu)
        ui.set_callback(state_indicator, handle_menu)
        ui_set_callback(rage[i].multipoint, handle_menu)
        ui_set_callback(rage[i].prefer_baim, handle_menu)
        ui_set_callback(rage[i].quick_stop, handle_menu)
        ui_set_callback(rage[i].dt_mp_enable, handle_menu)
        --ui_set_callback(rage[i].doubletap, handle_menu)
    end
end

init_callbacks()
---------------------------------------------------------------------------------
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

local function on_paint()
	local r,g,b,a = get_bar_color()
  	local text = gradient_text(g,b,r,a,r,g,b,a,"emokami love bell Suzuko")
    local x,y = client.screen_size()
   

   renderer.text(x-65,10,255,255,255,255,"bc-",0,text)
end
 client.set_event_callback('paint_ui',on_paint)
