/* for easier VimFX development */
user_pref('devtools.chrome.enabled', true);

/* From "The Paranoid #! Security Guide" */
/* http://crunchbang.org/forums/viewtopic.php?id=24722 */

// // ---disable browser cache:
// user_pref('browser.cache.disk.enable', false);
// user_pref('browser.cache.disk_cache_ssl', false);
// user_pref('browser.cache.offline.enable', false);
// user_pref('browser.cache.memory.enable', false);
// user_pref('browser.cache.disk.capacity', 0);
// user_pref('browser.cache.disk.smart_size.enabled', false);
// user_pref('browser.cache.disk.smart_size.first_run', false);
// user_pref('browser.cache.offline.capacity', 0);
// user_pref('dom.storage.default_quota', 0);
// user_pref('dom.storage.enabled', false);
// user_pref('dom.indexedDB.enabled', false);
// user_pref('dom.battery.enabled', false);
// // ---disable history & localization
// user_pref('browser.search.suggest.enabled', false);
// user_pref('browser.sessionstore.resume_from_crash', false);
// user_pref('geo.enabled', false);
// // ---misc other tweaks:
// user_pref('keyword.enabled', false);
// // -> very important when using TOR
// user_pref('network.dns.disablePrefetch', true);
// // -> very important when using TOR
// user_pref('network.dns.disablePrefetchFromHTTPS', true);
// user_pref('dom.disable_window_open_feature.menubar', true);
// user_pref('dom.disable_window_open_feature.personalbar', true);
// user_pref('dom.disable_window_open_feature.scrollbars', true);
// user_pref('dom.disable_window_open_feature.toolbar', true);
// user_pref('browser.identity.ssl_domain_display', 1);
// user_pref('browser.urlbar.autocomplete.enabled', false);
// user_pref('browser.urlbar.trimURL', false);
// user_pref('privacy.sanitize.sanitizeOnShutdown', true);
// user_pref('network.http.sendSecureXSiteReferrer', false);
// // ---> use http instead of google's spdy
// user_pref('network.http.spdy.enabled', false);
// // ---> also check each drop-down-menu under "preferences"->"content"
// user_pref('plugins.click_to_play', true);
// // ---> disable https-tracking
// user_pref('security.enable_tls_session_tickets', false);
// user_pref('security.ssl.enable_false_start', true);
// // ---> disble Mozilla's option to block/disable your addons remotely
// user_pref('extensions.blocklist.enabled', false);
// // ---> disable WebGL
// // http://security.stackexchange.com/questions/13799/is-webgl-a-security-concern
// // user_pref('webgl.disabled', true);
// // ---> ***Tor Users: This is extremely important as it could blow your cover!
// // See: http://pastebin.com/xajsbiyh***
// user_pref('network.websocket.enabled', false);
// // ---make your browsing faster:
// user_pref('network.http.pipelining', true);
// user_pref('network.http.pipelining.ssl', true);
// user_pref('network.http.proxy.pipelining', true);
// user_pref('network.http.max-persistent-connections-per-proxy', 10);
// user_pref('network.http.max-persistent-connections-per-server', 10);
// user_pref('network.http.max-connections-per-server', 15);
// user_pref('network.http.pipelining.maxrequests', 15);
// user_pref('network.http.redirection-limit', 5);
// user_pref('network.dns.disableIPv6', true);
// user_pref('network.http.fast-fallback-to-IPv4', false);
// user_pref('dom.popup_maximum Mine', 10);
// user_pref('network.prefetch-next', false);
// user_pref('browser.backspace_action', 0);
// user_pref('browser.sessionstore.max_tabs_undo', 5);
// user_pref('browser.sessionhistory.max_entries', 5);
// user_pref('browser.sessionstore.max_windows_undo', 1);
// user_pref('browser.sessionstore.max_resumed_crashes', 0);
// user_pref('browser.sessionhistory.max_total_viewers', 0);
// user_pref('browser.tabs.animate', 0);
// // --- prevent browser fingerprinting
// user_pref('general.useragent.override', 'Mozilla/5.0 (Windows NT 6.1; rv:10.0) Gecko/20100101 Firefox/10.0 ');
// user_pref('general.appname.override', 'Netscape');
// user_pref('general.appversion.override', '5.0 (Windows)');
// user_pref('general.oscpu.override', 'Windows NT 6.1');
// user_pref('general.platform.override', 'Win32');
// user_pref('general.productSub.override', '20100101');
// user_pref('general.buildID.override', '0');
// user_pref('general.useragent.vendor', '');
// user_pref('general.useragent.vendorSub', '');
// user_pref('intl.accept_languages', 'en-us,en;q=0.5');
// user_pref('network.http.accept.default', 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8');
// user_pref('network.http.accept-encoding', 'gzip, deflate');
