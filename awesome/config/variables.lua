local vars = {}

vars.modkey         = "Mod4"
vars.altkey         = "Mod1"
vars.ctrlkey        = "Control"
vars.terminal       = os.getenv("TERMINAL") or "kitty"
vars.browser        = os.getenv("BROWSER") or "librewolf"
vars.filemanager    = os.getenv("FILEMANAGER") or "ranger"
vars.ide	        = os.getenv("EDITOR") or "nvim"


vars.font           = "Manrope Bold"
vars.theme          = "default"
vars.gap            = 5


vars.dnd            = false
vars.zen            = false
vars.mic            = false
vars.vol            = true

vars.github_token   = ""

return vars
