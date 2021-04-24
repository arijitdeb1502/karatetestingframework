Feature: Sign up new user

    Background: Define URL
        * def dataGenerator = Java.type('helpers.DataGenerator');
        Given url apiUrl
    
    @debug
    Scenario: New User signup
        # Given def userData = {"email": "k_test174@test.com","username": "k_test174"}
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUserName = dataGenerator.getRandomUserName()

        Given path 'users'
        And request 
        """
            {
                "user": {
                    "email": #(randomEmail),
                    "password": "aassdf124",
                    "username": #(randomUserName)
                }
            }
        """
        When method Post
        Then status 200