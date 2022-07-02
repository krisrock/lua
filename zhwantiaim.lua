
--@Ref 
local vector = require "vector"
local anti_aim = require 'gamesense/antiaim_funcs'
local function contains(b,c)for d,e in pairs(b)do if e==c then return true end end;return false end
local function round(num, decimals) local mult = 10^(decimals or 0) return math.floor(num * mult + 0.5) / mult end
local ui_new_checkbox, ui_new_slider, ui_new_combobox, ui_new_multiselect, ui_new_hotkey, ui_new_button, ui_new_color_picker, ui_reference, ui_set, ui_get, ui_set_callback, ui_set_visible, math_random, me, ui_new_label, color_log, ui_new_textbox, renderer_triangle = ui.new_checkbox, ui.new_slider, ui.new_combobox, ui.new_multiselect, ui.new_hotkey, ui.new_button, ui.new_color_picker, ui.reference, ui.set, ui.get, ui.set_callback, ui.set_visible, math.random, entity.get_local_player, ui.new_label, client.color_log, ui.new_textbox, renderer.triangle
local Render_engine=(function()local self={}local b=function(c,d,e,f,g,h,i)local j=0;if g==0 then return end;renderer.rectangle(c+h+j,d+h+j,e-h*2-j*2,f-h*2-j*2,17,17,17,g)renderer.circle(c+e-h-j,d+h+j,17,17,17,g,h,90,0.25)renderer.circle(c+e-h-j,d+f-h-j,17,17,17,g,h,360,0.25)renderer.circle(c+h+j,d+f-h-j,17,17,17,g,h,270,0.25)renderer.circle(c+h+j,d+h+j,17,17,17,g,h,180,0.25)renderer.rectangle(c+h+j,d+j,e-h*2-j*2,h,17,17,17,g)renderer.rectangle(c+e-h-j,d+h+j,h,f-h*2-j*2,17,17,17,g)renderer.rectangle(c+h+j,d+f-h-j,e-h*2-j*2,h,17,17,17,g)renderer.rectangle(c+j,d+h+j,h,f-h*2-j*2,17,17,17,g)end;local k=function(c,d,e,f,l,m,n,o,p,h,i)local j=h==0 and i or 0;renderer.rectangle(c+h,d,e-h*2,i,l,m,n,o)renderer.circle_outline(c+e-h,d+h,l,m,n,o,h,270,0.25,i)renderer.gradient(c+e-i,d+h+j,i,f-h*2-j*2,l,m,n,o,l,m,n,p,false)renderer.circle_outline(c+e-h,d+f-h,l,m,n,p,h,360,0.25,i)renderer.rectangle(c+h,d+f-i,e-h*2,i,l,m,n,p)renderer.circle_outline(c+h,d+f-h,l,m,n,p,h,90,0.25,i)renderer.gradient(c,d+h+j,i,f-h*2-j*2,l,m,n,o,l,m,n,p,false)renderer.circle_outline(c+h,d+h,l,m,n,o,h,180,0.25,i)end;self.render_container=function(c,d,e,f,l,m,n,o,p,g,h,i,q)local r=o~=0 and g or o;local s=o~=0 and p or o;b(c,d,e,f,r,h,i)k(c,d,e,f,l,m,n,o,s,h,i)if q and g~=255 and o~=0 then end end;return self end)()
local dragging = (function()local a={}local b,c,d,e,f,g,h,i,j,k,l,m,n,o;local p={__index={drag=function(self,...)local q,r=self:get()local s,t=a.drag(q,r,...)if q~=s or r~=t then self:set(s,t)end;return s,t end,set=function(self,q,r)local j,k=client.screen_size()ui.set(self.x_reference,q/j*self.res)ui.set(self.y_reference,r/k*self.res)end,get=function(self)local j,k=client.screen_size()return ui.get(self.x_reference)/self.res*j,ui.get(self.y_reference)/self.res*k end}}function a.new(u,v,w,x)x=x or 10000;local j,k=client.screen_size()local y=ui.new_slider("AA", "Fake lag",u.." pos",0,x,v/j*x)local z=ui.new_slider("AA", "Fake lag","\n"..u.." pos 2",0,x,w/k*x)ui.set_visible(y,false)ui.set_visible(z,false)return setmetatable({name=u,x_reference=y,y_reference=z,res=x},p)end;function a.drag(q,r,A,B,C,D,E)if globals.framecount()~=b then c=ui.is_menu_open()f,g=d,e;d,e=ui.mouse_position()i=h;h=client.key_state(0x01)==true;m=l;l={}o=n;n=false;j,k=client.screen_size()end;if c and i~=nil then if(not i or o)and h and f>q and g>r and f<q+A and g<r+B then n=true;q,r=q+d-f,r+e-g;if not D then q=math.max(0,math.min(j-A,q))r=math.max(0,math.min(k-B,r))end end end;table.insert(l,{q,r,A,B})return q,r,A,B end;return a end)()
local _, slider = ui.reference("AA", "Anti-aimbot angles", "Body yaw")
local hk_dragger = dragging.new("Running WaterMarks", 500, 500)
local x, y = client.screen_size()
--server mm set
local ffi = require('ffi')
local ffi_cast = ffi.cast
local gamerules_ptr = client.find_signature("client.dll", "\x83\x3D\xCC\xCC\xCC\xCC\xCC\x74\x2A\xA1")
local gamerules = ffi.cast("intptr_t**", ffi.cast("intptr_t", gamerules_ptr) + 2)[0]
--@Rage
local rage = {
    delayshot = ui_reference('Rage', 'Other', 'Delay shot'),
    forcebaim = ui_reference('Rage', 'Other', 'Force body aim'),
    quickpeek = {ui_reference("Rage", "Other", "Quick peek assist")},
}
--@AA
local aa = {
    enabled = ui_reference('AA', 'Anti-aimbot angles', 'Enabled'),
    pitch = ui_reference('AA', 'Anti-aimbot angles', 'Pitch'),
    yawbase = ui_reference('AA', 'Anti-aimbot angles', "Yaw base"),
    yaw = {ui_reference('AA', 'Anti-aimbot angles', 'Yaw')},
    bodyyaw = {ui_reference('AA', 'Anti-aimbot angles', 'Body yaw')},
    fakeyawlimit = ui_reference('AA', 'Anti-aimbot angles', 'Fake yaw limit'),
    jitter = {ui_reference('AA', 'Anti-aimbot angles', 'Yaw jitter')},
    freestandbody = ui_reference('AA', 'Anti-aimbot angles', 'Freestanding body yaw'),
    freestanding = {ui_reference('AA', 'Anti-aimbot angles', 'Freestanding')},
    edgeyaw = ui_reference('AA', 'Anti-aimbot angles', 'Edge yaw'),
    roll = ui_reference('AA', 'Anti-aimbot angles', 'Roll'),
    fakewalk = {ui_reference('AA', 'Other', 'Slow motion')},
}
--@ Exploits
local exploit = {
    doubletap = {ui_reference('Rage', 'Other', 'Double tap')},
    dtmode = ui_reference("RAGE", "Other", "Double tap mode"),
    dthc = ui_reference("RAGE", "Other", "Double tap hit chance"),
    hideshot = {ui_reference('AA', 'Other', 'On shot anti-aim')},
    fakeducking = ui_reference('Rage', 'Other', 'Duck peek assist'),
    fl_enable = ui_reference("AA", "Fake lag", "Enabled"),
    fakelag = ui_reference('AA', 'Fake lag', 'Limit'),
    amount = ui_reference('AA', 'Fake lag', 'Amount'),
    variance = ui_reference('AA', 'Fake lag', 'Variance'),
    sv_maxusrcmdprocessticks = {ui_reference('MISC', 'Settings', 'sv_maxusrcmdprocessticks')},
    dtfl = ui_reference("RAGE", "Other", "Double tap fake lag limit"),
    slowmotiontype = {ui_reference("AA", 'Other', 'Slow motion type')},
    legs_ref = ui_reference("AA", "OTHER", "leg movement"),
}
--@Extra menu elemenst
local menu = {
    arctic = ui_new_checkbox('AA', 'Anti-aimbot angles', '\aD6BE73FFemokami'),
    boxx = ui_new_multiselect("AA", "Anti-aimbot angles", "\aD6BE73FFlist of options", {"Premium:Antiaim","Premium:Fakelag","Premium:Doubletap","Premium:Directions","Misc:Clantag","Misc:TP Peek","Misc:LC trigger","Misc:Animation","Misc:Slowmotion","Misc:Anti-knife","Visuals:DickMan","Visuals:Indicator","Visuals:Watermaker"}),
    manual_roll_enablle = ui_new_hotkey("AA", "anti-aimbot angles","\aD6BE73FFExtend Roll"),
    free = ui_new_hotkey('AA', 'Anti-aimbot angles',"\aD6BE73FFFreestanding"),
    edge = ui_new_hotkey('AA', 'Anti-aimbot angles',"\aD6BE73FFEdge Yaw"),
    manualleft = ui_new_hotkey('AA', 'Anti-aimbot angles',"\aD6BE73FFManual Left"),
    manualright = ui_new_hotkey('AA', 'Anti-aimbot angles',"\aD6BE73FFManual Right"),
    manualback = ui_new_hotkey('AA', 'Anti-aimbot angles',"\aD6BE73FFManual Back"),
    manual_state = ui_new_slider('AA', 'Anti-aimbot angles',"\aD6BE73FFManual direction", 0, 3, 0),
}
--tank
local ZhaG = {chokex = 0,curtick = 0,yawshit = 0,gettick = globals.tickcount,curchoke = globals.chokedcommands,yawreversed = false,}
local function tankyaw(a,b)
  if ZhaG.curtick - ZhaG.yawshit > 1 and ZhaG.chokex == 1 then
	 ZhaG.yawreversed = not ZhaG.yawreversed
	 ZhaG.yawshit = ZhaG.curtick
  end
  if ZhaG.curtick - ZhaG.yawshit > 20 or ZhaG.curtick - ZhaG.yawshit < 0 then
	 ZhaG.yawshit = ZhaG.curtick
  end
  return ZhaG.yawreversed and a or b
