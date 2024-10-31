var _window_on_load_ = window.onload;
window.onload = function() {
	if (_window_on_load_) {
		_window_on_load_();
	}
	
	if (!document.getElementsByClassName) {
		function getElementsByClassName(oBaseElement, sTagName, sClassName) {
			var aElements = (sTagName == "*" && oBaseElement.all)?oBaseElement.all:oBaseElement.getElementsByTagName(sTagName);
			var aMatches = new Array();
			sClassName = sClassName.replace(/\-/g, "\\-");
			var oRegExp = new RegExp("(^|\\s)" + sClassName + "(\\s|$)");
			var oElement;
			for (var i=0,iLen=aElements.length;i<iLen;i++) {
				oElement = aElements[i];      
				if (oRegExp.test(oElement.className)) {
					aMatches.push(oElement);
				}
			}
			return aMatches;
		}
	}
	
	function dblSplit(s, c1, c2) {
		var oHash = {}, iPos;
		var aT1 = s.split(c1);
		for (var i=0,iLen=aT1.length;i<iLen;i++) {
			if (aT1[i] != '') {
				var aT2 = aT1[i].split(c2);
				if (aT2.length == 2) {
					oHash[aT2[0]] = aT2[1];
				} else {
					if ((iPos=aT1[i].indexOf(c2)) != -1) {
						aT2 = [
							aT1[i].substring(0, iPos),
							aT1[i].substring(iPos + c2.length)
						];
						oHash[aT2[0]] = aT2[1];
					}
				}
			}
		}
		return oHash;
	}	
		
	var aCharts = document.getElementsByClassName?document.getElementsByClassName("chart"):getElementsByClassName(document.body, "*", "chart");
	
	for (var c=0,cLen=aCharts.length;c<cLen;c++) {
		var sChartId = aCharts[c].id.replace("-img", "");
		var oMap = document.getElementById(sChartId+"-map");
		var oTooltip = document.getElementById(sChartId+"-tooltip");
		for (var i=0,iLen=oMap.childNodes.length;i<iLen;i++) {
			oMap.childNodes[i].onmouseover = function(ev) {
				ev = ev || window.event;
				var oTarget = ev.target || ev.srcElement;
				var sTargetId = oTarget.id;
				// handle the optional extra --XXX on ids
				var iPosExtra = -1;
				if ((iPosExtra=sTargetId.indexOf("--")) != -1) {
					sTargetId = sTargetId.substring(0, iPosExtra);
				}
				// extract chart id
				var iPosDash = sTargetId.indexOf("-");
				var sChartId = sTargetId.substring(0, iPosDash);

				if (CFCHART.nodes[sChartId][sTargetId]) {
					oTooltip.innerHTML = CFCHART.nodes[sChartId][sTargetId].text;
					var oCss = dblSplit(CFCHART.nodes[sChartId][sTargetId].tooltipCss, ";", ":");
					for (var sAttr in oCss) {
						if (sAttr == "backgroundImage" && oCss[sAttr] == "url('')") {
							oCss[sAttr] = "none";
						}
						oTooltip.style[sAttr] = oCss[sAttr];
					}
					oTooltip.style.display = "block";
					oTooltip.style.position = "fixed";
					oTooltip.style.visibility = "hidden";
					oTooltip.style.left = (ev.clientX - parseInt(oTooltip.offsetWidth/2, 10)) + "px";
					oTooltip.style.top = (ev.clientY - oTooltip.offsetHeight - 15) + "px";
					oTooltip.style.visibility = "visible";
				}
			}
			oMap.childNodes[i].onmousemove = function(ev) {			
				ev = ev || window.event;
				oTooltip.style.left = (ev.clientX - parseInt(oTooltip.offsetWidth/2, 10)) + "px";
				oTooltip.style.top = (ev.clientY - oTooltip.offsetHeight - 15) + "px";
			}
			oMap.childNodes[i].onmouseout = function(ev) {
				oTooltip.style.display = "none";
			}
			oMap.childNodes[i].onclick = function(ev) {
				oTooltip.style.display = "none";
			}
		}
	}
}
