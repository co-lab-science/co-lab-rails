$(document).ready(function() {
  try {
    var contentId = $('#content-meta-info').data().contentId;
    var userid = $('#content-meta-info').data().userid;
    var contentType = $('#content-meta-info').data().contentType;
    var hasUpvotedCurrentContent =  $('#content-meta-info').data().contentHasUpvotedCurrent
    var hasDownvotedCurrentContent =  $('#content-meta-info').data().contentHasDownvotedCurrent
  } catch(e) {

  }

  try {

    if (hasUpvotedCurrentContent) {
      $('.main-upvote').css('color', '#1b79be')
    }
    if (hasDownvotedCurrentContent) {
      $('.main-downvote').css('color', '#1b79be')
    }

  } catch(e) {}
  if (userid) {
    $('.main-upvote').on('click', function() {

      var contentKey = contentType.toLowerCase() + '_id'
      if(hasUpvotedCurrentContent) {

        var postData = { user_id: userid, vote_type: "upvote"}
        postData[contentKey] = contentId
        $('#content-meta-info').data('contentHasUpvotedCurrent', false)
        $.ajax({
          type: 'delete',
          url: '/votes' + "/0",
          data: postData,
          success: function(data) {
            location.reload();
          }
        });
      } else {

        $(this).css('color', '#1b79be')
        $('#content-meta-info').data('contentHasUpvotedCurrent', true)

        var postData = { user_id: userid, vote_type: "upvote"}
        postData[contentKey] = contentId

        $.ajax({
          type: 'post',
          url: '/votes',
          data: postData,
          success: function() {
            location.reload();
          }
        });
      }
    })
    $('.main-downvote').on('click', function() {

      var contentKey = contentType.toLowerCase() + '_id'
      if(hasDownvotedCurrentContent) {

        var postData = { user_id: userid, vote_type: "downvote"}
        postData[contentKey] = contentId
        $('#content-meta-info').data('contentHasDownvotedCurrent', false)
        $.ajax({
          type: 'delete',
          url: '/votes' + "/0",
          data: postData,
          success: function(data) {
            location.reload();
          }
        });
      } else {

        $(this).css('color', '#1b79be')
        $('#content-meta-info').data('contentHasDownvotedCurrent', true)

        var postData = { user_id: userid, vote_type: "downvote"}
        postData[contentKey] = contentId

        $.ajax({
          type: 'post',
          url: '/votes',
          data: postData,
          success: function() {
            location.reload();
          }
        });
      }
    })
  }
})
