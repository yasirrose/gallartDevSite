/**
 * Authors:
 *      Radu Cotescu (cotescu@adobe.com)
 *      Felix Oghină (foghin@adobe.com)
 *
 * Various utils used by BrowserMap-related code.
 */
BrowserMapUtil = {
    /**
     * Merge two objects as hashes. Entries with duplicate keys are overwritten with values from the second object.
     *
     * @param Type:Object hsh1 - the first hash object
     * @param Type:Object hsh2 - the second hash object
     * @returns Type:Object a hash object obtained by merging the two parameter hash objects
     */
    'merge' : function(hsh1, hsh2) {
        var hsh = { };
        for (prop in hsh1) {
            if (hsh1.hasOwnProperty(prop)) hsh[prop] = hsh1[prop];
        }
        for (prop in hsh2) {
            if (hsh2.hasOwnProperty(prop)) hsh[prop] = hsh2[prop];
        }
        return hsh;
    },

    /**
     * Returns the set difference between Array a and Array b (a \ b).
     *
     * @param Type:Array a - the first Array
     * @param Type:Array b - the second Array
     * @returns Type:Array an Array containing the set difference
     * @throws TypeError if either a or b are not of type Array
     */
    'getArrayDifference' : function (a, b) {
        if (!a instanceof Array) {
            throw new TypeError('Expected Array for a');
        }
        if (!b instanceof Array) {
            throw new TypeError('Expected Array for b');
        }
        var seen = [], diff = [];
        for ( var i = 0; i < b.length; i++)
            seen[b[i]] = true;
        for ( var i = 0; i < a.length; i++)
            if (!seen[a[i]])
            diff.push(a[i]);
        return diff;
    },

    // object for managing cookies client-side (see https://developer.mozilla.org/en/DOM/document.cookie)
    'cookieManager' : {
        'getCookie' : function (cookieName) {
            if (!cookieName || !this.cookieExists(cookieName)) { return null; }
            var cookieValue = unescape(document.cookie.replace(new RegExp('(?:^|.*;\\s*)' + escape(cookieName).replace(/[\-\.\+\*]/g, '\\$&') + '\\s*\\=\\s*((?:[^;](?!;))*[^;]?).*'), '$1'));
            var cookie = new Cookie(cookieName, cookieValue);
            return cookie;
        },

        'setCookie' : function (cookie) {
            if (!cookie.name || /^(?:expires|max\-age|path|domain|secure)$/.test(cookie.name)) { return; }
            var sExpires = '';
            if (cookie.expires) {
                switch (typeof cookie.expires) {
                    case 'number': sExpires = '; max-age=' + cookie.expires; break;
                    case 'string': sExpires = '; expires=' + cookie.expires; break;
                    case 'object': if (cookie.expires.hasOwnProperty('toGMTString')) { sExpires = '; expires=' + cookie.expires.toGMTString(); } break;
                }
            }
            document.cookie = escape(cookie.name) + '=' + escape(cookie.value) + sExpires + (cookie.domain ? '; domain=' + cookie.domain : '') + (cookie.path ? '; path=' + cookie.path : '') + (cookie.secure ? '; secure' : '');
        },

        'removeCookie' : function (cookieName) {
            if (!cookieName || !this.cookieExists(cookieName)) { return; }
            var oExpDate = new Date();
            oExpDate.setDate(oExpDate.getDate() - 1);
            document.cookie = escape(cookieName) + '=; expires=' + oExpDate.toGMTString() + ';';
        },

        'cookieExists' : function (cookieName) { return (new RegExp('(?:^|;\\s*)' + escape(cookieName).replace(/[\-\.\+\*]/g, '\\$&') + '\\s*\\=')).test(document.cookie); },

        'cookiesEnabled' : function () {
            var cookie = new Cookie('browsermap_test_cookie', 'browsermap_test_cookie', 10, '/')
            this.setCookie(cookie);
            var test_cookie = this.getCookie('browsermap_test_cookie');
            if (test_cookie != null) {
                this.removeCookie('browsermap_test_cookie');
                return true;
            }
            return false;
        }
    },

    'file' : {
        /**
         * Returns the extension of a file based on the file name.
         *
         * @param Type:String file - the file's name
         * @returns Type:String a String containing the file's extension, empty string if the file does not have an extension
         */
        'getFileExtension' : function (file) {
            var extension = '';
            if (file && file != '' && file.indexOf('.') != -1) {
                extension = file.substring(file.lastIndexOf('.'), file.length);
            }
            return extension;
        },

        /**
         * Analyses if a file has selectors in its file name and returns the file name (file part + extension) without the selectors.
         *
         * @param Type:String file - the file from which to remove the selectors
         * @retuns Type:String a string containing the file with the removed selectors
         */
        'removeSelectorsFromFile' : function(file) {
            if (file && file != '') {
                var tokens = file.split('.');
                if (tokens.length > 2) {
                    return tokens[0] + '.' + tokens[tokens.length - 1];
                }
            }
            return file;
        }        
    },

    'url' : {
        /**
         * Analyses a URL an returns the domain part from it.
         *
         * @param Type:String url - the url from which to extract the domain part
         * @retuns Type:String the detected domain
         */
        'getDomainFromURL' : function (url) {
            var domain = '';
            url = url.replace(/http:\/\/|https:\/\//, '');
            var slashIndex = url.indexOf('/');
            if (slashIndex == -1)
                domain = url;
            else {
                domain = url.substring(0, slashIndex);
            }
            return domain;
        },

        /**
         * Decodes the value of a GET URL parameter.
         *
         * @param Type:String the encoded value of the parameter
         * @returns Type:String the decoded value of the parameter
         */
        'decodeURLParameterValue' : function (value) {
            return decodeURIComponent(value.replace(/\+/g, ' '));
        },

        /**
         * Returns a map with the GET paramters of a URL.
         *
         * @param Type:String url - the URL from which the parameters need to be extracted
         * @returns Type:Map the map with the parameters and their values
         */
        'getURLParameters' : function (url) {
            var map = {}, self = this;
            var f = function(m,key,value) { map[key] = self.decodeURLParameterValue(value); };
            var parts = url.replace(/[?&]+([^=&]+)=([^&]*)/gi, f);
            return map;
        },

        /**
         * Returns the value of a specified GET parameter from a URL if the parameter exists. Otherwise it will return null.
         *
         * @param Type:String url - the URL from which the parameter value needs to be extracted
         * @param Type:String parameter - the name of the GET parameter whose value needs to be returned
         * @returns Type:String the value of the parameter, null if the parameter does not exist
         */
        'getValueForParameter' : function (url, parameter) {
            return this.getURLParameters(url)[parameter];
        },

        /**
         * Returns the GET parameters string from a URL.
         *
         * @param Type:String url - the URL form which the parameters string should be extracted
         * @returns Type:String the parameters string; empty string if the url is null / empty
         */
        'getURLParametersString' : function (url) {
            var urlParametersString = '';
            if (url && url != '' && url.lastIndexOf('?') != -1) {
                urlParametersString = url.substring(url.lastIndexOf('?'), url.length);
            }
            return urlParametersString;
        },

        /**
         * Returns the file part of a URL, together with whatever GET parameters might be a part of the URL. If the URL sent as a parameter
         * is empty or null, the returned value will be a null.
         *
         * @params Type:String url - the URL from which the file part should be extracted
         * @returns Type:String a String containing the file part; empty string if the URL is null or empty or points to a folder instead of a file
         */
        'getFileFromURL' : function getFileFromURL(url) {
            var file = '';
            if (url && url != '') {
                url = url.replace('https://', '');
                url = url.replace('http://', '');
                if (url.lastIndexOf('/') != -1 && url[url.lastIndexOf('/') + 1] != '?') {
                    file = url.substring(url.lastIndexOf('/') + 1, url.length);
                }
            }
            return file;
        },

        /**
         * Retrieves the folder path from a URL.
         *
         * @param Type:String url - the URL from which the path is extracted
         * @returns Type:String a String containing the folder path; empty string if the URL is null or empty or it does not end with "/"
         */
        'getFolderPathFromURL' : function (url) {
            var folderPath = '';
            var tmpURL = url;
            tmpURL = tmpURL.replace('https://', '');
            tmpURL = tmpURL.replace('http://', '');
            if (tmpURL && tmpURL != '' && tmpURL.lastIndexOf('/') != -1) {
                folderPath = tmpURL.substring(0, tmpURL.lastIndexOf('/') + 1);
                folderPath = url.substring(0, url.indexOf(folderPath)) + folderPath;
            }
            return folderPath;
        },

        /**
         * Analyses a resource (the file part from a URL) and retrieves its selectors. The selectors will be returned in an Array. An empty
         * Array will be returned if no selectors have been found.
         *
         * @param Type:String url - the URL from which the selectors have to be extracted
         * @returns Type:Array - an Array with the selectors; the Array will be empty if no selectors have been found
         */
        'getSelectorsFromURL' : function(url) {
            var selectors = [];
            if (url && url != '') {
                url = url.replace('https://', '');
                url = url.replace('http://', '');
                // ditch the parameters when retrieving selectors
                if (url.lastIndexOf('?') != -1) {
                    url = url.substring(0, url.lastIndexOf('?'));
                }
                if (url.lastIndexOf('/') != -1 ) {
                    url = url.substring(url.lastIndexOf('/') + 1, url.length);
                    var selectorCandidates = url.split('.');
                    if (selectorCandidates.length > 2) {
                        for (var i = 1; i < selectorCandidates.length - 1; i++) {
                            selectors.push(selectorCandidates[i]);
                        }
                    }
                }
            }
            return selectors;
        },  

        /**
         * Adds selectors to the supplied URL and returns the modified URL.
         *
         * @param Type:String url - the URL to which selectors need to be added
         * @param Type:Array selectors - an Array with the selectors that have to be applied to the current URL
         * @returns Type:String a String containing the new URL
         */
        'addSelectorsToURL' : function(url, selectors) {
            var file = this.getFileFromURL(url);
            file = BrowserMapUtil.file.removeSelectorsFromFile(file);
            if (file && file != '') {
                var path = this.getFolderPathFromURL(url);
                var extension = BrowserMapUtil.file.getFileExtension(file);
                file = file.replace(extension, '');
                var newURL = path + file;
                if (selectors.length > 0)
                    newURL += '.';
                newURL += selectors.join('.');
                newURL += extension;
                return newURL;
            }
            return url;
        }
    }
};

/**
 * Creates a Coookie object.
 *
 * @param Type:String name - this cookie's name
 * @param Type:String value - this cookie's value (unescaped - the cookie manager will handle escaping / unescaping)
 * @param expires - this cookie's expires information:
 *                  Type:Number - expiration time in seconds
 *                  Type:String - expiration time as a String formatted date
 *                  Type:Object - expiration time as a Date object
 * @param Type:String path - the path for which this cookie is valid
 * @param Type:String domain - the domain for which this cookie is valid
 * @param Type:Boolean secure - boolean flag to inidicate if this cookie needs to be used only for HTTPS connections or not
 */
function Cookie(name, value, expires, path, domain, secure) {
    if (!(this instanceof Cookie)) {
        return new Cookie(name, value, expires, path, domain, secure);
    }
    this.name = name;
    this.value = value;
    this.expires = expires;
    this.path = path;
    this.domain = domain;
    this.secure = secure;
}

// Array.indexOf polyfill
// from https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Array/indexOf
if (!Array.prototype.indexOf) {
    Array.prototype.indexOf = function (searchElement /*, fromIndex */ ) {
        "use strict";
        if (this == null) {
            throw new TypeError();
        }
        var t = Object(this);
        var len = t.length >>> 0;
        if (len === 0) {
            return -1;
        }
        var n = 0;
        if (arguments.length > 0) {
            n = Number(arguments[1]);
            if (n != n) { // shortcut for verifying if it's NaN
                n = 0;
            } else if (n != 0 && n != Infinity && n != -Infinity) {
                n = (n > 0 || -1) * Math.floor(Math.abs(n));
            }
        }
        if (n >= len) {
            return -1;
        }
        var k = n >= 0 ? n : Math.max(len - Math.abs(n), 0);
        for (; k < len; k++) {
            if (k in t && t[k] === searchElement) {
                return k;
            }
        }
        return -1;
    }
}
