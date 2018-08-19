import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Layout
import XMonad.Layout.Accordion
import XMonad.Layout.Circle
import XMonad.Layout.Dishes
import XMonad.Layout.Grid
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig
import XMonad.Util.Run (spawnPipe)
import System.IO

import qualified XMonad.StackSet as W

browserSpacing = 75
defaultSpacing = 3
workspacesList = map show [1..9]

customLayoutHook =
    onWorkspace (workspacesList !! 1 ) ( full ||| accordionSp ||| gridSp ) $
    onWorkspace (workspacesList !! 4 ) ( fullSp ||| full ||| tiled ) $
    accordionSp ||| tiled ||| tiledMirror ||| circleSp ||| gridSp ||| full ||| fullSp
  where
    tiled       = spacing defaultSpacing $ Tall master delta ratio
    tiledMirror = spacing defaultSpacing $ Mirror $ Tall master delta ratio
    full        = spacing defaultSpacing $ Full
    fullSp      = spacing browserSpacing $ Full
    gridSp      = spacing defaultSpacing $ Grid
    accordionSp = spacing defaultSpacing $ Accordion
    circleSp    = spacing defaultSpacing $ Circle
    defaultTall = ResizableTall 1 (1/100) (1/2) []
    master      = 1
    ratio       = 1/2
    delta       = 1/100

customManageHook = manageDocks <+> compHook <+> manageHook defaultConfig
    where compHook = composeAll
                 [ className =? "Firefox" --> doShift "5" ]

customLogHook xmproc = dynamicLogWithPP $ compPP { ppOutput = hPutStrLn xmproc }
  where
    compPP      = defaultPP {
    ppHidden    = xmobarColor "#a9acb6" ""
    , ppCurrent = xmobarColor "#e2e2e2" "" . wrap "[" "]"
    , ppUrgent  = xmobarColor "#a9acb6" "" . wrap "*" "*"
    , ppLayout  = xmobarColor "#ff0000" ""
    , ppTitle   = (\str -> "")
    , ppOrder   = \(ws:_:t:_) -> [ws, t]
    , ppSep     = "<fc=#a9acb6> | </fc>"
    }

customKeys =
      [ (( mod4Mask, xK_Print ), spawn "gnome-screenshot")
      , (( mod4Mask .|. shiftMask , xK_Print ), spawn "gnome-screenshot -w")
      , (( controlMask .|. shiftMask , xK_Print ), spawn "gnome-screenshot -a")
      ]

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/mathcrosp/.xmonad/xmobarrc.hs"
    spawn "setxkbmap -layout 'us,ru' -option gpr:caps_toggle"
    xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig {
        layoutHook         = avoidStruts $ customLayoutHook
      , workspaces         = workspacesList
      , modMask            = mod4Mask
      , terminal           = "xfce4-terminal"
      , borderWidth        = 3
      , normalBorderColor  = "#687c97"
      , focusedBorderColor = "#d2d2d2"
      , manageHook         = customManageHook
      , logHook            = customLogHook xmproc
      , focusFollowsMouse  = False
    } `additionalKeys` customKeys
