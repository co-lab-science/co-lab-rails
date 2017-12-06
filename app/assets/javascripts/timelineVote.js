$(document).ready(function() {
  try {
    var contentId = $('#post-meta-info').data().contentId;
    var userid = $('#post-meta-info').data().userid;
    var contentType = $('#post-meta-info').data().contentType;
    var hasUpvotedCurrentContent =  $('#post-meta-info').data().contentHasUpvotedCurrent
    var hasDownvotedCurrentContent =  $('#post-meta-info').data().contentHasDownvotedCurrent
  } catch(e) {

  }

  try {


  } catch(e) {}
  if (userid) {
    $('.timeline-upvote').on('click', function() {

      var contentKey = contentType.toLowerCase() + '_id'
      if(hasUpvotedCurrentContent) {

        var postData = { user_id: userid, vote_type: "upvote"}
        postData[contentKey] = contentId
        $('#post-meta-info').data('contentHasUpvotedCurrent', false)
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
        $('#post-meta-info').data('contentHasUpvotedCurrent', true)

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
    $('.timeline-downvote').on('click', function() {

      var contentKey = contentType.toLowerCase() + '_id'
      if(hasDownvotedCurrentContent) {

        var postData = { user_id: userid, vote_type: "downvote"}
        postData[contentKey] = contentId
        $('#post-meta-info').data('contentHasDownvotedCurrent', false)
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
        $('#post-meta-info').data('contentHasDownvotedCurrent', true)

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
