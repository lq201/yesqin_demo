# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on 'click', '#send-email-button', (e) ->
  ajaxOption = {
    url:'/dashboard/send_email'
    method: 'POST'
    dataType: 'JSON'
    data:
      address: $('#email-address').val(),
      authenticity_token: $('[name="csrf-token"]')[0].content
    success: (response) ->
      if response.status == 200 then alert(response.msg)
  }
  $.ajax ajaxOption

$(document).on 'blur', '#set-frequency', (e) ->
  ajaxOption = {
    url:'/dashboard/save_frequency'
    method: 'POST'
    dataType: 'JSON'
    data:
      id: $(this).data('sid'),
      frequency: $(this).val(),
      authenticity_token: $('[name="csrf-token"]')[0].content
    success: (response) ->
      if response.status == 200 then alert(response.msg)
  }
  $.ajax ajaxOption