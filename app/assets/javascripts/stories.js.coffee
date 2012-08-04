$ ->
	$(".title a").live "click", () ->
		$(this).parents(".inner_wrapper").find(".picker").toggle()
		false
	
	$("html").live "click", (e) ->
		$("#stories").hide()