end
--roll
local sbnum = 0
local function run_fakelag(cmd)
  if ui_get(menu.arctic) and contains(ui_get(menu.boxx),'Premium:Directions') and ui_get(menu.manual_roll_enablle) then 
	if cmd.chokedcommands < 15 or shouldBreak == true  then
		cmd.allow_send_packet = false
		cmd.roll = sbnum
	else
		cmd.allow_send_packet = true	
		cmd.roll = sbnum	
	end
  end
	local rollnum = cmd.roll
end
client.set_event_callback("setup_command", run_fakelag)
--@Menu visibility
local function visible()
    if ui_get(menu.arctic) then 
    ui_set_visible(aa.enabled, false)
    ui_set_visible(aa.pitch, false)
    ui_set_visible(aa.yawbase, false)
    ui_set_visible(aa.yaw[1], false)
    ui_set_visible(aa.yaw[2], false)
    ui_set_visible(aa.bodyyaw[1], false)
    ui_set_visible(aa.bodyyaw[2], false)
    ui_set_visible(aa.fakeyawlimit, false)
    ui_set_visible(aa.jitter[1], false)
    ui_set_visible(aa.jitter[2], false)
    ui_set_visible(aa.freestandbody, false)
    ui_set_visible(aa.edgeyaw, false)
    ui_set_visible(aa.freestanding[1], false)
    ui_set_visible(aa.freestanding[2], false)
    ui_set_visible(aa.roll, false)
    else 
    ui_set_visible(aa.enabled, true)
    ui_set_visible(aa.pitch, true)
    ui_set_visible(aa.yawbase, true)
    ui_set_visible(aa.yaw[1], true)
    ui_set_visible(aa.yaw[2], true)
    ui_set_visible(aa.bodyyaw[1], true)
    ui_set_visible(aa.bodyyaw[2], true)
    ui_set_visible(aa.fakeyawlimit, true)
    ui_set_visible(aa.jitter[1], true)
    ui_set_visible(aa.freestandbody, true)
    ui_set_visible(aa.edgeyaw, true)
    ui_set_visible(aa.freestanding[1], true)
    ui_set_visible(aa.freestanding[2], true)
    ui_set_visible(aa.roll, true)
    ui_set(aa.enabled, false)
    ui_set(aa.pitch, "Off")
    ui_set(aa.yawbase, "At targets")
    ui_set(aa.yaw[1], "Off")
    ui_set(aa.yaw[2], 0)
    ui_set(aa.jitter[1], "Off")
    ui_set(aa.jitter[2], 0)
    ui_set(aa.bodyyaw[1], "Off")
    ui_set(aa.bodyyaw[2], 0)
    ui_set(aa.fakeyawlimit, 0)
    ui_set(aa.edgeyaw, false)
    ui_set(aa.freestandbody, false)
    ui_set(aa.roll, 0)
    end
    if ui_get(menu.arctic) then 
        ui_set_visible(menu.boxx, true)
    else
        ui_set_visible(menu.boxx, false)
    end
    if ui_get(menu.arctic) and contains(ui_get(menu.boxx),'Premium:Directions') then 
        ui_set_visible(menu.manualleft, true)
        ui_set_visible(menu.manualright, true)
        ui_set_visible(menu.manualback, true)
        ui_set_visible(menu.manual_state, false)
        ui_set_visible(menu.manual_roll_enablle, true)
        ui_set_visible(menu.free, true)
        ui_set_visible(menu.edge, true)
    else
        ui_set_visible(menu.manualleft, false)
        ui_set_visible(menu.manualright, false)
        ui_set_visible(menu.manualback, false)
        ui_set_visible(menu.manual_state, false)
        ui_set_visible(menu.manual_roll_enablle, false)
        ui_set_visible(menu.free, false)
        ui_set_visible(menu.edge, false)
    end
end
--@AA
--Targets
local function get_near_target()
	local enemy_players = entity.get_players(true)
	if #enemy_players ~= 0 then
		local own_x, own_y, own_z = client.eye_position()
		local own_pitch, own_yaw = client.camera_angles()
		local closest_enemy = nil
		local closest_distance = 999999999
		for i = 1, #enemy_players do
			local enemy = enemy_players[i]
			local enemy_x, enemy_y, enemy_z = entity.get_prop(enemy, "m_vecOrigin")
			local x = enemy_x - own_x
			local y = enemy_y - own_y
			local z = enemy_z - own_z
			local yaw = ((math.atan2(y, x) * 200 / math.pi))
			local pitch = -(math.atan2(z, math.sqrt(math.pow(x, 2) + math.pow(y, 2))) * 200 / math.pi)
			local yaw_dif = math.abs(own_yaw % 360 - yaw % 360) % 360
			local pitch_dif = math.abs(own_pitch - pitch ) % 360

			if yaw_dif > 180 then yaw_dif = 360 - yaw_dif end
			local real_dif = math.sqrt(math.pow(yaw_dif, 2) + math.pow(pitch_dif, 2))

			if closest_distance > real_dif then
				closest_distance = real_dif
				closest_enemy = enemy
			end
		end
		if closest_enemy ~= nil then
			return closest_enemy, closest_distance
		end
	end
	return nil, nil
end
--@Anti Aim
local function player_state()
    local vx, vy = entity.get_prop(entity.get_local_player(), 'm_vecVelocity')
    local player_standing = math.sqrt(vx ^ 2 + vy ^ 2) < 2
    local player_jumping = bit.band(entity.get_prop(entity.get_local_player(), 'm_fFlags'), 1) == 0
    local player_crouching_inair = entity.get_prop(entity.get_local_player(), "m_fFlags") == 262
    local player_duck_peek_assist = ui_get(exploit.fakeducking)
    local player_crouching = entity.get_prop(entity.get_local_player(), "m_flDuckAmount") > 0.5 and not player_duck_peek_assist
    local player_slow_motion = ui_get(aa.fakewalk[1]) and ui_get(aa.fakewalk[2])
    local epeek = client.key_state(0x45)
    local target = get_near_target()

    if target == nil then
        return 'dormant'
    elseif epeek then
        return 'legit'
    elseif player_crouching_inair then
        return 'airduck'
    elseif player_duck_peek_assist then
        return 'fakeduck'
    elseif player_slow_motion then
        return 'slowmotion'
    elseif player_crouching and player_standing then
        return 'crouch'
    elseif player_jumping then
        return 'jump'
    elseif player_standing then
        return 'stand'
    elseif not player_standing then
        return 'move'
    end
