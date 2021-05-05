#@debug
Feature: Articles

    Background: Define URL
        Given url apiUrl
        * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * set articleRequestBody.article = dataGenerator.getRandomArticleValues()
            
        Scenario: Create and delete article
        # Given header Authorization = 'Token ' + token
        And path 'articles'
        And request articleRequestBody
        When method Post
        Then status 200
        * def articleId = response.article.slug

        # Given header Authorization = 'Token ' + token
        And path 'articles',articleId
        When method Delete
        Then status 200