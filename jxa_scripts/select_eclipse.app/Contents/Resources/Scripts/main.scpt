JsOsaDAS1.001.00bplist00?Vscript_	?//
// JXA script to select an Eclipse Instance by workspace.
//
// Copyright (C) 2022 Richard Reingruber
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
//
// Comments
//
//   - This file has the suffix .xsscpt because Script Editor.app won't open .js files
//
//   - test with osascript -l JavaScript select_ecipse.scpt
//
//   - Assigning a system wide keyboard shortcut did not work well for me
//     (e.g. using Shortcuts.app).  Instead I opened this script in Script
//     Editor.app and exported it as an app in ~/Applications which I open with
//     spotlight search (cmd + space)
//

var app = Application.currentApplication()
var Sys = Application('System Events')
var windowNames = Sys.applicationProcesses.where({name: "Eclipse"}).windows.name()
// windowNames.forEach(k => console.log(k))
windowNames = windowNames.map(String)

// Prepare to show dialog to make selection
app.includeStandardAdditions = true;
app.activate();

if (windowNames.length < 1) {
    app.displayDialog("No Eclipse windows found.");
} else {
    var selected = app.chooseFromList(windowNames, { withPrompt: "Select Eclipse Instance:" })
    selected = selected[0]
    //console.log("selected: " + selected)

    // debugger  // uncomment to break into (Safari) JS debugger when running in Script Editor.app

    var eclApps = Sys.applicationProcesses.where({name: "Eclipse"})

    // The following works
    //     eclApps[0].frontmost = true
    //     eclApps[1].windows.name()
    //     eclApps[1].windows.name()[0] === "sapjvm_dev - HotSpot/hotspot_src/share/opto/compile.cpp - Eclipse IDE"

    // `eclApps` is an ArraySpecifier. Applying operator `()` results into a JavaScript
    // array but forEach does *not* work!

    for (var i = 0; i < eclApps.length; i++) {
        if (eclApps[i].windows.name()[0] === selected) {
            eclApps[i].frontmost = true
        }
    }
}
                              
jscr  ??ޭ