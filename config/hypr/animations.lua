-- animations.lua
-- Xero Hyprland Animation Profile

-----------------------------------------------------------
-- Curves
-----------------------------------------------------------

hl.curve("xeroEase", {
	type = "bezier",
	points = {
		{ 0.23, 1.00 },
		{ 0.32, 1.00 },
	},
})

hl.curve("xeroSmooth", {
	type = "bezier",
	points = {
		{ 0.40, 0.00 },
		{ 0.20, 1.00 },
	},
})

hl.curve("xeroFast", {
	type = "bezier",
	points = {
		{ 0.15, 0.00 },
		{ 0.10, 1.00 },
	},
})

hl.curve("xeroLinear", {
	type = "bezier",
	points = {
		{ 0.00, 0.00 },
		{ 1.00, 1.00 },
	},
})

hl.curve("xeroSpring", {
	type = "spring",
	mass = 1,
	stiffness = 238.1191,
	dampening = 24.21279333,
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
-- Borders
-----------------------------------------------------------

hl.animation({
	leaf = "border",
	enabled = true,
	speed = 5,
	bezier = "xeroEase",
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
	spring = "xeroSpring",
	style = "popin 87%",
})

hl.animation({
	leaf = "windowsOut",
	enabled = true,
	speed = 1.6,
	bezier = "xeroLinear",
	style = "popin 87%",
})

-----------------------------------------------------------
-- Fading
-----------------------------------------------------------

hl.animation({
	leaf = "fade",
	enabled = true,
	speed = 3,
	bezier = "xeroFast",
})

hl.animation({
	leaf = "fadeIn",
	enabled = true,
	speed = 1.8,
	bezier = "xeroSmooth",
})

hl.animation({
	leaf = "fadeOut",
	enabled = true,
	speed = 1.4,
	bezier = "xeroSmooth",
})

-----------------------------------------------------------
-- Layers
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
	speed = 4,
	bezier = "xeroEase",
	style = "fade",
})

hl.animation({
	leaf = "layersOut",
	enabled = true,
	speed = 1.5,
	bezier = "xeroLinear",
	style = "fade",
})

-----------------------------------------------------------
-- Workspace
-----------------------------------------------------------

hl.animation({
	leaf = "workspaces",
	enabled = true,
	speed = 2,
	bezier = "xeroSmooth",
	style = "fade",
})

hl.animation({
	leaf = "workspacesIn",
	enabled = true,
	speed = 1.3,
	bezier = "xeroSmooth",
	style = "fade",
})

hl.animation({
	leaf = "workspacesOut",
	enabled = true,
	speed = 2,
	bezier = "xeroSmooth",
	style = "fade",
})

-----------------------------------------------------------
-- Zoom
-----------------------------------------------------------

hl.animation({
	leaf = "zoomFactor",
	enabled = true,
	speed = 7,
	bezier = "xeroFast",
})
