////////////   SET SALE PRICES FROM PERCENTAGE ////////////////

$(document).ready(function() {
	$('#addAllListings').toggle(
		function() {
			$(".addAll").attr('checked', true);
			$(".removeAll").attr('checked', false);
		},
		function() {
			$(".addAll").attr('checked', false);
	}); 
	$('#removeAllListings').toggle(
		function() {
			$(".removeAll").attr('checked', true);
			$(".addAll").attr('checked', false);
		},
		function() {
			$(".removeAll").attr('checked', false);
	});
});

setSalePricesFromPercentage = function(){
	var percentVal = $("#salePercent").val();
	$("[name=gallery_price]").each(function(){
		var gallVal = $(this).val();
		var saleClass = "." + $(this).attr("id");
		var saleVal = $(saleClass).val();
		var newSaleVal = (percentVal*gallVal)/100; 
		newSaleVal = (gallVal-newSaleVal).toFixed(2)
		$(saleClass).val(newSaleVal);
	});
}

useHE = function() {
	$(".useH").attr('checked','checked');
}

useSP = function() {
	$(".useS").attr('checked','checked');
}

validateRemove = function(thisId) {
	var thisCheckbox = "#add_to_sale_" + thisId;
	var removeCheckbox = "#remove_from_sale_" + thisId;
	if($(thisCheckbox).attr("checked")){
		$(removeCheckbox).attr("checked", false);
	}
}

validateAdd = function(thisId) {
	var thisCheckbox = "#remove_from_sale_" + thisId;
	var addCheckbox = "#add_to_sale_" + thisId;
	if($(thisCheckbox).attr("checked")){
		$(addCheckbox).attr("checked", false);
	}
}


