/**
 * @author Huy Dinh
 * @date Sept 2008
 * @version 0.1
 * 
 * A plug in to show a magnify effect on images
 */
(function ($) {
	var zoomImageContainerCentreX,
		zoomImageContainerCentreY,
		zoomImageContainerHeight,
		zoomImageContainerWidth,
		thumbImageOffsetX,
		thumbImageOffsetY,
		sensorWidth,
		sensorHeight,
		zoomImageWidth,
		zoomImageHeight,
		zoomImage = $("<img style='position:absolute'/>"),
		zoomImageContainer = $("<div id='huy-magnifier' style='overflow:hidden;position:absolute;display:none;'></div>").append(zoomImage),
		sensor = $("<div style='position:absolute;top:0;left:0;background-color:#fff;opacity:0;filter:Alpha(Opacity=0);cursor:crosshair;'></div>").mousemove(function(e) {
			zoomImageContainer.css({
				left:e.pageX - zoomImageContainerCentreX,
				top:e.pageY - zoomImageContainerCentreY
			});
			zoomImage.css({
				left:((e.pageX - thumbImageOffsetX) / sensorWidth) * -(zoomImageWidth - zoomImageContainerWidth),
				top:((e.pageY - thumbImageOffsetY) / sensorHeight) * -(zoomImageHeight - zoomImageContainerHeight)
			});
		}).bind("mouseleave", function() {
			zoomImageContainer.hide();
			sensor.hide();
		});
	$(function() {
		$("body").append(zoomImageContainer).append(sensor);
		zoomImageContainerWidth = zoomImageContainer.width();
		zoomImageContainerHeight = zoomImageContainer.height();
		zoomImageContainerCentreX = zoomImageContainerWidth * .5;
		zoomImageContainerCentreY = zoomImageContainerHeight * .5;
	});
	$.fn.magnify = function() {
		var thumbImage = this,
			fullWidth = this.width();
			fullHeight = this.height()
			thumbContainer = this.parent().css({
				position:"relative"
			});
			thumbImage.data("fullWidth", this.width());
			thumbImage.data("fullHeight", this.height());
		this.attr("alt","").bind("mouseenter", function(){
			sensorWidth = thumbImage.width();
			sensorHeight = thumbImage.height();
			thumbImageOffsetX = thumbImage.offset().left;
			thumbImageOffsetY = thumbImage.offset().top;
			zoomImage.attr("src", thumbImage.attr("src"));
			zoomImageWidth = thumbImage.data("fullWidth"),
			zoomImageHeight = thumbImage.data("fullHeight"),
			sensor.css({
				width:sensorWidth + "px",
				height:sensorHeight + "px",
				left:thumbImageOffsetX + "px",
				top:thumbImageOffsetY + "px"
			}).show();
			zoomImageContainer.fadeIn("fast");
		});
		if (this.width() > this.height()) {
			this.height(this.height() / (this.width() / thumbContainer.width())).width(thumbContainer.width()).css({
				bottom:0
			});
		} else {
			var thumbImageWidth = this.width() / (this.height() / thumbContainer.height());
			this.width(thumbImageWidth).height(thumbContainer.height()).css({
				marginLeft:((thumbContainer.width() - thumbImageWidth) * 0.5) + "px"
			});
		}
		return this;
	}
})(jQuery);
