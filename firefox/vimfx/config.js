/* ============================== KEY BINDINGS =============================== */

const MAPPINGS = {
    'search_tabs': '<force><c-t>',
    'search_history': '<force><c-h>',
    'search_bookmarks': '<force><c-k>',
    'search_titles': '<force><c-j>',
    'restart': '<force><c-Q>',
    'promote_tab': '<force><c-left>',
    'demote_tab': '<force><c-right>',
    'cw': '<force><c-w>'
};

/* ============================= CUSTOM COMMANDS ============================= */

let {commands} = vimfx.modes.normal;

// debugging function that prints the attributes of a js object
// taken from https://stackoverflow.com/questions/957537/how-can-i-display-a-javascript-object
function str_of_obj(o) {
    var cache = [];
    var s = JSON.stringify(window.gURLBar.inputField, function(k, v) {
        if (typeof v === 'object' && v !== null) {
            if (cache.indexOf(v) !== -1) {
                // Circular reference found, discard key
                return;
            }
            // Store v in our collection
            cache.push(v);
        }
        return v;
    }, 4);
    cache = null; // Enable garbage collection
    return s;
}

function awesome_bar_custom_search(args, c) {
    let {vim} = args;
    let {gURLBar} = vim.window;
    gURLBar.value = '';
    commands.focus_location_bar.run(args);
    gURLBar.value = c + ' ';
    gURLBar.onInput(new vim.window.KeyboardEvent('input'));
}

/* I got this from https://stackoverflow.com/questions/26115209/how-to-restart-mozila-firefox-browser-from-firefox-extension.
 * I have no idea how it works.
 */
function restart(args) {
    let [cc, ci] = [Components.classes, Components.interfaces];
    let canceled = cc["@mozilla.org/supports-PRBool;1"]
        .createInstance(ci.nsISupportsPRBool);

    Services.obs.notifyObservers(canceled, "quit-application-requested", "restart");

    if (canceled.data) return false; // somebody canceled our quit request

    // disable fastload cache?
    // if (getPref("disable_fastload")) Services.appinfo.invalidateCachesOnRestart();

    // restart
    cc['@mozilla.org/toolkit/app-startup;1'].getService(ci.nsIAppStartup)
        .quit(ci.nsIAppStartup.eAttemptQuit | ci.nsIAppStartup.eRestart);

    return true;
}

/* implements the behavior I want for C-w in firefox:
 *     - if I'm in a text field and there's a word behind the cursor, delete a
 *       word backwards
 *     - if I'm in a text field and there's no word behind the cursor, close the
 *       current tab
 *     - if I'm not in a text field, close the current tab
 */
function cw(args) {
    let {window} = args.vim;
    let {document} = window;
    let close_tab = () => {
        let {gBrowser} = window;
        gBrowser.removeTab(gBrowser.selectedTab);
    };
    // check if we're inside a text field
    var command = 'cmd_insertText';
	var controller = document.commandDispatcher.getControllerForCommand(command);
    if (controller && controller.isCommandEnabled(command)) {
        vimfx.send(args.vim, 'getCursorPosForCw', null, (cursorPos) => {
            if(cursorPos > 0) {
                // cursor is not at the beginning of the input field; i.e. there's
                // a word in front of it
                window.goDoCommand('cmd_deleteWordBackward');
            } else if(cursorPos == 0) {
                // cursor is at the beginning of the input field; i.e. there's no
                // word in front of it
                close_tab();
            } else {
                // we might be in the awesome bar
                // TODO: need this to also work in the awesome bar
            }
        });
    } else {
        close_tab();
    }
}

const CUSTOM_COMMANDS = [
    [{
        name: 'search_tabs',
        description: 'Search tabs',
        category: 'tabs',
        order: 350
    }, (args) => awesome_bar_custom_search(args, '%')],
    [{
        name: 'search_history',
        description: 'Search history',
        category: 'browsing',
        order: 99000
    }, (args) => awesome_bar_custom_search(args, '^')],
    [{
        name: 'search_bookmarks',
        description: 'Search bookmarks',
        category: 'browsing',
        order: 99001
    }, (args) => awesome_bar_custom_search(args, '*')],
    [{
        name: 'search_titles',
        description: 'Search titles',
        category: 'browsing',
        order: 99002
    }, (args) => awesome_bar_custom_search(args, '#')],
    [{
        name: 'restart',
        description: 'Restart Firefox',
        category: 'misc',
        order: 99000
    }, restart],
    [{
        name: 'promote_tab',
        description: 'Promote a tree-style tab',
        category: 'tabs',
        order: 99000
    }, (args) => args.vim.window.TreeStyleTabService.promoteCurrentTab() ],
    [{
        name: 'demote_tab',
        description: 'Demote a tree-style tab',
        category: 'tabs',
        order: 99001
    }, (args) => args.vim.window.TreeStyleTabService.demoteCurrentTab() ],
    [{
        name: 'cw',
        description: 'custom C-w',
        category: 'misc',
        order: 98000
    }, cw ]
];

/* ============================= APPLY THE ABOVE ============================= */

CUSTOM_COMMANDS.forEach(([options, fn]) => {
    vimfx.addCommand(options, fn);
});

Object.entries(MAPPINGS).forEach(([command, value]) => {
    const [shortcuts, mode] = Array.isArray(value) ? value : [value, 'mode.normal'];
    vimfx.set(`custom.${mode}.${command}`, shortcuts);
});
