$(document).ready(function() {
  $('#fileupload').fileupload({
    dataType: 'json',
    add: function (e, data) {
      $('#citations-container-jq').prepend('<p id="loading-message"> Uploading... </p>')
      data.submit()
    },
    done: function (e, data) {
      $('#citations-container-jq').find('ul').prepend('<a href = "' + data.result.url + '"><li>'+ data.result.name  +'</li></a>')
      $('#loading-message').remove()
    }
  });
})
