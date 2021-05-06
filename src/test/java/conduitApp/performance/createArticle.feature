#@debug
Feature: Articles

    Background: Define URL
        Given url apiUrl
        * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
        * def dataGenerator = Java.type('helpers.DataGenerator')
        # * set articleRequestBody.article = dataGenerator.getRandomArticleValues()
        * set articleRequestBody.article.title = __gatling.Title
        * set articleRequestBody.article.description = __gatling.Description
        * set articleRequestBody.article.body = __gatling.Body

        * def sleep = function(ms){ java.lang.Thread.sleep(ms) }
        * def pause = karate.get('__gatling.pause', sleep)

        Scenario: Create and delete article
        # Given header Authorization = 'Token ' + token
        And path 'articles'
        * print articleRequestBody.title
        * print articleRequestBody.description
        * print articleRequestBody.body

        And request articleRequestBody
        When method Post
        Then status 200
        # * def articleId = response.article.slug

        # * pause(20000)

        # # Given header Authorization = 'Token ' + token
        # And path 'articles',articleId
        # When method Delete
        # Then status 200