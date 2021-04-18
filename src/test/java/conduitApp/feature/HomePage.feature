Feature: Tests for the home Page

    Background: Define URL
        Given url 'https://conduit.productionready.io/api/'

    @debug
    Scenario: Get all tags
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags contains ["‌","HuManIty","Hu‌Man‌Ity","Gandhi","HITLER","SIDA","BlackLivesMatter","Black‌Lives‌Matter","test","dragons","butt"]
        And match response.tags !contains 'Arijit'
        And match response.tags == '#array'
        And match each response.tags == '#string'

    Scenario: Get 10 articles from the page
        Given params { limit: 10,offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles == '#[10]'
        And match response.articlesCount == 500

        