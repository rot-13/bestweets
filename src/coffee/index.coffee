$ ->

  $username = $('.js-username')
  $submit   = $('.js-submit')
  $tweets_container = $('.js-tweets-container')
  $tweet_list   = $('.js-tweet-list')

  $submit.on 'click', ->
    $tweets_container.addClass('spin')

    username = $username.val()
    $.getJSON "/#{username}", (response) ->
      ($tweet_list.append(tweet_html) for tweet_html in response.tweets)
      twttr.widgets.load($tweet_list[0])

      $tweets_container.removeClass('spin')
