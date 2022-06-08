local C = {
    "setup_command",
    "new_checkbox",
    "Quick peek assist mode",
    "Other",
    "paint_ui",
    "[Kazune]Artificial Intelligence Peek DMG",
    "indicator",
    "RAGE",
    "reference",
    "rad",
    "[Kazune]Artificial Intelligence Peek Range",
    "Expected DMG:",
    "circle",
    "forwardmove",
    "Rage",
    "set",
    "Retreat on key release",
    "trace_bullet",
    "\065\117\116\111\032\080\101\101\107\032\045\062\032\082\101\116\114\101\097\116\032\111\110\032\107\101\121\032\114\101\108\101\097\115\101",
    "camera_angles",
    "set_event_callback",
    "new_slider",
    "sin",
    "get_local_player",
    "hitbox_position",
    "KAZUNE ANTI-BAIT",
    "delay_call",
    "visible",
    "spd",
    "get",
    "trace_line",
    "new_hotkey",
    "unset_event_callback",
    "[Kazune]Artificial Intelligence Peek",
    "move_yaw",
    "cos",
    "eye_position",
    "Retreat on shot",
    "aim_fire",
    "paint",
    "move",
    "get_players",
    "world_to_screen"
}
do
    local S, E = 1, 43
    while S < E do
        C[S], C[E] = C[E], C[S]
        S, E = S + 1, E - 1
    end
    S, E = 1, 27
    while S < E do
        C[S], C[E] = C[E], C[S]
        S, E = S + 1, E - 1
    end
    S, E = 28, 43
    while S < E do
        C[S], C[E] = C[E], C[S]
        S, E = S + 1, E - 1
    end
end
local function X(S)
    return C[S + 56122]
end
local S, E, u, B, J, H, G =
    client[X(-56101)],
    client[X(-56107)],
    entity[X(-56114)],
    entity[X(-56096)],
    entity[X(-56113)],
    renderer[X(-56082)],
    renderer[X(-56095)]
local F = ui[X(-56106)](X(-56087), X(-56091), X(-56104), false)
local M = ui[X(-56086)](X(-56080), X(-56091), X(-56092))
local a = ui[X(-56093)](X(-56080), X(-56091), X(-56119))
local c = ui[X(-56116)](X(-56087), X(-56091), X(-56084), 0, 100)
local d = ui[X(-56116)](X(-56087), X(-56091), X(-56089), 0, 100)
local k = 0
local v = 450
local function x(S)
    print(X(-56097) .. (k .. (X(-56109) .. v)))
    local E, u = client[X(-56118)]()
    S[X(-56103)] = k
    S[X(-56081)] = v
end
local function f()
    client[X(-56105)](X(-56094), x)
end
local function r()
    local E, H = client[X(-56118)]()
    if not ui[X(-56108)](F) then
        client[X(-56105)](X(-56094), x)
        if ui[X(-56108)](a) then
            ui[X(-56079)](M, {X(-56100), X(-56121)})
        else
            ui[X(-56079)](M, {X(-56100)})
        end
        return
    end
    renderer[X(-56088)](255, 255, 0, 255, X(-56083) .. ui[X(-56108)](d))
    ui[X(-56079)](M, {X(-56100)})
    local G = u()
    local f, r, I = S()
    renderer[X(-56088)](0, 255, 255, 255, X(-56112))
    local w = B(true)
    for S = 1, #w, 1 do
        local E = w[S]
        local u, B, F = J(E, 3)
        local M = ui[X(-56108)](c)
        local a = {}
        local C = {}
        local W = {}
        local g = {}
        local A = 0
        local L = 0
        local o = false
        for S = 1, 12, 1 do
            local E = S * 20 - 120
            a[S] = math[X(-56102)](math[X(-56085)](H - E)) * M
            C[S] = math[X(-56115)](math[X(-56085)](H - E)) * M
            o, g[S] = client[X(-56120)](G, f + a[S], r + C[S], I, u, B, F, true)
            local J = client[X(-56110)]((f + a[S]) + 2, (r + C[S]) + 2, I)
            local c = J and 255 or 0
            if J then
                if g[S] > L then
                    L = g[S]
                    A = H - E
                end
            end
            W[S] = {renderer[X(-56095)](f + a[S], r + C[S], I)}
            if W[S][1] ~= nil then
                renderer[X(-56082)](W[S][1] - 2, W[S][2] - 2, 255, c, 0, 255, 4, 0, 1)
            end
        end
        local n = ui[X(-56108)](d)
        k = A
        if L > n then
            v = 450
            client[X(-56117)](X(-56094), x)
        else
            v = -450
            client[X(-56105)](X(-56094), x)
        end
    end
end
local function I()
    client[X(-56117)](X(-56098), r)
    k = 0
    v = 450
    dmg_highest = 0
end
I()
local function w()
    client[X(-56105)](X(-56098), r)
    v = -450
    client[X(-56111)](0.5, f)
    client[X(-56111)](1, I)
end
client[X(-56117)](
    X(-56090),
    function()
        if ui[X(-56108)](F) then
            client[X(-56117)](X(-56099), w)
        else
            client[X(-56105)](X(-56099), w)
        end
    end
)
