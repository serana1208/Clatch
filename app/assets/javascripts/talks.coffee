# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
 $('#request_talk_update')
   .on 'ajax:complete',(event) -> 
    response = event.detail[0].response
    $('#updated_by_ajax').html(response)
    $('#data_name').val('')
    $('#data_content').val('')
    $('#updated_by_ajax').scrollTop($('#updated_by_ajax').get(0).scrollHeight)

$ ->
 $(window).load ->
    $('#updated_by_ajax').scrollTop($('#updated_by_ajax').get(0).scrollHeight)
