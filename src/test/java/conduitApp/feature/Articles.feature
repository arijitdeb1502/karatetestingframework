Feature: Articles

    Background: Define URL
        Given url apiUrl
        # * def tokenResponse = callonce read('classpath:helpers/CreateToken.feature')
        # * def token = tokenResponse.authToken


    Scenario: Create a new article
        # Given header Authorization = 'Token ' + token
        And path 'articles'
        And request {"article": {"tagList": [],"title": "DDDDDDDD","description": "GGGGGGG","body": "gddtnnh\nkhhkmb"}}
        When method Post
        Then status 200
        And match response.article.title == 'DDDDDDDD'
    Scenario: Create and delete article
        # Given header Authorization = 'Token ' + token
        And path 'articles'
        And request {"article": {"tagList": [],"title": "Delete Article1","description": "GGGGGGG","body": "gddtnnh\nkhhkmb"}}
        When method Post
        Then status 200
        * def articleId = response.article.slug

        Given params { limit: 10,offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title == 'Delete Article1'

        # Given header Authorization = 'Token ' + token
        And path 'articles',articleId
        When method Delete
        Then status 200

        Given params { limit: 10,offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title != 'Delete Article1'