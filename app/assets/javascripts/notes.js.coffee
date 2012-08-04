$ ->
	if $(".note_area").length
		$("#full_story .innery").live "click", (e) ->
			if $(e.target).hasClass("innery")
				$(".note_area:last").focus()
	
		$("#bible .verse_number").live "click", () ->
			verse = $(this).parents(".verse").clone()
			if $(".note_area:last").html() == ""
				verse.insertBefore $("#full_story .innery li:last")
			else
				verse.insertAfter $("#full_story .innery li:last")
			verse.find(".verse_number").replaceWith '<a href="#" class="verse_reference">' + verse.data("reference") + '</a>'
			$.fn.setSortable()
	
		$.fn.setSortable()
	
	$(".handle").live
		"mouseenter": () ->
			$(this).find("img").attr "src", "/assets/ns-resize-hover.png"
		"mouseleave": () ->
			$(this).find("img").attr "src", "/assets/ns-resize.png"
			
	$(".delete").live
		"mouseenter": () ->
			$(this).find("img").attr "src", "/assets/trash-hover.png"
		"mouseleave": () ->
			$(this).find("img").attr "src", "/assets/trash.png"
		"click": () ->
			if confirm("Are you sure you want to delete this?")
				$(this).parents("li").fadeOut()
				$.fn.setSortable()

$.fn.setSortable = () ->
	if $("#storyline li").length > 1
		$("#storyline .note_area:not(:last)").each () ->
			if $(this).html() == ""
				$(this).parents("li").remove()
				
		if !$("#storyline li:last").hasClass("note")
			$($(".note_area:last").parents("li").clone()).insertAfter $("#full_story .innery li:last")
			$(".note_area:last").html("")
			
		$("#storyline li").each () ->
			#:not(:last)
			if !$(this).is(":visible")
				$(this).remove()
				
			if !$(this).find(".handle").length
				$("<span class='handle'><img src='/assets/ns-resize.png' /></span>").appendTo $(this)
				$("<span class='delete'><img src='/assets/trash.png' /></span>").appendTo $(this)
			
	$("#storyline").sortable
		handle: ".handle"
		axis: "y"
		stop: () ->
			$.fn.setSortable()