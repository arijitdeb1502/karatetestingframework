Feature: Tests for the home Page

    Background: Define URL
        Given url apiUrl

    Scenario: Get all tags
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags contains ["‌","HuManIty","Hu‌Man‌Ity","Gandhi","HITLER","SIDA","BlackLivesMatter","Black‌Lives‌Matter","test","dragons","butt"]
        And match response.tags !contains 'Arijit'
        And match response.tags == '#array'
        And match each response.tags == '#string'
    
    Scenario: Get 10 articles from the page
        * def timeValidator = read('classpath:helpers/timeValidator.js')

        Given params { limit: 10,offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles == '#[10]'
        And match response.articlesCount == 500
        And match each response.articles == 
        """
            {
                "title": "#string",
                "slug": "#string",
                "body": "#string",
                "createdAt": "#? timeValidator(_)",
                "updatedAt": "#? timeValidator(_)",
                "tagList": '#array',
                "description": "#string",
                "author": {
                    "username": "#string",
                    "bio": "##string",
                    "image": "#string",
                    "following": '#boolean'
                },
                "favorited": '#boolean',
                "favoritesCount": '#number'
            }
        """
    Scenario: Conditional Logic
        Given params { limit: 10,offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        * def favoritesCount = response.articles[0].favoritesCount
        * def article = response.articles[0] 

        * if (favoritesCount == 0) karate.call('classpath:helpers/AddLikes.feature',article)

        Given params { limit: 10,offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].favoritesCount == 1