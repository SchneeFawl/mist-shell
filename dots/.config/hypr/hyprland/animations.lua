hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("standard",       { type = "bezier", points = { {0.3, 0.9},   {0.1, 1.05}  } })
hl.curve("fluid",          { type = "bezier", points = { {0.16, 0.86}, {0.35, 1.0}  } })
hl.curve("overshoot",      { type = "bezier", points = { {0.1, 0.9},   {0.2, 1.05}   } })
hl.curve("mid_snap",       { type = "bezier", points = { {0.15, 1.0},  {0.18, 1.0}  } })
hl.curve("popup",          { type = "bezier", points = { {0.10, 1.0},  {0.25, 1.0}     } })


hl.animation({ leaf = "global",           enabled = true,  speed = 7,    bezier = "standard" })
hl.animation({ leaf = "windowsIn",        enabled = true,  speed = 5,    bezier = "overshoot", style = "popin 78%" })
hl.animation({ leaf = "windowsOut",       enabled = true,  speed = 3,    bezier = "standard", style = "popin 78%" })
hl.animation({ leaf = "border",           enabled = true,  speed = 10,   bezier = "linear" })
hl.animation({ leaf = "borderangle",      enabled = true,  speed = 25,   bezier = "linear" })

hl.animation({ leaf = "fade",             enabled = true,  speed = 5,    bezier = "fluid" })
hl.animation({ leaf = "fadeIn",           enabled = true,  speed = 3.5,  bezier = "fluid" })
hl.animation({ leaf = "fadeOut",          enabled = true,  speed = 3.5,  bezier = "fluid" })

hl.animation({ leaf = "layersIn",         enabled = true,  speed = 4,    bezier = "popup", style = "popin 80%" })
hl.animation({ leaf = "layersOut",        enabled = true,  speed = 2.5,  bezier = "overshoot", style = "fade" })
hl.animation({ leaf = "fadeLayersIn",     enabled = true,  speed = 4,    bezier = "mid_snap" })
hl.animation({ leaf = "fadeLayersOut",    enabled = true,  speed = 3,    bezier = "mid_snap" })

hl.animation({ leaf = "workspaces",       enabled = true,  speed = 4.5,  bezier = "overshoot", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true,  speed = 4,    bezier = "overshoot", style = "slidevert" })

hl.animation({ leaf = "zoomFactor",       enabled = true,  speed = 6.5,    bezier = "standard" })
