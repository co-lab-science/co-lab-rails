$(document).ready(function() {
  $('#summernote').summernote({
    callbacks: {
      onImageUpload: function(files, editor, welEditable) {
        function sendfFile(file, callback) {
          data = new FormData()
          data.append("file", file)
          $self = $(this)
          $.ajax({
            url: '/upload',
            data: data,
            cache: false,
            contentType: false,
            processData: false,
            type: 'POST',
            success: function(data) {
              url = data.public_url
              img = document.createElement('img');
              img.src = url
              img.className = "summernote-img"
              $('#summernote').summernote('insertNode', img);
            }
          })
        }
        sendfFile(files[0])
      }
    }
  });
  $('.note-btn').eq(19).remove()
  $('.note-btn').eq(20).remove()
  $('.note-btn').eq(20).remove()
})
