$ ->
	$(window).resize ->
		$.fn.resizer()
	
	$("#nav a").live "click", () ->
		tab = $(this).attr("href")
		$("#nav a.selected").removeClass("selected")
		$(this).addClass("selected")
		$(".main_frame").hide()
		$(tab).show()
		false

	$(".tip .do_search").live "click", ->
		title = $(this).parents(".tip").find(".title").text()
		$("#q").val title
		$("#search").submit()
		false

	$("a[title]").qtip
		position:
			my: "top center"
			at: "bottom center"
			viewport: $(window)
		style:
			classes: 'ui-tooltip-youtube'
		show:
			delay: 0
	
	$("form").live "submit", () ->
		$("#results_count").text("Loading Results")
	
	$(".margin_view").live "click", () ->
		if $("#bible").hasClass "show_margins"
			$("#bible").removeClass "show_margins", 300
		else
			$("#bible").addClass "show_margins", 300
		false
	
	$(".margin").live "blur", () ->
		url = $(this).data("url")
		body = $(this).html()
		$.post url, 
			"_method": "put"
			"margin[body]": body
	
	#$(document).ready () ->
	#	$("#search").submit()
	
	$(".chapter_select").live "click", () ->
		$(".chapter_select").removeClass("selected")
		$(this).addClass("selected")
		$(".chapter_reference").click()
	
	$(".chapter_reference").live "click", () ->
		$("#reference_selector").toggle()
		
	$(".book_select").live "click", () ->
		permalink = $(this).data("permalink")
		$(".book_select").removeClass("selected")
		$(this).addClass("selected")
		
		$("#chapters").html("")
		i = 1
		while i <= $(this).data("chapters_count")
			$("#chapters").append("<a href='/kjv/#{permalink}/#{i}' data-remote='true' class='chapter_select'>#{i}</a>")
			i += 1
	
	$(".margin_wrapper").live "click", () ->
		$(this).find("[contenteditable]").focus()
	
	if !$(".signed_in").length
		$("#nav a:last").click()
	
	$("#search_results .verse").live
		"mouseenter": () ->
			$(this).addClass("hover")
		"mouseleave": () ->
			$(this).removeClass("hover")
		"click": () ->
			url = $(this).data("verse_url")
			$("#search_results .verse.selected").removeClass("selected")
			$(this).addClass("selected")
			$.getScript url
	
	$("#stories_list .story").live
		"mouseenter": () ->
			$(this).addClass("hover")
		"mouseleave": () ->
			$(this).removeClass("hover")
		"click": () ->
			url = $(this).data("story_url")
			$("#stories_list .story.selected").removeClass("selected")
			$(this).addClass("selected")
			$.getScript url

	#$(".verse").live "click", (e) ->
	#	$(".tip").remove()
	#	if $(this).hasClass("selected")
	#		$(this).removeClass "selected"
	#	else
	#		$(".word.selected").removeClass "selected"
	#		$(this).addClass "selected"
	#		$("<div class='tip'><span class='font_awesome do_search'><i class=\"icon-search\"></i></span><span class='title'>Phaino</span><span class='pronunciation'>pronounced fah'-ee-no</span><span class='definition'>prolongation for the base of 5457; to lighten (shine), i.e. show (transitive or intransitive, literal or figurative):-- appear, seem, be seen, shine, X think.</span></div>").prependTo $(this)
	#		$(this).find(".tip").css "top", $(this).offset().top + $(this).height() + 10

	$.fn.resizer()

$.fn.setMargins = ->
	$(".margin").each () ->
		$(this).css
			"height": $(this).parents(".verse_wrapper").height()

$.fn.resizer = ->
	main_top = $("#main_frame").offset().top
	window_height = $(window).height()
	main_height = window_height - main_top - 5
	
	bible_top = 5 + $("#bible .header").height()
	bible_height = window_height - bible_top
	
	search_results_top = $("#search_results").offset().top
	search_results_height = window_height - search_results_top - 5
	
	$("#bible .chapter_body").css "height", bible_height
	$("#story_wrapper .content").css "height", bible_height
	$("#search_results").css "height", search_results_height
	$("#main_frame").css "height", main_height