$(document).ready(function() {
  var contentId = $('#content-meta-info').data().contentId
  var userid = $('#content-meta-info').data().userid

  $('#comments-container').comments({
    textareaRows: 2,
    maxRepliesVisible: 2,
    profilePictureURL: 'https://app.viima.com/static/media/user_profiles/user-icon.png',
    fieldMappings: {
      created: 'created_at',
      content: 'title'
    },
    getComments: function(success, error) {
      $.get('/observations/' + contentId + '.json', function(data) {
        var sanitizedCommentsArray = JqueryCommentHelper.sanitizeParentId(data.related_observations, contentId)
        console.log(sanitizedCommentsArray)
        success(sanitizedCommentsArray);
        renderDownvotes()
        sanitizedCommentsArray.forEach(function(comment) {
          $('.comment*[data-id="' + comment.id + '"]').find('.downvote-count').html(comment.downvote_count)
          $('.comment*[data-id="' + comment.id + '"]').data("user_has_downvoted", comment.user_has_downvoted)
          if (comment.user_has_downvoted) {
            $('.comment*[data-id="' + comment.id + '"]').find('.downvote').eq(0).addClass('highlight-font')
          }
        })
      })
    },
    postComment: function(commentJSON, success, error) {
      commentData = { lab: { title: commentJSON.title, parent: (commentJSON.parent || contentId), user_id: userid } }
      $.ajax({
        type: 'post',
        url: '/observations',
        data: commentData,
        success: function(comment) {
          if (comment.observation.parent == contentId) {
            delete comment.observation["parent"]
          }
          success(comment.observation)
          debugger
          handleNewComment(comment.observation.id)
        },
        error: error
      });
    },
    upvoteComment: function(commentJSON, success, error) {
      var upvotesURL = '/votes'
      if(commentJSON.user_has_upvoted) {
        $.ajax({
          type: 'post',
          url: upvotesURL,
          data: { vote_type: "upvote", lab_id: commentJSON.id, user_id: userid },
          success: function() {
            success(commentJSON)
          },
          error: error
        });
      } else {
        $.ajax({
          type: 'delete',
          url: upvotesURL + "/0",
          data: { user_id: userid, vote_type: "upvote", lab_id: commentJSON.id},
          success: function() {
            success(commentJSON)
          },
          error: error
        });
      }
    }
  });

  function renderDownvotes() {
    var markup = '<button class="action downvote"><span class="downvote-count">0</span><i class="fa fa-thumbs-down"></i></button>';
    $('.actions').append(markup)
    attachDownvoteEvents()
  }

  function handleNewComment(commentId) {
    var newCommentNode = $('.comment*[data-id="' + commentId + '"]').find('.actions').append('<button class="action downvote"><span class="downvote-count">0</span><i class="fa fa-thumbs-down"></i></button>')
    attachDownvoteEvents($('.comment*[data-id="' + commentId + '"]').find('.actions').find('.downvote'))
  }

  function attachDownvoteEvents(node) {
    $clickNode = node || $('.actions .downvote')
    $clickNode.on('click', function() {
      var upvotesURL = '/votes'
      var commentId = $(this).closest('.comment').data().id
      var userHasDownvoted = $(this).closest('.comment').data().user_has_downvoted

      if(!userHasDownvoted) {
        $.ajax({
          type: 'post',
          url: upvotesURL,
          data: { vote_type: "downvote", lab_id: commentId, user_id: userid },
          success: function() {
            //success(commentJSON)
          },
        });
      } else {
        $.ajax({
          type: 'delete',
          url: upvotesURL + "/0",
          data: { user_id: userid, vote_type: "downvote", lab_id: commentId},
          success: function() {
          },
        });
      }

      if ($(this).hasClass('highlight-font')) {
        $(this).removeClass('highlight-font')
        var downvoteCount = parseInt($(this).find('.downvote-count').html()) - 1
        $(this).find('.downvote-count').html(downvoteCount)

      } else {
        $(this).addClass('highlight-font')
        var downvoteCount = parseInt($(this).find('.downvote-count').html()) + 1
        $(this).find('.downvote-count').html(downvoteCount)
      }
    })
  }

  JqueryCommentHelper = {
    sanitizeParentId: function(commentsArray, contentId) {
      var commentsArrayCopy = JSON.parse(JSON.stringify(commentsArray))
      return commentsArrayCopy.map((comment) => { if (comment.parent == contentId) delete comment["parent"]; return comment })
    }
  }

  $('#comments-container').hide()
  $('.comment-type').eq(0).on('click', function () {
    $('#comments-container').fadeIn()
  })
})

