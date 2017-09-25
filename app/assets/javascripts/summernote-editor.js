UPLOADCARE_PUBLIC_KEY="f2e6727ba7a5ebff4bd8"
$(document).ready(function() {
  $('#summernote').summernote({
    toolbar: [
      ['uploadcare', ['uploadcare']], // here, for example
      ['style', ['style']],
      ['font', ['bold', 'italic', 'underline', 'clear']],
      ['fontname', ['fontname']],
      ['color', ['color']],
      ['para', ['ul', 'ol', 'paragraph']],
      ['height', ['height']],
      ['table', ['table']],
      ['insert', ['media', 'link', 'hr']],
      ['view', ['fullscreen']],
      ['help', ['help']]
    ],
    uploadcare: {
      // button name (default is Uploadcare)
      buttonLabel: 'Image / file',
      // font-awesome icon name (you need to include font awesome on the page)
      buttonIcon: 'picture-o',
      // text which will be shown in button tooltip
      tooltipText: 'Upload files or video or something',

      // uploadcare widget options, see https://uploadcare.com/documentation/widget/#configuration
      publicKey: 'f2e6727ba7a5ebff4bd8', // set your API key
      crop: 'free',
      tabs: 'all',
      multiple: true
    }
  });
})
