Feature: Articles

    Background: Define URL
        Given url 'https://conduit.productionready.io/api/'
        And path 'users/login'
        And request {"user": {"email": "test123456789012345@test.com","password": "aRijan1@3"}}
        When method Post
        Then status 200
        * def token = response.user.token
    Scenario: Create a new article
        Given header Authorization = 'Token ' + token
        And path 'articles'
        And request {"article": {"tagList": [],"title": "DDDDDDDD","description": "GGGGGGG","body": "gddtnnh\nkhhkmb"}}
        When method Post
        Then status 200
        And match response.article.title == 'DDDDDDDD'