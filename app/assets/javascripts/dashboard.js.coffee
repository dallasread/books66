$ ->
	
	if $(window).width() > 700
	
		$(window).resize () ->
			$(".innery").height $(window).height() - 175
			$("#stories").css "max-height", $(window).height() - 175
	
		$(window).resize()