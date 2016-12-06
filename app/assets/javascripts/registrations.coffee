# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# window.NestedFormEvents::insertFields = (content, assoc, link) ->
#   console.log('inserting fields')
#   $tr = $(link).closest('tr')
#   $(content).insertBefore $tr

$(document).ready ->
  $('.form-control').on('focus blur', (e) ->
    $(this).parents('.form-group').toggleClass 'focused', e.type == 'focus' or @value.length > 0
    return
  ).trigger 'blur'
