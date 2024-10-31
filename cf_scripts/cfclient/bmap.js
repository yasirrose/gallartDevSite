/**
 * Authors:
 *      Radu Cotescu (cotescu@adobe.com)
 *      Felix Oghină (foghin@adobe.com)
 *
 * The BrowserMap object is used to identify the client's device group, based
 * on javascript detection tests ("probes") that find out which features
 * the client supports.
 */
window.BrowserMap = (function() {

    var cookiePrefix = 'BMAP_';
    var deviceGroupCookieName = 'device';
    var deviceOverrideParameter = 'device';
    var languageOverrideParameter = 'language';
    var enableForwardingWhenCookiesDisabled = false;
    var matchRun = false;
    var languageOverride = null;

    // the default BrowserMap object
    var BrowserMap = {};
    // Android 4.x phones in landscape view use 42 pixels for displaying the "soft buttons"
    BrowserMap.THE_ANSWER_TO_LIFE_THE_UNIVERSE_AND_EVERYTHING = 42;
    var deviceGroups = {};
    var matchedDeviceGroups = {};

    BrowserMap.debuginfo = {};

    /**
     * Allows quick expression debugging by accepting an expression and storing its evaluated value.
     *
     * @param Type:String expr - the expression to be evaluated
     */
    BrowserMap.debug = function debug(expr) {
        BrowserMap.debuginfo[expr] = eval(expr);
    }

    // default BrowserMap probes
    var probes = { };
    var probeCache = { };
    var siteVersions = { };

    /**
     * Initialises BrowserMap with a configuration object.
     *
     * @param Type:Object config - a hash object with various properties that can be used to configure BrowserMap
     *      The following proprerties can be be used:
     *          1. config.cookiePrefix - the prefix used to name cookies used throughout the detection
     *          2. config.deviceGroupCookieName - the name of the device group cookie (the final name will be of the form config.cookiePrefix +
     *             config.deviceGroupCookieName)
     *          3. config.deviceOverrideParameter - the name of the GET parameter that triggers a device override
     *          4. config.languageOverrideParameter - the name of the GET parameter that triggers a language override
     *          5. config.enableForwardingWhenCookiesDisabled - if true, it will allow for all the URLs pointing to resources from the current
     *             domain to be modified in order to include the deviceOverrideParameter; this is useful if the client does not support cookies
     */
    BrowserMap.config = function (config) {
        if (config.cookiePrefix != null) {
            cookiePrefix = config.cookiePrefix;
        }
        if (config.deviceGroupCookieName != null) {
            deviceGroupCookieName = config.deviceGroupCookieName;
        }
        if (config.deviceOverrideParameter != null) {
            deviceOverrideParameter = config.deviceOverrideParameter;
        }
        if (config.languageOverrideParameter != null) {
            languageOverrideParameter = config.languageOverrideParameter;
        }
        if (config.enableForwardingWhenCookiesDisabled != null) {
            enableForwardingWhenCookiesDisabled = config.enableForwardingWhenCookiesDisabled;
        }
    }

    /**
     * Returns an Array of the alternate sites by analysing the link elements with rel='alternate' and the media attribute not null or empty.
     *
     * @returns Type:Array an array of alternate sites as hash objects; an empty array if no alternate site is found
     */
    BrowserMap.getAllAlternateSites = function () {
        var alternateSites = [];
        var links = document.getElementsByTagName('link');
        for (var i = 0; i < links.length; i++) {
            var link = links[i];
            if (link.rel == 'alternate' && link.media && link.media != '') {
                alternateSites.push({'id' : link.id, 'href' : link.href, 'hreflang' : link.hreflang, 'media' : link.media});
            }
        }
        return alternateSites;
    }

    /**
     * Looks for the best matching alternate site. The primary criterion is the number of matched device groups which also provides the score
     * of the alternate site. More criteria can be added by providing a filtering function.
     *
     * The filtering function receives an alternate site as a parameter and it must return a boolean value if the filter matches or not. The
     * filter is applied to alternate sites that have matched at least one device group. If the alternate site matches the filter, the total
     * score of the alternate site will increase by 1. The alternate site's object attributes are id, href, hreflang and media.
     *
     * @param Type:Array deviceGroups - an array containing the names of the device groups for which to get the best alternate link
     * @param Type:Function filter - a callback function that acts as a filter and which must return a boolean; the callback will receive a
     *      hash object representing an alternate site with the following attributes: "id", "href", "hreflang", "media"
     * @returns Type:String the alternate link that matches the most device groups matched by the client
     */
    BrowserMap.getAlternateSite = function (deviceGroups, filter) {
        var alternateSites = BrowserMap.getAllAlternateSites();
        var maxLinkScore = 0;
        var alternateSite = null;
        var alternateSiteCandidate = null;
        var scoreForCurrentSite = 0;
        var currentURL = window.location.href;
        var currentURLParameters = BrowserMapUtil.url.getURLParametersString(currentURL);
        if (currentURLParameters && currentURLParameters != '') {
            currentURL = currentURL.substring(0, currentURL.indexOf(currentURLParameters));
        }
        for (var i = 0; i < alternateSites.length; i++) {
            var linkScore = 0;
            var devices = alternateSites[i].media.split(',');
            for (var j = 0; j < devices.length; j++) {
                if (deviceGroups.indexOf(devices[j].trim()) != -1) {
                    linkScore++;
                }
            }
            if (typeof filter == 'function' && linkScore > 0) {
                if(filter(alternateSites[i])) {
                    linkScore++;
                }
            }
            if (linkScore > maxLinkScore) {
                alternateSite = alternateSites[i];
                maxLinkScore = linkScore;
            }
            if (alternateSites[i].href == currentURL) {
                scoreForCurrentSite = linkScore;
                alternateSiteCandidate = alternateSites[i];
            }
        }
        if (scoreForCurrentSite == maxLinkScore) {
            alternateSite = alternateSiteCandidate;
        }
        return alternateSite;
    }

    /**
     * Returns the defined DeviceGroups for this BrowserMap as an array in which the elements are ordered by their ranking property.
     *
     * @returns Type:Array
     */
    BrowserMap.getDeviceGroupsInRankingOrder = function () {
        var dgs = [];
        for (var dg in deviceGroups) {
            dgs.push(deviceGroups[dg]);
        }
        dgs.sort(function(a, b) {
            return a.ranking - b.ranking;
        })
        return dgs;
    }

    /**
     * Executes a probe that was previously added via addProbe. The result of the probe is cached so a second call
     * with the same probeName will not run the probe again. You can use BrowserMap.clearProbeCache() to avoid that.
     *
     * @param Type:String probeName - the name of the requested probe
     * @returns Type:Object the result of the probe, or null if the probe has not been defined
     */
    BrowserMap.probe = function (probeName) {
        if (probes[probeName] == null)
            return null;
        if (!probeCache.hasOwnProperty(probeName)) {
            probeCache[probeName] = probes[probeName]();
        }
        return probeCache[probeName];
    }

    /**
     * Starting from a currentURL, an array of device groups and an array of url selectors returns the alternate URL for the current URL.
     *
     * @param Type:String currentURL - the current URL
     * @param Type:Array detectedDeviceGroups - the Array of detected device groups
     * @prama Type:Attay urlSelectors - the Array of URL selectors, in the order of their device group ranking
     * @returns Type:String the specific URL for the identified device groups
     */
    BrowserMap.getNewURL = function (currentURL, detectedDeviceGroups, urlSelectors) {
        var newURL = null;
        var alternateSite = BrowserMap.getAlternateSite(detectedDeviceGroups, function(alternateLink) {
            if (languageOverride && alternateLink.hreflang && alternateLink.hreflang.lastIndexOf(languageOverride) == 0) {
                return true;
            }
        });
        if (alternateSite) {
            newURL = alternateSite.href;
        }
        if (!newURL) {
            for (var i = 0; i < detectedDeviceGroups.length; i++) {
                var dg = BrowserMap.getDeviceGroupByName(detectedDeviceGroups[i]);
                if (dg) {
                    newURL = dg.url;
                    if (newURL) {
                        break;
                    }
                }
            }
        }
        if (!newURL) {
            newURL = BrowserMapUtil.url.addSelectorsToURL(currentURL, urlSelectors);
        }
        if (newURL) {
            var parameters = BrowserMapUtil.url.getURLParametersString(currentURL);
            if (parameters.length > 0) {
                if (newURL.lastIndexOf(parameters) == -1)
                    newURL += parameters;
            }
        }
        return newURL;
    }

    /**
     * Removes the device group override, whether it was set up by using the override cookie or just by using the specific device group
     * override parameter.
     */
    BrowserMap.removeOverride = function () {
        var oCookie = BrowserMapUtil.cookieManager.getCookie('o_' + cookiePrefix + deviceGroupCookieName);
        if (oCookie) {
            BrowserMapUtil.cookieManager.removeCookie(cookiePrefix + deviceGroupCookieName);
            BrowserMapUtil.cookieManager.removeCookie(oCookie.name);
            oCookie.name = cookiePrefix + deviceGroupCookieName;
            oCookie.path = '/';
            BrowserMapUtil.cookieManager.setCookie(oCookie);
        }
        var currentURL = window.location.href;
        var parameters = BrowserMapUtil.url.getURLParametersString(currentURL);
        if (parameters) {
            var overrideParameter = deviceOverrideParameter + '=' + BrowserMapUtil.url.getValueForParameter(currentURL, deviceOverrideParameter);
            currentURL = currentURL.replace(parameters, '');
            var indexOfOverride = parameters.indexOf(overrideParameter);
            if (indexOfOverride != -1) {
                if (parameters.length > indexOfOverride + overrideParameter.length) {
                    if (parameters[indexOfOverride - 1] == '?') {
                        parameters = parameters.replace(overrideParameter + '&', '');
                    }
                    else {
                        parameters = parameters.replace('&' + overrideParameter, '');
                    }
                }
                else {
                    parameters = parameters.replace('?' + overrideParameter, '');
                }
            }
            currentURL += parameters;
        }
        window.location = currentURL;
    }

    /**
     * Decides if the client should be forwarded to the best matching alternate link based on the following:
     *      1. BrowserMap will detect to what DeviceGroups a client belongs to.
     *      2. Based on alternate links (e.g. <link rel="alternate" ... />) from the current page, if they exist, BrowserMap will try to
     *         forward the client to the alternate link corresponding to the identified DeviceGroup. If that alternate link does not exist,
     *         BrowserMap will then try to forward the client to the DeviceGroup's URL. If that URL is missing, then a selector will be
     *         appended to the current URL and the client will be forwarded to this newly formed URL. In either case GET parameters will be
     *         maintained.
     */
    BrowserMap.forwardRequest = function () {
        var currentURL = window.location.href;
        var deviceOverride = BrowserMapUtil.url.getValueForParameter(currentURL, deviceOverrideParameter);
        languageOverride = BrowserMapUtil.url.getValueForParameter(currentURL, languageOverrideParameter);
        var detectedDeviceGroups = [];
        var urlSelectors = [];
        var oCookie = BrowserMapUtil.cookieManager.getCookie('o_' + cookiePrefix + deviceGroupCookieName);
        var cookie = BrowserMapUtil.cookieManager.getCookie(cookiePrefix + deviceGroupCookieName);
        if (deviceOverride) {
            // override detected
            detectedDeviceGroups = deviceOverride.split(',');
            if (detectedDeviceGroups.length > 0) {
                if (BrowserMapUtil.cookieManager.cookiesEnabled()) {
                    if (!oCookie && !cookie) {
                        // tried to access resource directly with override parameter without passing through detection
                        // run detection code to detect the original device groups
                        oCookie = new Cookie();
                        oCookie.name = 'o_' + cookiePrefix + deviceGroupCookieName;
                        oCookie.path = '/';
                        BrowserMap.matchDeviceGroups();
                        var dgs = [];
                        for (var g in matchedDeviceGroups) {
                            dgs.push(matchedDeviceGroups[g].name);
                        }
                        if (deviceOverride != dgs.join(',')) {
                            oCookie.value = dgs.join(',');
                            BrowserMapUtil.cookieManager.setCookie(oCookie);
                        }
                    }
                    else if (!oCookie) {
                        // detection has been performed; override detected; store original values
                        if (cookie.value != detectedDeviceGroups.join(',')) {
                            cookie.name = 'o_' + cookie.name;
                            cookie.path = '/';
                            BrowserMapUtil.cookieManager.setCookie(cookie);
                        }
                    }
                    // store the override
                    cookie = new Cookie();
                    cookie.name = cookiePrefix + deviceGroupCookieName;
                    cookie.value = detectedDeviceGroups.join(',');
                    cookie.path = '/';
                    BrowserMapUtil.cookieManager.setCookie(cookie);
                    if (oCookie) {
                        if (oCookie.value == cookie.value) {
                            BrowserMapUtil.cookieManager.removeCookie(oCookie.name);
                        }
                    }
                }
            }
        }
        if (cookie != null || deviceOverride) {
            /**
             * cookie was either set by the detection code before, or we have an override;
             *
             * in either case, the matchDeviceGroups must match the detectedDeviceGroups which can come from the cookie or from the override
             * parameter
             */
            var registeredDeviceGroups = BrowserMap.getDeviceGroups();
            if (detectedDeviceGroups.length == 0) {
                detectedDeviceGroups = cookie.value.split(',');
            }
            matchedDeviceGroups = { };
            for (var i = 0 ; i < detectedDeviceGroups.length; i++) {
                var dgName = detectedDeviceGroups[i].trim();
                if (registeredDeviceGroups.hasOwnProperty(dgName)) {
                    if (registeredDeviceGroups[dgName].isSelector) {
                        urlSelectors.push(dgName);
                    }
                    matchedDeviceGroups[dgName] = registeredDeviceGroups[dgName];
                }
            }
            // add the device override parameter to links using the same domain if a device override was detected
            if (deviceOverride && cookie == null && enableForwardingWhenCookiesDisabled) {
                var domain = BrowserMapUtil.url.getDomainFromURL(window.location.href);
                var aTags = document.getElementsByTagName('a');
                for (var i = 0; i < aTags.length; i++) {
                    var url = aTags[i].href;
                    if (url && url.indexOf(domain) != -1) {
                        var parameters = BrowserMapUtil.url.getURLParametersString(url);
                        if (parameters) {
                            if (parameters.indexOf(languageOverrideParameter + '=' + deviceOverride) == -1) {
                                aTags[i].href = url + '&' + deviceOverrideParameter + '=' + deviceOverride
                            }
                        }
                        else {
                            aTags[i].href = url + '?' + deviceOverrideParameter + '=' + deviceOverride
                        }
                    }
                }
            }
        }
        else {
            // no override has been detected, nor a cookie has been set previous to this call
            // perform the match and then set the cookie
            BrowserMap.matchDeviceGroups();
            for (var g in matchedDeviceGroups) {
                if (matchedDeviceGroups[g].isSelector) {
                    urlSelectors.push(matchedDeviceGroups[g].name);
                }
                detectedDeviceGroups.push(matchedDeviceGroups[g].name);
            }
            cookie = new Cookie();
            cookie.name = cookiePrefix + deviceGroupCookieName;
            cookie.value = detectedDeviceGroups.join(',');
            cookie.path = '/';
            BrowserMapUtil.cookieManager.setCookie(cookie);
        }
//        var newURL = BrowserMap.getNewURL(currentURL, detectedDeviceGroups, urlSelectors);
//        if (newURL && currentURL != newURL) {
//            window.location = newURL;
//        }
    }

    /**
     * Clears the probe result cache.
     */
    BrowserMap.clearProbeCache = function () {
        probeCache = { };
    }

    /**
     * Adds a DeviceGroup to the BrowserMap object. The key which is used to store the DeviceGroup is represented by its name. The last
     * DeviceGroup added to BrowserMap with the same name as a previously existing DeviceGroup will be the one which will be stored.
     *
     * @param Type:Object deviceGroup - the DeviceGroup to be added to the list; a DeviceGroup is represented by a hash object with the
     *      following attributes:
     *          1. Type:Number ranking                  - the order number of the DeviceGroup (when it comes to matching the DeviceGroups to
     *             the client's capabilites, the defined DeviceGroups will be evaluated in order)
     *          2. Type:String name                     - the name of the DeviceGroup as one word (use camelCase if you need more words)
     *          3. Type:Function testFunction           - the function that is to be evaluated to check if the client matches the
     *             DeviceGroup; this function *must* return a boolean value
     *          4. Type:String url (optional)           - the URL to which a client will be forwarded in case the DeviceGroup matches and
     *             the current page does not contain an alternate link to which the client can be pointed
     *          5. Type:String description (optional)   - the description of the DeviceGroup
     *          6. Type:Boolean isSelector (optional)   - if present and set to true, the name of the DeviceGroup will be used to create a
     *             URL with a selector to which BrowserMap can forward the client (e.g. index.selector.html);
     */
    BrowserMap.addDeviceGroup = function (deviceGroup) {
        // validate the deviceGroup object
        if (typeof deviceGroup.ranking != 'number') {
            throw new TypeError('Expected a Number for device group ' + deviceGroup.name + ' ranking');
        }
        if (typeof deviceGroup.testFunction != 'function') {
            throw new TypeError('Expected a Function for device group ' + deviceGroup.name + ' testFunction');
        }
        deviceGroups[deviceGroup.name] = deviceGroup;
    }

    /**
     * Adds a probe to BrowserMap and returns the BrowserMap object (useful for chaining). The probe name must be unique. If one tries to
     * overwrite an existing probe nothing will happen and the BrowserMap object will be returned as it was before the method was called.
     *
     * @param name a String containing the name of the probe
     * @param probe a Function that returns the result of the probe
     *
     * @returns the BrowserMap object
     */
    BrowserMap.addProbe = function (name, probe) {
        if (typeof name != 'string' || name.length < 1) {
            throw new TypeError('invalid probe name');
        }
        if (typeof probe != 'function') {
            throw new TypeError('invalid probe function');
        }
        if (!probes.hasOwnProperty(name)) {
            probes[name] = probe;
        }
        return BrowserMap;
    }

    /**
     * Returns the DeviceGroups that a client has matched.
     *
     * @returns Type:Object a hash object containing the matched device groups
     */
    BrowserMap.getMatchedDeviceGroups = function () {
        return matchedDeviceGroups;
    }

    /**
     * Returns all the DeviceGroups defined for the BrowserMap object.
     *
     * @returns Type:Object a hash object containing the defined device groups for this BrowserMap instance
     */
    BrowserMap.getDeviceGroups = function () {
        return deviceGroups;
    }

    /**
     * Matches the DeviceGroups to the client's capabilities by evaluating the DeviceGroup's test function.
     */
    BrowserMap.matchDeviceGroups = function () {
        var deviceGroupsArray = BrowserMap.getDeviceGroupsInRankingOrder();
        for (var i = 0; i < deviceGroupsArray.length; i++) {
            var deviceGroup = deviceGroupsArray[i];
            if (!!deviceGroup.testFunction.call()) {
                matchedDeviceGroups[deviceGroup.name] = deviceGroup;
            }
        }
        matchRun = true;
    }

    /**
     * Queries the list of DeviceGroups associated to this BrowserMap object using a DeviceGroup name and returns it if found.
     *
     * @param Type:String groupName - the name of the DeviceGroup
     * @returns Type:DeviceGroup the DeviceGroup with the respective name, null otherwise
     */
    BrowserMap.getDeviceGroupByName = function (groupName) {
        return deviceGroups[groupName];
    }

    BrowserMap.setCookieName = function (name) {
        cookieName = name;
    }

    BrowserMap.getCookieName = function () {
        return cookieName;
    }

    return BrowserMap;

})();