end
--Dormant AA
local function aathingy()
    if not ui_get(menu.arctic) then return end
    if target == nil then
      if contains(ui_get(menu.boxx),'Premium:Antiaim') then 
        ui_set(aa.enabled, true)
        ui_set(aa.pitch, 'Default')
        ui_set(aa.yawbase, 'At targets')
        ui_set(aa.yaw[1], '180')
        ui_set(aa.yaw[2], 0)
        ui_set(aa.jitter[1], 'Off')
        ui_set(aa.jitter[2], 0)
        ui_set(aa.bodyyaw[1], 'Opposite')
        ui_set(aa.fakeyawlimit, 58)
        ui_set(aa.edgeyaw, false)
        ui_set(aa.freestandbody, true)
        ui_set(aa.roll, 0)
      else
        ui_set(aa.enabled, false)
      end
        if contains(ui_get(menu.boxx),'Premium:Fakelag') and not ui.get(menu.manual_roll_enablle) then 
           ui_set(exploit.amount, 'Dynamic')
           ui_set(exploit.variance, '0')
           ui_set(exploit.fakelag, '14')
        end
        yaw_status = "DORMANT"
        sbnum = 0
    end
    --@Legit
    if player_state() == 'legit' then 
      if contains(ui_get(menu.boxx),'Premium:Antiaim') then 
        ui_set(aa.enabled, true)
        ui_set(aa.pitch, 'Off')
        ui_set(aa.yawbase, 'Local view')
        ui_set(aa.yaw[1], '180')
        ui_set(aa.yaw[2], 180)
        ui_set(aa.jitter[1], 'Off')
        ui_set(aa.jitter[2], 0)
        ui_set(aa.bodyyaw[1], 'Static')
        ui_set(aa.bodyyaw[2], tankyaw(-180,180))
        ui_set(aa.fakeyawlimit, 60)
        ui_set(aa.edgeyaw, false)
        ui_set(aa.freestandbody, true)
        ui_set(aa.roll, 0)
      else
        ui_set(aa.enabled, false)
      end
        if contains(ui_get(menu.boxx),'Premium:Fakelag') and not ui.get(menu.manual_roll_enablle) then 
           ui_set(exploit.amount, 'Fluctuate')
           ui_set(exploit.variance, '25')
           ui_set(exploit.fakelag, '15')
        end
        yaw_status = "LEGIT"
        sbnum = 0
    end
end
--Normal AA
local function aathingy1()
    local player_crouching = bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"), 4) == 4
    local player_standing = bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"), 1) == 1
    local player_inair = bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"), 1) == 0
    ZhaG.chokex = ZhaG.curchoke()
    ZhaG.curtick = ZhaG.gettick()
    if not ui_get(menu.arctic) then return end
    --@Moving
    if player_state() == 'move' then 
      if contains(ui_get(menu.boxx),'Premium:Antiaim') then 
        ui_set(aa.enabled, true)
        ui_set(aa.pitch, 'Minimal')
        ui_set(aa.yawbase, 'At targets')
        ui_set(aa.yaw[1], '180')
        ui_set(aa.yaw[2], tankyaw(-40,-35))
        ui_set(aa.jitter[1], 'Offset')
        ui_set(aa.jitter[2], math_random(58,66))
        ui_set(aa.bodyyaw[1], 'Jitter')
        ui_set(aa.fakeyawlimit, math_random(40,59))
        ui_set(aa.edgeyaw, false)
        ui_set(aa.freestandbody, false)
        ui_set(aa.roll, 0)
      else
        ui_set(aa.enabled, false)
      end
        if contains(ui_get(menu.boxx),'Premium:Fakelag') and not ui.get(menu.manual_roll_enablle) then 
           ui_set(exploit.amount, 'Maximum')
           ui_set(exploit.variance, '15')
           ui_set(exploit.fakelag, '15')
        end
        yaw_status = "MOVE"
        sbnum = 0
    end
    --@Crouching
    if player_state() == 'crouch' then
      if contains(ui_get(menu.boxx),'Premium:Antiaim') then 
        ui_set(aa.enabled, true)
        ui_set(aa.pitch, 'Minimal')
        ui_set(aa.yawbase, 'At Targets')
        ui_set(aa.yaw[1], '180')
        ui_set(aa.yaw[2], 7)
        ui_set(aa.jitter[1], 'Center')
        ui_set(aa.jitter[2], '66')
        ui_set(aa.bodyyaw[1], 'jitter')
        ui_set(aa.fakeyawlimit, tankyaw(58,59))
        ui_set(aa.edgeyaw, false)
        ui_set(aa.freestandbody, false)
        ui_set(aa.roll, 0)
      else
        ui_set(aa.enabled, false)
      end
        if contains(ui_get(menu.boxx),'Premium:Fakelag') and not ui.get(menu.manual_roll_enablle) then 
           ui_set(exploit.amount, 'Maximum')
           ui_set(exploit.variance, '0')
           ui_set(exploit.fakelag, '15')
        end
        yaw_status = "CROUCH"
        sbnum = 0
    end
    --@Standing
    if player_state() == 'stand' then
      if contains(ui_get(menu.boxx),'Premium:Antiaim') then 
        ui_set(aa.enabled, true)
        ui_set(aa.pitch, 'Minimal')
        ui_set(aa.yawbase, 'At Targets')
        ui_set(aa.yaw[1], '180')
        ui_set(aa.yaw[2], tankyaw(-40,38))
        ui_set(aa.jitter[1], "Center")
        ui_set(aa.jitter[2], '5')
        ui_set(aa.bodyyaw[1], 'Static')
        ui_set(aa.bodyyaw[2], '180')
        ui_set(aa.fakeyawlimit, tankyaw(25,50))
        ui_set(aa.edgeyaw, false)
        ui_set(aa.freestandbody, false)
        ui_set(aa.roll, 0)
      else
        ui_set(aa.enabled, false)
      end
        if contains(ui_get(menu.boxx),'Premium:Fakelag') and not ui.get(menu.manual_roll_enablle) then 
           ui_set(exploit.amount, 'Dynamic')
           ui_set(exploit.variance, '9')
           ui_set(exploit.fakelag, '15')
        end
        yaw_status = "STAND"
        sbnum = 0
    end
    --@Slowwalk 
    if player_state() == 'slowmotion' then
      if contains(ui_get(menu.boxx),'Premium:Antiaim') then 
        ui_set(aa.enabled, true)
        ui_set(aa.pitch, "Minimal")
        ui_set(aa.yawbase, "At targets")
        ui_set(aa.yaw[1], "180")
        ui_set(aa.yaw[2], "-7")
        ui_set(aa.jitter[1], "Center")
        ui_set(aa.jitter[2], math_random(60, 66))
        ui_set(aa.bodyyaw[1], "jitter")
        ui_set(aa.fakeyawlimit, tankyaw(48,58))
        ui_set(aa.edgeyaw, false)
        ui_set(aa.freestandbody, false)
        ui_set(aa.roll, 0)
      else
        ui_set(aa.enabled, false)
      end
        if contains(ui_get(menu.boxx),'Premium:Fakelag') and not ui.get(menu.manual_roll_enablle) then 
           ui_set(exploit.amount, 'Dynamic')
           ui_set(exploit.variance, '15')
           ui_set(exploit.fakelag, '14')
        end
        yaw_status = "SLOW"
        sbnum = 0
    end
    --@Inair
    if player_state() == 'jump' then
      if contains(ui_get(menu.boxx),'Premium:Antiaim') then 
        ui_set(aa.enabled, true)
        ui_set(aa.pitch, "Default")
        ui_set(aa.yawbase, "At targets")
        ui_set(aa.yaw[1], "180")
        ui_set(aa.yaw[2], tankyaw(-10,-5))
        ui_set(aa.jitter[1], "Center")
        ui_set(aa.jitter[2], math_random(32,50))
        ui_set(aa.bodyyaw[1], "Jitter")
        ui_set(aa.fakeyawlimit, math_random(20,29))
        ui_set(aa.edgeyaw, false)
        ui_set(aa.freestandbody, false)
        ui_set(aa.roll, 0)
      else
        ui_set(aa.enabled, false)
      end
        if contains(ui_get(menu.boxx),'Premium:Fakelag') and not ui.get(menu.manual_roll_enablle) then 
           ui_set(exploit.amount, 'Maximum')
           ui_set(exploit.variance, '7')
           ui_set(exploit.fakelag, '15')
        end
        yaw_status = "IN AIR"
        sbnum = 0
    end
    --@air duck
    if player_state() == 'airduck' then
      if contains(ui_get(menu.boxx),'Premium:Antiaim') then 
        ui_set(aa.enabled, true)
        ui_set(aa.pitch, "Default")
        ui_set(aa.yawbase, "At targets")
        ui_set(aa.yaw[1], "180")
        ui_set(aa.yaw[2], tankyaw(0,5))
        ui_set(aa.jitter[1], "Center")
        ui_set(aa.jitter[2], math_random(61,77))
        ui_set(aa.bodyyaw[1], "Jitter")
        ui_set(aa.fakeyawlimit, math_random(29,60))
        ui_set(aa.edgeyaw, false)
        ui_set(aa.freestandbody, false)
        ui_set(aa.roll, 0)
      else
        ui_set(aa.enabled, false)
      end
        if contains(ui_get(menu.boxx),'Premium:Fakelag') and not ui.get(menu.manual_roll_enablle) then 
           ui_set(exploit.amount, 'Fluctuate')
           ui_set(exploit.variance, '0')
           ui_set(exploit.fakelag, '15')
        end
        yaw_status = "IN AIR +"
        sbnum = 0
    end

    --@fakeduck
    if player_state() == 'fakeduck' then
      if contains(ui_get(menu.boxx),'Premium:Antiaim') then 
        local randomfd = math_random(0,1)
        if randomfd == 0 then
            ui_set(aa.enabled, true)
            ui_set(aa.pitch, 'Down')
            ui_set(aa.yawbase, 'At Targets')
            ui_set(aa.yaw[1], '180')
            ui_set(aa.yaw[2], 0)
            ui_set(aa.bodyyaw[1], 'Static')
            ui_set(aa.bodyyaw[2], '90')
            ui_set(aa.fakeyawlimit, 48)
            ui_set(aa.edgeyaw, false)
            ui_set(aa.freestandbody, false)
            ui_set(aa.roll, 0)
        elseif randomfd == 1 then
            ui_set(aa.enabled, true)
            ui_set(aa.pitch, 'Default')
            ui_set(aa.yawbase, 'At Targets')
            ui_set(aa.yaw[1], '180')
            ui_set(aa.yaw[2], 5)
            ui_set(aa.bodyyaw[1], 'Static')
            ui_set(aa.bodyyaw[2], '-90')
            ui_set(aa.fakeyawlimit, 47)
            ui_set(aa.edgeyaw, false)
            ui_set(aa.freestandbody, false)
            ui_set(aa.roll, 0)
        end
      else
        ui_set(aa.enabled, false)
      end
        if contains(ui_get(menu.boxx),'Premium:Fakelag') and not ui.get(menu.manual_roll_enablle) then 
           ui_set(exploit.amount, 'Dynamic')
           ui_set(exploit.variance, '0')
           ui_set(exploit.fakelag, '14')
        end
        yaw_status = "FAKE DUCK"
        sbnum = 0
    end
