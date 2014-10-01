# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
	$('.endorsement-link').on 'click', (event) ->
		event.preventDefault()
		endorsementCount = $(this).siblings '.endorsement-count'
		$.post this.href, (response) ->
			endorsementCount.text response.new_endorsement_count