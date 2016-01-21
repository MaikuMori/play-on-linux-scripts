#!/usr/bin/env playonlinux-bash
# Date : (2015-12-16 19:57)
# Last revision : (2015-12-16 19:57)
# Wine version used : 1.8-rc4
# Distribution used to test : ArchLinux
# Author : Maiku Mori

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="SketchUp"
PREFIX="SketchUp"
WORKING_WINE_VERSION="1.8-rc4"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Trimble" "http://www.sketchup.com" "Maiku Mori" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_System_TmpCreate "$PREFIX"

Set_OS "winxp"

# Needed for warehouse browser, etc.
POL_Call POL_Install_ie8

Set_OS "win7"

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"

if [ "$INSTALL_METHOD" = "DOWNLOAD" ]; then
    DOWNLOAD_LINK="http://dl.trimble.com/sketchup/SketchUpMake-en.exe"
    cd "$POL_System_TmpDir"
    POL_Download "$DOWNLOAD_LINK" ""
    POL_Wine_WaitBefore "$TITLE"
    EXE_FILE="${DOWNLOAD_LINK##*/}"
    POL_Wine start /unix ${EXE_FILE}
    POL_Wine_WaitExit "$TITLE"
fi

if [ "$INSTALL_METHOD" = "LOCAL" ]; then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine start /unix "$APP_ANSWER"
    POL_Wine_WaitExit "$TITLE"
fi

POL_Wine_SetVideoDriver

POL_System_TmpDelete

POL_Shortcut "SketchUp.exe" "$TITLE"

POL_SetupWindow_Close

exit
