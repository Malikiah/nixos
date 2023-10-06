import XMonad

import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Config.Xfce

import qualified XMonad.StackSet as W -- to shift and float windows import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.EwmhDesktops(ewmhFullscreen)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageDocks (avoidStruts)
import XMonad.Hooks.ManageHelpers (doRectFloat, isDialog, isInProperty, isFullscreen, doFullFloat, doCenterFloat)
import XMonad.Actions.PhysicalScreens
import XMonad.Actions.OnScreen
import XMonad.Actions.Volume

import XMonad.Layout.LayoutModifier
import XMonad.Layout.IndependentScreens
import XMonad.Layout.Fullscreen
import XMonad.Layout.Spacing
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.NoBorders

import XMonad.Actions.CycleWS

import Graphics.X11.ExtraTypes.XF86 (xF86XK_AudioLowerVolume, xF86XK_AudioRaiseVolume, xF86XK_AudioMute)
			
main :: IO ()
-- ewmhFullscreen . ewmh for fullscreening youtube videos or other videos in a browser.
main = xmonad ( ewmhFullscreen . ewmh $ def
        { modMask = myModMask
        , terminal = (myTerminal)
--        , workspaces         = myWorkspaces
        , borderWidth        = myBorderWidth
        , normalBorderColor  = myNormColor
        , focusedBorderColor = myFocusColor
        , layoutHook =  myLayout 
        , manageHook = manageHook def <+> myManageHook <+> manageDocks
        }
        
        `additionalKeysP` myKeys
        )



myModMask = mod4Mask

-- toggleLayouts choice between (noBorders Full) and (Tiled)
myLayout = lessBorders OnlyFloat $ avoidStruts $ toggleLayouts (noBorders Full) (myTile)  -- Add other layouts if needed
         where 
              myTile = spacingRaw False (Border 10 0 10 0) True (Border 0 10 0 10) True $ smartBorders $ Tall 1 0.03 0.5

-- myWorkspaces :: [String]
-- myWorkspaces = withScreens 2 [" 1 ", " 2 ", " 3 ", " 4 ", " 5 "]

myBorderWidth :: Dimension
myBorderWidth = 3          -- Sets border width for windows

myFocusColor :: String      -- Border color of focused windows
-- myFocusColor = "#5f5286"     -- This variable is imported from Colors.THEME
-- myFocusColor = "#2e649e"
myFocusColor = "#226fc1"

myNormColor :: String
myNormColor = "#000000"

myTerminal :: String
myTerminal = "alacritty"

myBrowser :: String
myBrowser = "brave"

mySearch :: String
--mySearch = "xfce4-appfinder"
mySearch = "rofi -show drun -theme 'spotlight-dark' -font 'hack 10' -icon-theme 'Mkos-Big-Sur-Night' -show-icons"

myLockscreen :: String
--myLockscreen = "xflock4"
myLockscreen = "qdbus org.kde.ksmserver /ScreenSaver org.freedesktop.ScreenSaver.Lock"

myScreenshot :: String
myScreenshot = "spectacle -r"


-- This is for ignoring all KDE Plasma Taskbar items
skipPopUp :: Query Bool
skipPopUp = isInProperty "_NET_WM_WINDOW_TYPE" "_KDE_NET_WM_WINDOW_TYPE_APPLET_POPUP" -- You can use the xprop command to get the properties aswell

skipLaunchPad :: Query Bool
skipLaunchPad = isInProperty "_NET_WM_WINDOW_TYPE" "_KDE_NET_WM_WINDOW_TYPE_OVERRIDE" -- You can use the xprop command to get the properties aswell

skipEditTaskbar :: Query Bool
skipEditTaskbar = isInProperty "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_DOCK" 
skipEditDesktop :: Query Bool
skipEditDesktop = isInProperty "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_DESKTOP"

myManageHook:: ManageHook
myManageHook = composeAll
    [ isDialog --> doFloat
    , isFullscreen --> doFullFloat
    , className =? "Xfce4-settings-manager" --> doFullFloat
    , className =? "Xfce4-appfinder" --> doFullFloat
    , className =? "Blueberry.py" --> doCenterFloat
    , className =? "Pavucontrol" --> doCenterFloat
    , className =? "Xfdesktop-settings" --> doCenterFloat
    , className =? "Wrapper-2.0" --> doCenterFloat
    , className =? "ksmserver-logout-greeter" --> doFloat
    , className =? "Plasma-desktop" --> doFloat
    , (className =? "plasmashell" <&&> skipPopUp) --> doIgnore <+> hasBorder False
    , (className =? "plasmashell" <&&> skipLaunchPad) --> doCenterFloat <+> hasBorder False
    , (className =? "plasmashell" <&&> skipEditTaskbar) --> doFloat <+> hasBorder False
    , (className =? "plasmashell" <&&> skipEditDesktop) --> doFloat <+> hasBorder False

--    , className =? "plasmashell" --> doFloat -- You can use the xprop command to get class name WM_CLASS(STRING) = "plasmashell", "plasmashell"
--    , (className =? "plasmashell" <&&> checkSkipTaskbar) --> doIgnore <+> hasBorder False
    ]
-- myManageHook = composeAll
--     [ className =? "ksmserver-logout-greeter" --> doFloat
--     , isDialog --> doFloat
--     , isFullscreen --> doFullFloat
-- --
-- -- This is for ignoring all plasma items from xmonad
-- --
--     , className =? "Plasma-desktop" --> doFloat
--     , className =? "plasmashell" --> doFloat -- You can use the xprop command to get class name WM_CLASS(STRING) = "plasmashell", "plasmashell"
--     , (className =? "plasmashell" <&&> checkSkipTaskbar) --> doIgnore <+> hasBorder False
--     ]

myKeys :: [(String, X ())]
-- https://xmonad.org/manpage.html
myKeys = [ 
        ("M-S-q", spawn(myLockscreen)) 
        , ("M-b", spawn (myBrowser))
        -- send the Toggle message "Full" from myLayout under the layoutHook
        , ("M-f", sendMessage $ Toggle "Full")
	, ("M-p", spawn(mySearch))
	, ("M-S-s", spawn(myScreenshot))
--        , (xF86XK_AudioRaiseVolume, spawn("amixer set Master 5%+"))
--        , (xF86XK_AudioLowerVolume, spawn("amixer set Master 5%-"))
--        , (xF86XK_AudioMute, spawn("amixer set Master toggle"))
        ]

