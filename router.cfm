<cfscript>
    /**
     * Initialize all routes (called once from Application.cfm)
     */
    function initRouter() {
		writeDump("testing");
		abort;
        application.routes = [
            { pattern: "", target: "index.cfm" },
            { pattern: "artists/:name", target: "products/index.cfm" }
            // { pattern: "products/view/:id", target: "products/view.cfm" },
            // { pattern: "blog", target: "blog/index.cfm" },
            // { pattern: "blog/post/:slug", target: "blog/post.cfm" }
        ];
    }

    /**
     * Process the current request and match against routes
     */
    function processRoute() {
        var requestedPath = getCleanPath();
        var pathSegments = listToArray(requestedPath, "/");
        var routeMatch = findRouteMatch(pathSegments);
        if (routeMatch.matched) {
            structAppend(request, routeMatch.params);
            include routeMatch.target;
            abort;
        }
        
        // No match found → 404
        include "404.cfm";
        abort;
    }

    /**
     * Extracts the clean path from CGI variables
     */
    private function getCleanPath() {
        if (structKeyExists(cgi, "path_info") && cgi.path_info != "/") {
            return reReplace(cgi.path_info, "^/|/$", "", "all");
        }
        return reReplace(cgi.script_name, "^/|/$", "", "all");
    }

    /**
     * Finds the first matching route for the given path segments
     */
    private function findRouteMatch(pathSegments) {
        var result = { matched: false, target: "", params: {} };
		

        for (var route in application.routes) {
            var routeSegments = listToArray(route.pattern, "/");

            if (arrayLen(routeSegments) == arrayLen(pathSegments)) {
                var params = {};
                var match = true;

                for (var i = 1; i <= arrayLen(routeSegments); i++) {
                    if (left(routeSegments[i], 1) == ":") {
                        var paramName = mid(routeSegments[i], 2, len(routeSegments[i]));
                        params[paramName] = pathSegments[i];
                    }
                    else if (routeSegments[i] != pathSegments[i]) {
                        match = false;
                        break;
                    }
                }

                if (match) {
                    result.matched = true;
                    result.target = route.target;
                    result.params = params;
                    return result;
                }
            }
        }

        return result;
    }
</cfscript>