# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.location.hash = ""  if window.location.hash and window.location.hash is "#_=_"
$(document).ready ->
  $("input[rel=\"tooltip\"]").tooltip()
  return