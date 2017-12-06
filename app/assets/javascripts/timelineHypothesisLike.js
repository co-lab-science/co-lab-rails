$(document).ready(function() {
  var likesUrl = '/likes'
  try {
    var contentId = $('#post-meta-info').data().contentId;
    var userid = $('#post-meta-info').data().userid;
    var contentType = $('#post-meta-info').data().contentType;
    var hasLikedCurrentContent =  $('#post-meta-info').data().contentHasLikedCurrent
    var hasDislikedCurrentContent =  $('#post-meta-info').data().contentHasDislikedCurrent
  } catch(e) {

  }

  try {


  } catch(e) {}
  if (userid) {
    $('.main-like').on('click', function() {

      var contentKey = contentType.toLowerCase() + '_id'
      if(!hasLikedCurrentContent) {
        $('#myModal').modal('show')
        $('body').on('click', '#hypothesis-submit', function() {
          if ($('#review-submission-content').val().trim() != "" && $('#review-submission-title').val().trim() != "") {
            $.ajax({
                   type: 'post',
                   url: likesUrl,
                   data: { like_type: "like", hypothesis_id: contentId, user_id: userid },
                   success: function(data) {
                     $.ajax({
                            type: 'post',
                            url: '/reviews',
                            data: { review: { body: $('#review-submission-content').val(), title: $('#review-submission-title').val(), user_id: userid, hypothesis_id: contentId } },
                            success: function(data) {
                              window.location.reload();
                            }
                     });
                   },
            });
          } else {
            alert("Title and content of your review cannot be empty.")
          }
        })
      } else {
        $.ajax({
               type: 'delete',
               url: likesUrl + "/0",
               data: { user_id: userid, like_type: "like", hypothesis_id: contentId},
               success: function(data) {
                 window.location.reload();
               },
        });
      }
    })

    $('.main-dislike').on('click', function() {

      var contentKey = contentType.toLowerCase() + '_id'
      if(!hasDislikedCurrentContent) {
        $('#myModal').modal('show')
        $('body').on('click', '#hypothesis-submit', function() {
          if ($('#review-submission-content').val().trim() != "" && $('#review-submission-title').val().trim() != "") {
            $.ajax({
                   type: 'post',
                   url: likesUrl,
                   data: { like_type: "dislike", hypothesis_id: contentId, user_id: userid },
                   success: function(data) {
                     $.ajax({
                            type: 'post',
                            url: '/reviews',
                            data: { review: { body: $('#review-submission-content').val(), title: $('#review-submission-title').val(), user_id: userid, hypothesis_id: contentId } },
                            success: function(data) {
                              window.location.reload();
                            }
                     });
                   },
            });
          } else {
            alert("Title and content of your review cannot be empty.")
          }
        })
      } else {
        $.ajax({
               type: 'delete',
               url: likesUrl + "/0",
               data: { user_id: userid, like_type: "dislike", hypothesis_id: contentId},
               success: function(data) {
                 window.location.reload();
               },
        });
      }
    })
  }
})