end
--@Anti Brute
local function GetClosestPoint(A, B, P)
    local a_to_p = { P[1] - A[1], P[2] - A[2] }
    local a_to_b = { B[1] - A[1], B[2] - A[2] }
    local atb2 = a_to_b[1]^2 + a_to_b[2]^2
    local atp_dot_atb = a_to_p[1]*a_to_b[1] + a_to_p[2]*a_to_b[2]
    local t = atp_dot_atb / atb2
    return { A[1] + a_to_b[1]*t, A[2] + a_to_b[2]*t }
end
local should_swap = false
local it = 0
local angles = {60, 0, 106}
client.set_event_callback("bullet_impact", function(c)
    if ui_get(menu.arctic) and contains(ui_get(menu.boxx),'Premium:Antiaim') and entity.is_alive(entity.get_local_player()) then
        local ent = client.userid_to_entindex(c.userid)
        if not entity.is_dormant(ent) and entity.is_enemy(ent) then
            local ent_shoot = { entity.get_prop(ent, "m_vecOrigin") }
            ent_shoot[3] = ent_shoot[3] + entity.get_prop(ent, "m_vecViewOffset[2]")
            local player_head = { entity.hitbox_position(entity.get_local_player(), 0) }
            local closest = GetClosestPoint(ent_shoot, { c.x, c.y, c.z }, player_head)
            local delta = { player_head[1]-closest[1], player_head[2]-closest[2] }
            local delta_2d = math.sqrt(delta[1]^2+delta[2]^2)
            if math.abs(delta_2d) < 70 then
                it = it + 1
                should_swap = true
            end
        end
    end
end)
client.set_event_callback("run_command", function(c)
    if ui_get(menu.arctic) and contains(ui_get(menu.boxx),'Premium:Antiaim') and should_swap == true then
        ui.set(slider, angles[(it%3)+1])
    end
end)


--@Doubletap
local function dtoff()
    local ping = math.floor(client.latency() * 1000)
    if ping <= 55 and contains(ui_get(menu.boxx),'Premium:Doubletap') and ui_get(menu.arctic) and ui_get(exploit.doubletap[2]) then
        ui_set(exploit.sv_maxusrcmdprocessticks[1], 18)
        ui_set(exploit.dtfl, 1)
    elseif ping >= 55 and contains(ui_get(menu.boxx),'Premium:Doubletap') and ui_get(menu.arctic) and ui_get(exploit.doubletap[2]) then
        ui_set(exploit.sv_maxusrcmdprocessticks[1], 17)
        ui_set(exploit.dtfl, 1)
    else
        ui_set(exploit.sv_maxusrcmdprocessticks[1], 16)
    end
end
client.set_event_callback("setup_command", function (cmd)
if ui_get(menu.arctic) and contains(ui_get(menu.boxx),'Premium:Doubletap') then
    ui_set(exploit.dtmode, cmd.forwardmove == 0 and cmd.sidemove == 0 and "offensive" or "Defensive")
end
end)
dt = function()
    lp = function()
        real_lp = entity.get_local_player()
        if entity.is_alive(real_lp) then
            return real_lp
        else
            obvserver = entity.get_prop(real_lp, "m_hObserverTarget")
            return obvserver ~= nil and obvserver <= 64 and obvserver or nil
        end
    end
    function normalize_yaw(angle)
        angle = (angle % 360 + 360) % 360
        return angle > 180 and angle - 360 or angle
    end
    function world2screen(xdelta, ydelta)
        if xdelta == 0 and ydelta == 0 then
            return 0
        end
        return math.deg(math.atan2(ydelta, xdelta))
    end
    best_player  = function()
        idx = nil
        close = math.huge
        myorigin = {entity.get_origin(lp())}
        myview = {client.camera_angles()}
        enemies = entity.get_players(true)
        for i=1, #enemies do 
            if entity.is_alive(i) and entity.is_enemy(i) and entity.is_dormant(i) == false then
                origin = {entity.get_origin(i)}
                if origin[1] then
                    fov = math.abs(normalize_yaw(world2screen(origin[1] - myorigin[1], origin[2] - myorigin[2]) - myview[2]))
                    if fov < close then
                        idx = i
                        close = fov
                    end
                end
            end
        end
        return idx
    end
    units_to_feet = function(units)
        local units_to_meters = units * 0.0254
        return units_to_meters * 3.281
    end
    on_run_cmd = function(cmd)
        if ui_get(menu.arctic) and contains(ui_get(menu.boxx),'Premium:Doubletap') then
                local_origin = vector(entity.get_prop(entity.get_local_player(), "m_vecAbsOrigin"))
		        distance = local_origin:dist(vector(entity.get_prop(best_player(), "m_vecOrigin")))
                if (distance == nil) then
                    ui.set(exploit.dthc, 1)
                    return
                end
                distance = units_to_feet(distance)
                if distance <= 100 then
                    ui.set(exploit.dthc, math.floor(50 * (distance / 100) + 0.5))
                end
                if distance > 100 then
                    ui.set(exploit.dthc, 50)
                end
            end
        end
    client["set_event_callback"]("run_command", on_run_cmd)
