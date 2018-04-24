import XMonad
import XMonad.Config.Xfce
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig

import qualified XMonad.StackSet as W

workspacesList = map show [1..18]

customLayoutHook =
    onWorkspace (workspacesList !! 5 ) ( full ) $
    full ||| tiled
  where
    tiled       = spacing 0 $ Tall master delta ratio
    defaultTall = ResizableTall 1 (1/100) (1/2) []
    master      = 1
    ratio       = 1/2
    delta       = 1/100
    full        = spacing 0 $ Full

customManageHook = compHook <+> manageHook xfceConfig
    where compHook = composeAll
                 [ className =? "Firefox" --> doShift "5" ]

customKeys =
      [ (( mod4Mask, xK_Print ), spawn "gnome-screenshot")
      , (( mod4Mask .|. shiftMask , xK_Print ), spawn "gnome-screenshot -w")
      , (( controlMask .|. shiftMask , xK_Print ), spawn "gnome-screenshot -a")
      -- additional workspaces switching keys
      , (( mod4Mask, xK_0), windows $ W.greedyView "10")
      , (( mod4Mask .|. shiftMask, xK_0), windows $ W.shift "10")
      , (( mod4Mask, xK_F1), windows $ W.greedyView "11")
      , (( mod4Mask .|. shiftMask, xK_F1), windows $ W.shift "11")
      , (( mod4Mask, xK_F2), windows $ W.greedyView "12")
      , (( mod4Mask .|. shiftMask, xK_F2), windows $ W.shift "12")
      , (( mod4Mask, xK_F3), windows $ W.greedyView "13")
      , (( mod4Mask .|. shiftMask, xK_F3), windows $ W.shift "13")
      , (( mod4Mask, xK_F4), windows $ W.greedyView "14")
      , (( mod4Mask .|. shiftMask, xK_F4), windows $ W.shift "14")
      , (( mod4Mask, xK_F5), windows $ W.greedyView "15")
      , (( mod4Mask .|. shiftMask, xK_F5), windows $ W.shift "15")
      , (( mod4Mask, xK_F6), windows $ W.greedyView "16")
      , (( mod4Mask .|. shiftMask, xK_F6), windows $ W.shift "16")
      , (( mod4Mask, xK_F7), windows $ W.greedyView "17")
      , (( mod4Mask .|. shiftMask, xK_F7), windows $ W.shift "17")
      , (( mod4Mask, xK_F8), windows $ W.greedyView "18")
      , (( mod4Mask .|. shiftMask, xK_F8), windows $ W.shift "18")
      ]

main = do
    xmonad $ xfceConfig {
        layoutHook         = avoidStruts $ customLayoutHook
      , workspaces         = workspacesList
      , modMask            = mod4Mask
      , terminal           = "xfce4-terminal"
      , manageHook         = customManageHook
      , focusFollowsMouse  = True
    } `additionalKeys` customKeys
