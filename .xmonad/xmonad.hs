import XMonad
import XMonad.Config.Xfce
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout
import XMonad.Layout.Accordion
import XMonad.Layout.Circle
import XMonad.Layout.Dishes
import XMonad.Layout.Grid
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig

import qualified XMonad.StackSet as W

workspacesList = map show [1..9]

customLayoutHook =
    full ||| tiled ||| tiledMirror ||| Grid ||| Accordion ||| Circle
  where
    tiled       = spacing 0 $ Tall master delta ratio
    tiledMirror = spacing 0 $ Mirror $ Tall master delta ratio
    defaultTall = ResizableTall 1 (1/100) (1/2) []
    master      = 1
    ratio       = 1/2
    delta       = 1/100
    full        = spacing 0 $ Full

customManageHook = compHook <+> manageHook xfceConfig
    where compHook = composeAll
                 [ className =? "Firefox" --> doShift "5" ]

customKeys =
      [ (( mod1Mask, xK_Print ), spawn "gnome-screenshot")
      , (( mod1Mask .|. shiftMask , xK_Print ), spawn "gnome-screenshot -w")
      , (( controlMask .|. shiftMask , xK_Print ), spawn "gnome-screenshot -a")
      ]

main = do
    xmonad $ xfceConfig {
        layoutHook         = avoidStruts $ customLayoutHook
      , workspaces         = workspacesList
      , modMask            = mod1Mask
      , terminal           = "xfce4-terminal"
      , manageHook         = customManageHook
      , focusFollowsMouse  = True
    } `additionalKeys` customKeys
