jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip, a[rel=tooltip]").tooltip()

  $('#videoModal').on 'hidden', ->
    $('#videoModal .modal-body').empty()

  $('#videoModal').on 'shown', ->
    $('#videoModal .modal-body').append('<iframe src="https://player.vimeo.com/video/70415404" width="710" height="400" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>')