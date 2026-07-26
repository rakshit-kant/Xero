-- animations.lua
-- Xero Hyprland Animation Profile

-----------------------------------------------------------
-- Curves
-----------------------------------------------------------

hl.curve("xeroEase", {
	type = "bezier",
	points = {
		{ 0.22, 1.0 },
		{ 0.36, 1.0 },
	},
})

hl.curve("xeroSmooth", {
	type = "bezier",
	points = {
		{ 0.4, 0 },
		{ 0.2, 1 },
	},
})

hl.curve("xeroFast", {
	type = "bezier",
	points = {
		{ 0.1, 0 },
		{ 0.9, 1 },
	},
})

hl.curve("xeroSpring", {
	type = "spring",
	mass = 1,
	stiffness = 180,
	damping = 18,
})

-----------------------------------------------------------
-- Global
-----------------------------------------------------------

hl.animation({
	leaf = "global",
	enabled = true,
	speed = 8,
	bezier = "xeroSmooth",
})

-----------------------------------------------------------
-- Windows
-----------------------------------------------------------

hl.animation({
	leaf = "windows",
	enabled = true,
	speed = 5,
	spring = "xeroSpring",
})

hl.animation({
	leaf = "windowsIn",
	enabled = true,
	speed = 4,
	bezier = "xeroEase",
	style = "popin 85%",
})

hl.animation({
	leaf = "windowsOut",
	enabled = true,
	speed = 3,
	bezier = "xeroSmooth",
	style = "popin 85%",
})

-----------------------------------------------------------
-- Fading
-----------------------------------------------------------

hl.animation({
	leaf = "fade",
	enabled = true,
	speed = 4,
	bezier = "xeroSmooth",
})

hl.animation({
	leaf = "fadeIn",
	enabled = true,
	speed = 3,
	bezier = "xeroSmooth",
})

hl.animation({
	leaf = "fadeOut",
	enabled = true,
	speed = 2.5,
	bezier = "xeroFast",
})

-----------------------------------------------------------
-- Borders
-----------------------------------------------------------

hl.animation({
	leaf = "border",
	enabled = true,
	speed = 4,
	bezier = "xeroEase",
})

-----------------------------------------------------------
-- Layers / Popups
-----------------------------------------------------------

hl.animation({
	leaf = "layers",
	enabled = true,
	speed = 4,
	bezier = "xeroEase",
})

hl.animation({
	leaf = "layersIn",
	enabled = true,
	speed = 3.5,
	bezier = "xeroEase",
	style = "fade",
})

hl.animation({
	leaf = "layersOut",
	enabled = true,
	speed = 2.5,
	bezier = "xeroSmooth",
	style = "fade",
})

-----------------------------------------------------------
-- Workspaces
-----------------------------------------------------------

hl.animation({
	leaf = "workspaces",
	enabled = true,
	speed = 3,
	bezier = "xeroSmooth",
	style = "slide",
})

hl.animation({
	leaf = "workspacesIn",
	enabled = true,
	speed = 3,
	bezier = "xeroSmooth",
	style = "slide",
})

hl.animation({
	leaf = "workspacesOut",
	enabled = true,
	speed = 3,
	bezier = "xeroSmooth",
	style = "slide",
})

-----------------------------------------------------------
-- Zoom
-----------------------------------------------------------

hl.animation({
	leaf = "zoomFactor",
	enabled = true,
	speed = 6,
	bezier = "xeroFast",
})
