Feature: Sign up new user

    Background: Define URL
        Given url apiUrl
    
    @debug
    Scenario: New User signup
        Given def userData = {"email": "k_test174@test.com","username": "k_test174"}
        Given path 'users'
        And request 
        """
            {
                "user": {
                    "email": #('Test'+userData.email),
                    "password": "aassdf124",
                    "username": #('user'+userData.username)
                }
            }
        """
        When method Post
        Then status 200