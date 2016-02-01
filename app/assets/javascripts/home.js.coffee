scaleVideoContainer = ->
  height = $(window).height()
  unitHeight = parseInt(height) + 'px'
  $('.homepage-hero-module').css 'height', unitHeight
  return

initBannerVideoSize = (element) ->
  $(element).each ->
    $(this).data 'height', $(this).height()
    $(this).data 'width', $(this).width()
    return
  scaleBannerVideoSize element
  return

scaleBannerVideoSize = (element) ->
  windowWidth = $(window).width()
  windowHeight = $(window).height()
  videoWidth = undefined
  videoHeight = undefined
  $(element).each ->
    videoAspectRatio = $(this).data('height') / $(this).data('width')
    windowAspectRatio = windowHeight / windowWidth
    if videoAspectRatio > windowAspectRatio
      videoWidth = windowWidth
      videoHeight = videoWidth * videoAspectRatio
      $(this).css
        'top': -(videoHeight - windowHeight) / 2 + 'px'
        'margin-left': 0
    else
      videoHeight = windowHeight
      videoWidth = videoHeight / videoAspectRatio
      $(this).css
        'margin-top': 0
        'margin-left': -(videoWidth - windowWidth) / 2 + 'px'
    $(this).width(videoWidth).height videoHeight
    $('.homepage-hero-module .video-container video').addClass 'fadeIn animated'

$(document).ready ->
  scaleVideoContainer()
  initBannerVideoSize '.video-container .poster img'
  initBannerVideoSize '.video-container .filter'
  initBannerVideoSize '.video-container video'
  $(window).on 'resize', ->
    scaleVideoContainer()
    scaleBannerVideoSize '.video-container .poster img'
    scaleBannerVideoSize '.video-container .filter'
    scaleBannerVideoSize '.video-container video'

  $('#datetimepicker8').datetimepicker icons:
    time: 'fa fa-clock-o'
    date: 'fa fa-calendar'
    up: 'fa fa-arrow-up'
    down: 'fa fa-arrow-down'

  $('.clickable').click ->
    window.document.location = $(this).data('href')

  # hide .navbar first
  $('.navbar').hide()
  # fade in .navbar
  $(window).scroll ->
    # set distance user needs to scroll before we fadeIn navbar
    if $(this).scrollTop() > $('.video-container').height() - 100
      $('.navbar').fadeIn()
    else
      $('.navbar').fadeOut()


  $('.caption').readmore
    speed: 600
    moreLink: '<a class="text-center" href="#">More <i class="fa fa-chevron-circle-down"></i></a>'
    lessLink: '<a class="text-center" href="#">Less <i class="fa fa-chevron-circle-up"></a>'