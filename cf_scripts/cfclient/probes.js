/**
 * Authors:
 *      Radu Cotescu (cotescu@adobe.com)
 *      Felix Oghină (foghin@adobe.com)
 *
 * Define the default probes.
 */
BrowserMap.addProbe('devicePixelRatio', function() {
    if(window.devicePixelRatio) {
        return window.devicePixelRatio;
    }
    var mq = window.matchMedia;
    if (mq) {
        for (var i = 0.5; i <= 3; i+= 0.05) {
            var ratio = Math.round(i * 100)/100;
            if (mq('(-moz-device-pixel-ratio: ' + ratio + '), (-o-device-pixel-ratio: ' + ratio + '), (-webkit-device-pixel-ratio: '+ ratio +')').matches) {
                return ratio;
            }
        }
    }
    return 1;
}).addProbe('clientWidth', function() {
    return document.documentElement.clientWidth;
}).addProbe('screenWidth', function() {
    return screen.width;
}).addProbe('orientation', function() {
    var orientation = '';
    if (window.orientation) {
        if (Math.abs(window.orientation) == 90) {
            orientation = 'landscape';
        }
        else {
            orientation = 'portrait';
        }
    }
    else {
        if (screen.width > screen.height) {
            orientation = 'landscape';
        }
        else {
            orientation = 'portrait';
        }
    }
    return orientation;
}).addProbe('portrait', function() {
    return BrowserMap.probe('orientation') == 'portrait';
}).addProbe('landscape', function() {
    return BrowserMap.probe('orientation') == 'landscape';
}).addProbe('canResizeBrowserWindow', function() {
    /**
     * useful to detect a mobile browser (true) / a desktop browser (false)
     */
    return Math.round(BrowserMap.probe('screenWidth') / BrowserMap.probe('devicePixelRatio')) -
                BrowserMap.THE_ANSWER_TO_LIFE_THE_UNIVERSE_AND_EVERYTHING > BrowserMap.probe('clientWidth');
});
