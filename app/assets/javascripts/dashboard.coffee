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
  new_frequency = $(this).val().toString()
  old_frequency = $(this).data('old-frequnecy').toString()
  ajaxOption = {
    url:'/dashboard/save_frequency'
    method: 'POST'
    dataType: 'JSON'
    data:
      id: $(this).data('sid'),
      frequency: new_frequency,
      authenticity_token: $('[name="csrf-token"]')[0].content
    success: (response) ->
      if response.status == 200
        alert(response.msg)
        $(this).data('old-frequnecy', new_frequency)
  }
  if new_frequency != old_frequency
    $.ajax ajaxOption

$(document).on 'click', '#send-sms-button', (e) ->
  $phoneNumberElem = $('#mobile-number')
  phoneNumber = $phoneNumberElem.val().toString()
  ajaxOption = {
    url:'/dashboard/send_sms'
    method: 'POST'
    dataType: 'JSON'
    data:
      phone_number: phoneNumber,
      authenticity_token: $('[name="csrf-token"]')[0].content
    success: (response) ->
      if response.status == 200 then alert(response.msg)
  }
  $.ajax ajaxOption

$(document).on 'click', '#clear-seo-url', (e) ->
  ajaxOption = {
    url:'/dashboard/clear_seo_url'
    method: 'POST'
    dataType: 'JSON'
    data:
      authenticity_token: $('[name="csrf-token"]')[0].content
    success: (response) ->
      if response.status == 200
        alert(response.msg)
        window.location.reload()
  }
  $.ajax ajaxOption