end
dt()
--@Lag mode
local function legfucker()
  if ui_get(menu.arctic) and contains(ui_get(menu.boxx),'Misc:Animation') then
     if yaw_status ~= "DORMANT" then 
        ui_set(exploit.legs_ref, "Always slide")
     else
        ui_set(exploit.legs_ref, "Never slide")
     end
  else
     ui_set(exploit.legs_ref, "Off")
  end
end
client.set_event_callback('paint', legfucker)
client.set_event_callback("pre_render", function()
    local crouching_in_air = entity.get_prop(entity.get_local_player(), "m_fFlags") == 262
    if ui_get(menu.arctic) and ui_get(exploit.doubletap[2]) and contains(ui_get(menu.boxx),'Misc:LC trigger')and crouching_in_air then
        ui_set(exploit.doubletap[1], false)
    else
        ui_set(exploit.doubletap[1], true)
    end
    if ui_get(menu.arctic) and contains(ui_get(menu.boxx),'Misc:TP Peek') then
       if ui_get(rage.quickpeek[2]) and ui_get(exploit.doubletap[2]) then 
          ui.set(exploit.fl_enable, false)
       else
          ui.set(exploit.fl_enable, true)
       end
       if ui_get(rage.quickpeek[2]) and ui_get(exploit.doubletap[2]) and not anti_aim.get_double_tap() then
          ui_set(exploit.sv_maxusrcmdprocessticks[1], 20)
       end
    end
    if ui_get(menu.arctic) and contains(ui_get(menu.boxx),'Misc:Animation') then
       entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 1, 0)
    end
end)
--@Clantag
local duration = 25
local clantags = {
    "emokami",

}
local clantag_prev
client.set_event_callback("paint", function()
 local cur = math.floor(globals.tickcount() / duration) % #clantags
 local clantag = clantags
 if ui_get(menu.arctic) and contains(ui_get(menu.boxx),'Misc:Clantag') then 
    client.set_clan_tag(clantag[cur+1])
 elseif not ui_get(menu.arctic) and contains(ui_get(menu.boxx),'Misc:Clantag') then 
    return 
 end
end)
--@Custom slowmotion
local checkbox_reference, hotkey_reference = ui.reference("AA", "Other", "Slow motion")
local limit_reference = ui.new_slider("AA", "Fake Lag", "Slow value", 1, 60, 37, 60)
ui.set_visible(limit_reference, false)
local function modify_velocity(cmd, goalspeed)
    if goalspeed <= 0 then
        return
    end
    local minimalspeed = math.sqrt((cmd.forwardmove * cmd.forwardmove) + (cmd.sidemove * cmd.sidemove))
    if minimalspeed <= 0 then
        return
    end
    if cmd.in_duck == 1 then
        goalspeed = goalspeed * 2.94117647
    end
    if minimalspeed <= goalspeed then
        return
    end
    local speedfactor = goalspeed / minimalspeed
    cmd.forwardmove = cmd.forwardmove * speedfactor
    cmd.sidemove = cmd.sidemove * speedfactor
end
local function on_setup_cmd(cmd)
  if ui_get(menu.arctic) and contains(ui_get(menu.boxx),'Misc:Slowmotion') then 
    local checkbox = ui.get(checkbox_reference)
    local hotkey = ui.get(hotkey_reference)
    local limit = ui.get(limit_reference)
    if ui.get(checkbox_reference) then
        ui.set(
            limit_reference,
            math.floor(math.random(30 < 50 and 30 or 50, 30 < 50 and 50 or 30))
        )
    end
    if limit >= 57 then
        return
    end
    if checkbox and hotkey then
        modify_velocity(cmd, limit)
    end
  end
end
client.set_event_callback("setup_command", on_setup_cmd)
--@Manual AA
local multi_exec = function(func, list)
    if func == nil then
        return
    end
    
    for ref, val in pairs(list) do
        func(ref, val)
    end
end
local bind_system = {
    left = false,
    right = false,
    back = false,
}
function bind_system:update()
    ui.set(menu.manualleft, "On hotkey")
    ui.set(menu.manualright, "On hotkey")
    ui.set(menu.manualback, "On hotkey")
    local m_state = ui.get(menu.manual_state)
    local left_state, right_state, backward_state = 
        ui.get(menu.manualleft), 
        ui.get(menu.manualright),
        ui.get(menu.manualback)
    if  left_state == self.left and 
        right_state == self.right and
        backward_state == self.back then
        return
    end
    self.left, self.right, self.back = 
        left_state, 
        right_state, 
        backward_state
    if (left_state and m_state == 1) or (right_state and m_state == 2) or (backward_state and m_state == 3) then
        ui.set(menu.manual_state, 0)
        return
    end
    if left_state and m_state ~= 1 then
        ui.set(menu.manual_state, 1)
    end
    if right_state and m_state ~= 2 then
        ui.set(menu.manual_state, 2)
    end
    if backward_state and m_state ~= 3 then
        ui.set(menu.manual_state, 3)
    end
end
local menu_callback = function(e, menu_call)
    local state = not ui_get(menu.arctic) and not contains(ui_get(menu.boxx),'Premium:Directions')
    multi_exec(ui.set_visible, {
        [menu.manualleft] = not state,
        [menu.manualright] = not state,
        [menu.manualback] = not state,
        [menu.manual_state] = false,
    })
