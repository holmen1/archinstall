import XMonad
import XMonad.Util.EZConfig
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Magnifier
import XMonad.Hooks.EwmhDesktops

main :: IO ()
main = xmonad $ ewmhFullscreen $ ewmh $ myConfig

myTerminal      = "kitty"
myModMask       = mod4Mask -- Rebind Mod to the Super key

myConfig = def
    { modMask    = mod4Mask,  -- Rebind Mod to the Super key
      terminal = myTerminal,
      layoutHook = myLayout  -- Use custom layouts
    }
  `additionalKeysP`
    [ ("M-S-z", spawn "xscreensaver-command -lock")
    , ("M-C-s", unGrab *> spawn "scrot -s"        )
    , ("M-f"  , spawn "firefox"                   )
    ]

myLayout = tiled ||| Mirror tiled ||| Full ||| threeCol
  where
    threeCol = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes



    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)


    -- Restart xmonad
    --, ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
