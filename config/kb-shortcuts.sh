#!/bin/sh
function addCustomMenuEntryIfNeeded
{
    if [[ $# == 0 || $# > 1 ]]
    then
      echo "usage: addCustomMenuEntryIfNeeded com.company.appname"
      return 1
    else
        local contents=`defaults read com.apple.universalaccess "com.apple.custommenu.apps"`
        local grepResults=`echo $contents | grep $1`
        if [[ -z $grepResults ]]
        then
            # does not contain app
            defaults write com.apple.universalaccess "com.apple.custommenu.apps" -array-add "$1"
        fi
    fi
}

function fixKeyboardShortcuts
{
    local CMD="@"
    local CTRL="^"
    local OPT="~"
    local SHIFT="$"
    local TAB="\\U21e5"
    local LEFTWARDS_ARROW="\\U2190"
    local RIGHTWARDS_ARROW="\\U2192"
    local È="\\U00e8"

    # Finder
    defaults write com.apple.Finder NSUserKeyEquivalents "{
        'Afficher l’onglet suivant' = '${OPT}${CMD}${RIGHTWARDS_ARROW}';
        'Afficher l’onglet précédent' = '${OPT}${CMD}${LEFTWARDS_ARROW}';
    }"
    addCustomMenuEntryIfNeeded "com.apple.Finder"

    # Safari
    defaults write com.apple.Safari NSUserKeyEquivalents "{
        'Afficher l’onglet suivant' = '${OPT}${CMD}${RIGHTWARDS_ARROW}';
        'Afficher l’onglet précédent' = '${OPT}${CMD}${LEFTWARDS_ARROW}';
    }"
    addCustomMenuEntryIfNeeded "com.apple.Safari"

    # Notes
    defaults write com.apple.Notes NSUserKeyEquivalents "{
        'Liste à puces' = '${SHIFT}${CMD}!';
        'Liste numérotée' = '${SHIFT}${CMD}${È}';
    }"
    addCustomMenuEntryIfNeeded "com.apple.Notes"

    # Restart cfprefsd, Finder, Safari and Notes for changes to take effect.
    # You may also have to restart any apps that were running when you changed their keyboard shortcuts.
    killall cfprefsd
    killall Finder
    killall Safari
    killall Notes
}

# Run the function
fixKeyboardShortcuts
