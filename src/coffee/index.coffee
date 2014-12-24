$ ->

  $username = $('.js-username')
  $submit   = $('.js-submit')
  $tweets_container = $('.js-tweets-container')
  $tweet_list   = $('.js-tweet-list')

  showTweets = (tweets) ->
    $tweet_list.empty()
    ($tweet_list.append(tweet_html) for tweet_html in tweets)
    twttr.widgets.load($tweet_list[0])

  showError = (error) ->
    $tweet_list.html(error)

  showResponse = (response) ->
    if response.error
      showError(response.error)
    else
      showTweets(response.tweets)

  getTweets = (username) ->
    $tweets_container.addClass('spin')

    $.getJSON "/best/#{username}", (response) ->
      showResponse(response)
      $tweets_container.removeClass('spin')

  loadUser = (username) ->
    getTweets(username)

    if window.history
      window.history.pushState({'username': username}, "Best tweets by @#{username}", username)

  usernameSubmit = ->
    username = $username.val()

    if username.length > 0
      if window.history
        loadUser(username)
      else
        window.location.pathname = username

  window.onpopstate = (e) ->
    if e.state
      username = e.state.username
      $username.val(username)
      getTweets(username)
    else
      $username.val('')
      $tweet_list.empty()

  $submit.on 'click', usernameSubmit
  $username.on 'keyup', (e) ->
    usernameSubmit() if e.which == 13

  username = window.location.pathname.slice(1)
  if username.length > 0
    loadUser(username)
    $username.val(username)