end
ui.set_callback(menu.arctic, menu_callback)
local is_valve_ds = ffi.cast('bool*', gamerules[0] + 124)
local function manualaa()
  if ui_get(menu.arctic) and contains(ui_get(menu.boxx),'Premium:Directions') then
    if ui.get(menu.manual_state) == 0 and not ui.get(menu.manual_roll_enablle) then
		ui_set(aa.roll,0)
	end
	if ui.get(menu.manual_state) == 1 and not ui.get(menu.manual_roll_enablle) then
		ui_set(aa.yawbase, "Local view")
		ui_set(aa.yaw[2], -90)
		ui_set(aa.jitter[1],"Off")
		ui_set(aa.bodyyaw[1],"Static")
		ui_set(aa.bodyyaw[2],60)
		ui_set(aa.roll,0)
	end
	if ui.get(menu.manual_state) == 2 and not ui.get(menu.manual_roll_enablle) then
		ui_set(aa.yawbase, "Local view")
		ui_set(aa.yaw[2], 90)
		ui_set(aa.jitter[1],"Off")
		ui_set(aa.bodyyaw[1],"Static")
		ui_set(aa.bodyyaw[2],60)
		ui_set(aa.roll,0)
	end
	if ui.get(menu.manual_state) == 3 and not ui.get(menu.manual_roll_enablle) then
		ui_set(aa.roll,0)
	end
    --manual roll
	if ui.get(menu.manual_state) == 0 and ui.get(menu.manual_roll_enablle) then
        ui_set(aa.yawbase, "At targets")
		ui_set(aa.yaw[2], 0)
		ui_set(aa.jitter[1],"Off")
		ui_set(aa.bodyyaw[1],"Static")
		ui_set(aa.bodyyaw[2],137)
        ui_set(aa.fakeyawlimit,60)
		ui_set(aa.roll,50)
        ui_set(aa.freestandbody, false)
        if contains(ui_get(menu.boxx),'Premium:Fakelag') then 
        ui_set(exploit.amount, 'Maximum')
        ui_set(exploit.variance, '0')
        ui_set(exploit.fakelag, '15')
        end
        is_valve_ds[0] = 0
		sbnum = 75
        yaw_status = "EXTEND"
	end
	if ui.get(menu.manual_state) == 1 and ui.get(menu.manual_roll_enablle) then
		ui_set(aa.yawbase, "Local view")
		ui_set(aa.yaw[2], -90)
		ui_set(aa.jitter[1],"Off")
		ui_set(aa.bodyyaw[1],"Static")
		ui_set(aa.bodyyaw[2],-180)
        ui_set(aa.fakeyawlimit,60)
		ui_set(aa.roll,0)
        if contains(ui_get(menu.boxx),'Premium:Fakelag') then 
        ui_set(exploit.amount, 'Maximum')
        ui_set(exploit.variance, '0')
        ui_set(exploit.fakelag, '15')
        end
		is_valve_ds[0] = 0
		sbnum = 75
        yaw_status = "ROLLING"
	end
	if ui.get(menu.manual_state) == 2 and ui.get(menu.manual_roll_enablle) then
		ui_set(aa.yawbase, "Local view")
		ui_set(aa.yaw[2], 90)
		ui_set(aa.jitter[1],"Off")
		ui_set(aa.bodyyaw[1],"Static")
		ui_set(aa.bodyyaw[2],-180)
        ui_set(aa.fakeyawlimit,60)
		ui_set(aa.roll,0)
        if contains(ui_get(menu.boxx),'Premium:Fakelag') then 
        ui_set(exploit.amount, 'Maximum')
        ui_set(exploit.variance, '0')
        ui_set(exploit.fakelag, '15')
        end
		is_valve_ds[0] = 0
		sbnum = 75
        yaw_status = "ROLLING"
	end
	if ui.get(menu.manual_state) == 3 and ui.get(menu.manual_roll_enablle) then
        ui_set(aa.yawbase, "At targets")
		ui_set(aa.yaw[2], 0)
		ui_set(aa.jitter[1],"Off")
		ui_set(aa.bodyyaw[1],"Static")
		ui_set(aa.bodyyaw[2],137)
        ui_set(aa.fakeyawlimit,60)
		ui_set(aa.roll,50)
        ui_set(aa.freestandbody, false) 
        if contains(ui_get(menu.boxx),'Premium:Fakelag') then 
        ui_set(exploit.amount, 'Maximum')
        ui_set(exploit.variance, '0')
        ui_set(exploit.fakelag, '15')
        end
        is_valve_ds[0] = 0
		sbnum = 75
        yaw_status = "EXTEND"
	end
  end
end
client.set_event_callback("paint", function()
    menu_callback(true, true)
    bind_system:update()
end)
--@Freestanding
local function freestand()
    if ui_get(menu.arctic) and contains(ui_get(menu.boxx),'Premium:Directions') and ui_get(menu.free) then 
        ui_set(aa.freestanding[1], 'Default')
        ui_set(aa.freestanding[2], 'Always on')
    else
        ui_set(aa.freestanding[1], '-')
        ui_set(aa.freestanding[2], 'On hotkey')
    end
end
--@Edgeyaw
local function edgeyaw123()
    if ui_get(menu.arctic) and contains(ui_get(menu.boxx),'Premium:Directions') and ui_get(menu.edge) then 
        ui_set(aa.edgeyaw, true)
    else
        ui_set(aa.edgeyaw, false)
    end
