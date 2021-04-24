Feature: Sign up new user

    Background: Define URL
        * def dataGenerator = Java.type('helpers.DataGenerator');
        * def timeValidator = read('classpath:helpers/timeValidator.js')

        Given url apiUrl
    
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
        And match response == 
        """
            {
                "user": {
                    "id": "#number",
                    "email": #(randomEmail),
                    "createdAt": "#? timeValidator(_)",
                    "updatedAt": "#? timeValidator(_)",
                    "username": #(randomUserName),
                    "bio": null,
                    "image": null,
                    "token": "#string"
                }
            }
        """

    @debug
    Scenario Outline: Validate signup error messages
        # Given def userData = {"email": "k_test174@test.com","username": "k_test174"}
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUserName = dataGenerator.getRandomUserName()

        Given path 'users'
        And request 
        """
            {
                "user": {
                    "email": "<email>",
                    "password": "<password>",
                    "username": "<username>"
                }
            }
        """
        When method Post
        Then status 422
        And match response == <errorResponse>

        Examples:
            | email                 | password  | username          | errorResponse                                      |
            | #(randomEmail)        | Karate123 | k____test123      | {"errors":{"username":["has already been taken"]}} |
            | k____test123@test.com | Karate123 | #(randomUserName) | {"errors":{"email":["has already been taken"]}} |
