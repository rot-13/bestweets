$ ->

  $username = $('.js-username')
  $submit   = $('.js-submit')
  $tweets_container = $('.js-tweets-container')
  $tweet_list   = $('.js-tweet-list')

  getTweets = ->
    $tweets_container.addClass('spin')

    username = $username.val()
    if username.length > 0
      $.getJSON "/best/#{username}", (response) ->
        if response.error
          $tweet_list.html(response.error)
        else
          $tweet_list.empty()
          ($tweet_list.append(tweet_html) for tweet_html in response.tweets)
          twttr.widgets.load($tweet_list[0])

        $tweets_container.removeClass('spin')

  $submit.on 'click', getTweets
  $username.on 'keyup', (e) ->
    getTweets() if e.which == 13

  path = window.location.pathname.slice(1)
  if path != ''
    $username.val(path)
    getTweets()