end
--@Legit aa
client.set_event_callback("setup_command",function(e)
    if yaw_status ~= "DORMANT" then 
    local weaponn = entity.get_player_weapon()
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
--@DickMan
local peru = entity.get_local_player( )
client.set_event_callback( "net_update_end", function ( )
    if ui_get(menu.arctic) and contains(ui_get(menu.boxx),'Visuals:DickMan') then
        if entity.is_alive(peru) then
            entity.set_prop(peru,"m_flModelScale", 0.3, 12)
        end
    else
        entity.set_prop(peru,"m_flModelScale", 1, 12)
    end
end)
--@Indicators
--RGB
local function hsv_to_rgb(h, s, v, a)
    local r, g, b
    local i = math.floor(h * 6);
    local f = h * 6 - i;
    local p = v * (1 - s);
    local q = v * (1 - f * s);
    local t = v * (1 - (1 - f) * s);
    i = i % 6
    if i == 0 then r, g, b = v, t, p
    elseif i == 1 then r, g, b = q, v, p
    elseif i == 2 then r, g, b = p, v, t
    elseif i == 3 then r, g, b = p, q, v
    elseif i == 4 then r, g, b = t, p, v
    elseif i == 5 then r, g, b = v, p, q
    end
    return r * 255, g * 255, b * 255, a * 255
end
local function func_rgb_rainbowize(frequency, rgb_split_ratio)
    local r, g, b, a = hsv_to_rgb(globals.realtime() * 0.4 * frequency, 1, 1, 1)
    local r1, g1, b1, a1 = hsv_to_rgb(globals.realtime() * 0.15 * frequency, 1, 1, 1)
    r = r * rgb_split_ratio
    g = g * rgb_split_ratio
    b = b * rgb_split_ratio
    r1 = r1 * rgb_split_ratio
    g1 = g1 * rgb_split_ratio
    b1 = b1 * rgb_split_ratio
    return r, g, b, r1, g1, b1
end
--choke
local OldChoke = 0
local toDraw = 0
client.set_event_callback("setup_command", function(cmd)
	if cmd.chokedcommands < OldChoke then
		toDraw = OldChoke
	end
	OldChoke = cmd.chokedcommands
end)
--debug
local ani = {yaw = 0,yawstate = 0,fl = 0,fakelag = 0,dt = 0,dt_offset = 0,os = 0,onshot = 0,fs = 0,freestand = 0,pk = 0,peek = 0,bm = 0,baim = 0,right = 0,right_a = 0,last_shot = 0,}
function lerp(start, vend, time)
return start + (vend - start) * time end

local function aim_fire() ani.last_shot = globals.curtime() end
local function on_paint()
  if me() == nil or not entity.is_alive(me()) then return end

  local player_crouching = bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"), 4) == 4
  local player_standing = bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"), 1) == 1
  local player_inair = bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"), 1) == 0
  local ideal_charge = round(math.max(0, math.min(100, (globals.curtime() - ani.last_shot) / 0.01)))
  local body_yaw = math.max(-60, math.min(60, round((entity.get_prop(entity.get_local_player(), "m_flPoseParameter", 11) or 0)*120-60+0.5, 1)))
  local health = entity.get_prop(me, "m_iHealth")
  local double_tap, double_tap_key = ui.reference("Rage","Other","Double tap")
  local double_tap_hc = ui.reference("RAGE", "Other", "Double tap hit chance")
  local box, key = ui.reference( "Rage", "Other", "Quick peek assist" )
  local w, h = 75, 20
  local h_index = 0
  local r2, g2, b2, r1, g1, b1 = func_rgb_rainbowize((2/10),1)
  local menux, menuy = ui.menu_position()
  --呼吸灯
  local realtime = globals.realtime() % 3
  local alpha = math.floor(math.sin(realtime * 4) * (255/2-1) + 255/2) or 255
  --水印api
  local js = panorama.open()
  local api = js.MyPersonaAPI
  local name = api.GetName()
  local sys_time = { client.system_time() }
  local actual_time = string.format('%02d:%02d:%02d', sys_time[1], sys_time[2], sys_time[3])
  --WM
  if ui_get(menu.arctic) and contains(ui_get(menu.boxx),'Visuals:Watermaker') then
  local text = string.format("emokami - v3.0.0 | User:%s | Time:%s", name, actual_time)
  local height = renderer.measure_text(nil, text)
  local real_x, real_y =  hk_dragger:get()
    Render_engine.render_container(real_x, real_y,11+height, 25, 255, 255, 255, 255, 230, 100, 10, 1, true)
    renderer.text(real_x+6, real_y+6, 255, 255, 255, 255, "", 0, text)
    hk_dragger:drag(height + 10, 20)
  end
  --@MODE
  if ui_get(menu.arctic) and contains(ui_get(menu.boxx),'Visuals:Indicator') then
    ani.yaw = math.floor(lerp(ani.yaw,255,globals.frametime() * 6))
    ani.yawstate = math.floor(lerp(ani.yaw,255,globals.frametime() * 6))
    if contains(ui_get(menu.boxx),'Premium:Antiaim') then
      renderer.text(x/2, y/2 + 9 + (h_index * 9) + ani.yawstate / 7.67, 240, 128, 128, ani.yaw, "c-",nil, yaw_status)
    else
      renderer.text(x/2, y/2 + 9 + (h_index * 9) + ani.yawstate / 7.67, 253, 162, 180, ani.yaw, "c-",nil, "DEFAULT")
    end
    h_index = h_index + 1
  else
    ani.yaw = math.floor(lerp(ani.yaw,0,globals.frametime() * 6))
    ani.yawstate = math.floor(lerp(ani.yaw,255,globals.frametime() * 6))
    if contains(ui_get(menu.boxx),'Premium:Antiaim') then
      renderer.text(x/2, y/2 + 9 + (h_index * 9) + ani.yawstate / 7.67, 240, 128, 128, ani.yaw, "c-",nil, yaw_status)
    else
      renderer.text(x/2, y/2 + 9 + (h_index * 9) + ani.yawstate / 7.67, 253, 162, 180, ani.yaw, "c-",nil, "DEFAULT")
    end
  end
  --@FL indicator
  if ui_get(menu.arctic) and contains(ui_get(menu.boxx),'Visuals:Indicator') and yaw_status ~= "DORMANT" then 
    ani.fl = math.floor(lerp(ani.fl,255,globals.frametime() * 6))
    ani.fakelag = math.floor(lerp(ani.fl,255,globals.frametime() * 6))
    if yaw_status == "EXTEND" or yaw_status == "ROLLING" then
      renderer.text(x/2, y/2 + 9 + (h_index * 9) + ani.fakelag / 7.67, 240, 255, 255, ani.fl, "c-",nil, "BROKEN")
    elseif anti_aim.get_double_tap() then  
      renderer.text(x/2, y/2 + 9 + (h_index * 9) + ani.fakelag / 7.67, 240, 255, 255, ani.fl, "c-",nil, "WAIT...")
    else
      renderer.text(x/2, y/2 + 9 + (h_index * 9) + ani.fakelag / 7.67, 240, 255, 255, ani.fl, "c-",nil, string.format('FL-%i%%' ,toDraw))
    end
    h_index = h_index + 1
  else
    ani.fl = math.floor(lerp(ani.fl,0,globals.frametime() * 6))
    ani.fakelag = math.floor(lerp(ani.fl,255,globals.frametime() * 6))
    if yaw_status == "EXTEND" or yaw_status == "ROLLING" then
      renderer.text(x/2, y/2 + 9 + (h_index * 9) + ani.fakelag / 7.67, 240, 255, 255, ani.fl, "c-",nil, "BROKEN")
    elseif anti_aim.get_double_tap() then  
      renderer.text(x/2, y/2 + 9 + (h_index * 9) + ani.fakelag / 7.67, 240, 255, 255, ani.fl, "c-",nil, "WAIT...")
    else
      renderer.text(x/2, y/2 + 9 + (h_index * 9) + ani.fakelag / 7.67, 240, 255, 255, ani.fl, "c-",nil, string.format('FL-%i%%' ,toDraw))
    end
  end
  --@DT indicator
  if ui_get(menu.arctic) and ui_get(exploit.doubletap[2]) and contains(ui_get(menu.boxx),'Visuals:Indicator') then 
    ani.dt = math.floor(lerp(ani.dt,255,globals.frametime() * 6))
    ani.dt_offset = math.floor(lerp(ani.dt,255,globals.frametime() * 6))
    if anti_aim.get_double_tap() then
      renderer.text(x/2, y/2 + 9 + (h_index * 9) + ani.dt_offset / 7.67, 150, 225, 60, ani.dt, "c-",nil, string.format("DT [%s]", ui.get(double_tap_hc)))
    else
      renderer.text(x/2, y/2 + 9 + (h_index * 9) + ani.dt_offset / 7.67, 255, 0, 0, ani.dt, "c-",nil, "DT")
    end
    h_index = h_index + 1
  else
    ani.dt = math.floor(lerp(ani.dt,0,globals.frametime() * 6))
    ani.dt_offset = math.floor(lerp(ani.dt,255,globals.frametime() * 6))
    if anti_aim.get_double_tap() then
      renderer.text(x/2, y/2 + 9 + (h_index * 9) + ani.dt_offset / 7.67, 150, 225, 60, ani.dt, "c-",nil, string.format("DT [%s]", ui.get(double_tap_hc)))
    else
      renderer.text(x/2, y/2 + 9 + (h_index * 9) + ani.dt_offset / 7.67, 255, 0, 0, ani.dt, "c-",nil, "DT")
    end
  end
  --@FS indicator
  if ui_get(menu.arctic) and ui_get(menu.free) and contains(ui_get(menu.boxx),'Visuals:Indicator') then
    ani.fs = math.floor(lerp(ani.fs,255,globals.frametime() * 6))
    ani.freestand = math.floor(lerp(ani.fs,255,globals.frametime() * 6))
    renderer.text(x/2, y/2 + 9 + (h_index * 9) + ani.freestand / 7.67, 255, 255, 255, ani.fs, "c-",nil, "FS")
    h_index = h_index + 1
  else
    ani.fs = math.floor(lerp(ani.fs,0,globals.frametime() * 6))
    ani.freestand = math.floor(lerp(ani.fs,255,globals.frametime() * 6))
    renderer.text(x/2, y/2 + 9 + (h_index * 9) + ani.freestand / 7.67, 255, 255, 255, ani.fs, "c-",nil, "FS")
  end
  --@HS indicator
  if ui_get(menu.arctic) and ui_get(exploit.hideshot[1]) and ui_get(exploit.hideshot[2]) and contains(ui_get(menu.boxx),'Visuals:Indicator') then
    ani.os = math.floor(lerp(ani.os,255,globals.frametime() * 6))
    ani.onshot = math.floor(lerp(ani.os,255,globals.frametime() * 6))
    renderer.text(x/2, y/2 + 9 + (h_index * 9) + ani.onshot / 7.67, 255, 255, 255, ani.os, "c-",nil, "OS")
    h_index = h_index + 1
  else
    ani.os = math.floor(lerp(ani.os,0,globals.frametime() * 6))
    ani.onshot = math.floor(lerp(ani.os,255,globals.frametime() * 6))
    renderer.text(x/2, y/2 + 9 + (h_index * 9) + ani.onshot / 7.67, 255, 255, 255, ani.os, "c-",nil, "OS")
  end
  --@BM indicator
  if ui_get(menu.arctic) and ui_get(rage.forcebaim) and contains(ui_get(menu.boxx),'Visuals:Indicator')  then
    ani.bm = math.floor(lerp(ani.bm,255,globals.frametime() * 6))
    ani.baim = math.floor(lerp(ani.bm,255,globals.frametime() * 6))
    renderer.text(x/2, y/2 + 9 + (h_index * 9) + ani.baim / 7.67, 255, 255, 255, ani.bm, "c-",nil, "BAIM")
    h_index = h_index + 1
  else
    ani.bm = math.floor(lerp(ani.bm,0,globals.frametime() * 6))
    ani.baim = math.floor(lerp(ani.bm,255,globals.frametime() * 6))
    renderer.text(x/2, y/2 + 9 + (h_index * 9) + ani.baim / 7.67, 255, 255, 255, ani.bm, "c-",nil, "BAIM")
  end
  --@TP indicator
  if ui_get(menu.arctic) and ui.get(key) and ui.get(double_tap_key) and contains(ui_get(menu.boxx),'Misc:TP Peek') and contains(ui_get(menu.boxx),'Visuals:Indicator') then
    ani.pk = math.floor(lerp(ani.pk,255,globals.frametime() * 6))
    ani.peek = math.floor(lerp(ani.pk,255,globals.frametime() * 6))
  else
    ani.pk = math.floor(lerp(ani.pk,0,globals.frametime() * 6))
    ani.peek = math.floor(lerp(ani.pk,255,globals.frametime() * 6))
  end
  renderer.text(x/2 - 32 + ani.peek / 7.67, y/2 - 35, 255, 140, 0, ani.pk, "c-",nil, "+ IDEAL TICK:"..tostring(ideal_charge)..'% +')
  --@Beta Indicator
  if ui_get(menu.arctic) and contains(ui_get(menu.boxx),'Visuals:Indicator') then
  --  renderer.gradient(x/2-30, y/2+35, w - 14, 1, r2, g2, b2, 255, r1, g1, b1, 255, true)
  --  renderer.gradient(x/2-30, y/2+35, 1, h - 10  , r2, g2, b2, 255, r1, g1, b1, 50, false)  
  --  renderer.gradient(x/2+30, y/2+35, 1, h - 10 , r1, g1, b1, 255, r2, g2, b2, 50, false)  
    if yaw_status ~= "DORMANT" then
      if body_yaw > 0 then
        renderer.text(x/2-11, y/2 + 28, r1,g1,b1,255, "cb", 0, 'emo')
        renderer.text(x/2+11, y/2 + 28, 255, 255, 255, 255, "cb", 0, 'kami')
      else
        renderer.text(x/2-11, y/2 + 28, 255, 255, 255, 255, "cb", 0, 'emo')
        renderer.text(x/2+11, y/2 + 28, r2,g2,b2,255, "cb", 0, 'kami')
      end
    else
      renderer.text(x/2, y/2 + 28, r2,g1,b2,alpha, "cb", 0, 'emokami')
    end
  end
  --@Indicator
  if ui_get(menu.arctic) and contains(ui_get(menu.boxx),'Visuals:Indicator') and ui_get(aa.yaw[2]) == 90 or ui_get(aa.yaw[2]) == -90 then
    ani.right = math.floor(lerp(ani.right,255,globals.frametime() * 3))
    ani.right_a = math.floor(lerp(ani.right,255,globals.frametime() * 3))
  else
    ani.right = math.floor(lerp(ani.right,0,globals.frametime() * 3))
    ani.right_a = math.floor(lerp(ani.right,255,globals.frametime() * 3))
  end
  if ui_get(aa.yaw[2]) == 90 then  
    renderer.text(x/2+50 + ani.right_a / 7.67, y/2-1, 225, 255, 255, ani.right, "cb",nil, "❱")
  end
  if ui_get(aa.yaw[2]) == -90 then  
    renderer.text(x/2-50 - ani.right_a / 7.67, y/2-1, 225, 255, 255, ani.right, "cb",nil, "❰")
  end
  if ui_get(menu.arctic) and ui.is_menu_open() then
    renderer.gradient(menux - 300, menuy + 80, 270, 2, r2, g2, b2, 255, r1, g1, b1, 0, true)
    renderer.gradient(menux - 300, menuy + 348, 270, 2, r1, g1, b1, 0, r2, g2, b2, 255, true)
    renderer.blur(menux - 300, menuy + 80, 270, 270, 0, 0, 0, 100)  
    renderer.text(menux - 170, menuy + 95, 255, 255, 255, 255, 'cb', 0, 'emokami Tech')
    renderer.text(menux - 170, menuy + 115, 255, 127, 0, 255, 'cb', 0, 'Alpha')
	renderer.text(menux - 280, menuy + 230, 255, 255, 255, 255, '-', 0, 'UPDATE  LOG')
	renderer.text(menux - 230, menuy + 230, 0, 255, 0, 255, '-', 0, 'VERSION : 3 . 0 . 0')
    renderer.text(menux - 170, menuy + 130, 255, 255, 255, 200, 'cb', 0, '--------------------------------------------------')
    renderer.text(menux - 170, menuy + 140, 255, 255, 255, 200, 'cb', 0, 'Thanks for using emokami Tech')
    renderer.text(menux - 170, menuy + 150, 255, 255, 255, 200, 'cb', 0, 'Discord:fade#5246')
    renderer.text(menux - 170, menuy + 160, 255, 255, 255, 200, 'cb', 0, 'QQ:932084933')
    renderer.text(menux - 170, menuy + 170, 255, 255, 255, 200, 'cb', 0, 'Welcome valued users')
    renderer.text(menux - 170, menuy + 180, 255, 255, 255, 200, 'cb', 0, 'wish you a happy life')
    renderer.text(menux - 170, menuy + 190, 255, 255, 255, 200, 'cb', 0, 'Secretly said: I love Suzuki♥')
    renderer.text(menux - 170, menuy + 200, 255, 255, 255, 200, 'cb', 0, '--------------------------------------------------')
	renderer.text(menux - 270, menuy + 250, 255, 255, 255, 255, '-', 0, '[+]  OVERAII UI UPDATE')
    renderer.text(menux - 270, menuy + 260, 255, 255, 255, 255, '-', 0, '[+]  IDEAL  TICK  PEEK')
    renderer.text(menux - 270, menuy + 270, 255, 255, 255, 255, '-', 0, '[+]  MORE ADAPTIVE MODES')
    renderer.text(menux - 270, menuy + 280, 255, 255, 255, 255, '-', 0, '[+]  BETTER ANTI-AIM LOGIC')
   -- renderer.text(menux - 270, menuy + 300, 255, 255, 255, 255, '-', 0, '[-]  OLD  INDICATOR')
   -- renderer.text(menux - 270, menuy + 310, 255, 255, 255, 255, '-', 0, '[-]  OLD  WATERMAKER')
	renderer.text(menux - 120, menuy + 320, 255, 225, 255, 255, '-', 0, '[UPDATED]')
	renderer.text(menux - 100, menuy + 330, 0, 255, 0, 255, '-', 0, '2022.07.02')
	renderer.text(menux - 270, menuy + 330, 255, 165, 0, 255, '-', 0, '>> INSECURE  LUAJIT  SYSTEM <<')
  end
end
--@Callbacks
--AA
local function setup_command()
    aathingy()
    aathingy1()
end
--DT / Misc
local function run_command()
    dtoff()
    manualaa()
    freestand()
    edgeyaw123()
end
--Fire
local function start()
    client.set_event_callback("aim_fire", aim_fire)
end
start()
--Menu
local function paint_ui()
    visible()
end
local function setup_it()

    local w, h = client.screen_size()
    local cx, cy = w / 2, h / 2

    if not entity.is_alive(entity.get_local_player()) then
        return
    end
end
client.set_event_callback("paint", setup_it)
client.set_event_callback('run_command', run_command)
client.set_event_callback('setup_command', setup_command)
client.set_event_callback('paint_ui', paint_ui)
client.set_event_callback("paint", on_paint)
client.set_event_callback("shutdown", function()
    ui_set_visible(aa.enabled, true)
    ui_set_visible(aa.pitch, true)
    ui_set_visible(aa.yawbase, true)
    ui_set_visible(aa.yaw[1], true)
    ui_set_visible(aa.yaw[2], true)
    ui_set_visible(aa.bodyyaw[1], true)
    ui_set_visible(aa.bodyyaw[2], true)
    ui_set_visible(aa.fakeyawlimit, true)
    ui_set_visible(aa.jitter[1], true)
    ui_set_visible(aa.jitter[2], true)
    ui_set_visible(aa.freestandbody, true)
    ui_set_visible(aa.edgeyaw, true)
    ui_set_visible(aa.freestanding[1], true)
    ui_set_visible(aa.freestanding[2], true)
    ui_set_visible(aa.roll, true)
--NO AA HEHE
    ui_set(aa.enabled, false)
    ui_set(aa.pitch, "Off")
    ui_set(aa.yawbase, "At targets")
    ui_set(aa.yaw[1], "Off")
    ui_set(aa.yaw[2], 0)
    ui_set(aa.jitter[1], "Off")
    ui_set(aa.jitter[2], 0)
    ui_set(aa.bodyyaw[1], "Off")
    ui_set(aa.bodyyaw[2], 0)
    ui_set(aa.fakeyawlimit, 0)
    ui_set(aa.edgeyaw, false)
    ui_set(aa.freestandbody, false)
    ui_set(aa.roll, 0)
end)
