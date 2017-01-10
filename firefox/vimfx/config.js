/* ============================== KEY BINDINGS =============================== */

const MAPPINGS = {
    'search_tabs': '<force><c-t>',
    'search_history': '<force><c-h>',
    'search_bookmarks': '<force><c-k>',
    'search_titles': '<force><c-j>',
    'restart': '<c-Q>'
};

/* ============================= CUSTOM COMMANDS ============================= */

let {commands} = vimfx.modes.normal;

function awesome_bar_custom_search(args, c) {
    console.log(commands);
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

const CUSTOM_COMMANDS = [
    [{
        name: 'search_tabs',
        description: 'Search tabs',
        category: 'tabs',
        order: commands.focus_location_bar.order + 1
    }, (args) => awesome_bar_custom_search(args, '%')],
    [{
        name: 'search_history',
        description: 'Search history',
        category: 'tabs',
        order: commands.focus_location_bar.order + 1
    }, (args) => awesome_bar_custom_search(args, '^')],
    [{
        name: 'search_bookmarks',
        description: 'Search bookmarks',
        category: 'tabs',
        order: commands.focus_location_bar.order + 1
    }, (args) => awesome_bar_custom_search(args, '*')],
    [{
        name: 'search_titles',
        description: 'Search titles',
        category: 'tabs',
        order: commands.focus_location_bar.order + 1
    }, (args) => awesome_bar_custom_search(args, '#')],
    [{
        name: 'restart',
        description: 'Restart Firefox',
        category: 'tabs',
        order: commands.focus_location_bar.order + 1
    }, restart]
];

/* ============================= APPLY THE ABOVE ============================= */

CUSTOM_COMMANDS.forEach(([options, fn]) => {
    vimfx.addCommand(options, fn);
});

Object.entries(MAPPINGS).forEach(([command, value]) => {
    const [shortcuts, mode] = Array.isArray(value) ? value : [value, 'mode.normal'];
    vimfx.set(`custom.${mode}.${command}`, shortcuts);
});
