import XMonad hiding ( (|||) )
import XMonad.Config.Kde
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Layout hiding ( (|||) )
import XMonad.Layout.Accordion
import XMonad.Layout.Grid
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.Named
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig
import System.IO

defaultSpacing = 0
workspacesList = map show [1..8]

customLayoutHook =
  onWorkspace (workspacesList !! 4 ) ( Full ||| tiled ||| Accordion ) $
  tiled ||| mirrored ||| Grid ||| Full ||| Accordion
  where
    tiled       = named "tiled" $
                  spacing defaultSpacing $
                  Tall master delta ratio
    mirrored    = named "mirrored" $
                  spacing defaultSpacing $
                  Mirror $
                  Tall master delta ratio
    master      = 1
    ratio       = 1/2
    delta       = 1/100

customManageHook = manageDocks <+> manageHook kde4Config

customKeys =
      [ (( mod4Mask, xK_Print ), spawn "spectacle")
      , (( mod4Mask .|. shiftMask, xK_Print ), spawn "spectacle -a")
      , (( controlMask .|. shiftMask, xK_Print ), spawn "spectacle -r")
      , (( mod4Mask, xK_F1), sendMessage $ JumpToLayout "tiled")
      , (( mod4Mask, xK_F2), sendMessage $ JumpToLayout "mirrored")
      , (( mod4Mask, xK_F3), sendMessage $ JumpToLayout "Grid")
      , (( mod4Mask, xK_F4), sendMessage $ JumpToLayout "Full")
      , (( mod4Mask, xK_F5), sendMessage $ JumpToLayout "Accordion")
      ]

main = do
    xmonad $ withUrgencyHook NoUrgencyHook $ kde4Config {
        layoutHook         = avoidStruts $ customLayoutHook
      , workspaces         = workspacesList
      , modMask            = mod4Mask
      , terminal           = "konsole"
      , borderWidth        = 2
      , normalBorderColor  = "#43484d"
      , focusedBorderColor = "#387ea3"
      , manageHook         = customManageHook
      , focusFollowsMouse  = True
    } `additionalKeys` customKeys
      `removeKeys` [ (mod4Mask, xK_space)
                   , (mod4Mask .|. shiftMask, xK_space)]

