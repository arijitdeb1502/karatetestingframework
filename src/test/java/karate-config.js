function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://conduit.productionready.io/api/'
  }
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
    config.userEmail = 'test123456789012345@test.com';
    config.userPassword = 'aRijan1@3';
  } else if (env == 'e2e') {
    // customize
  }

  let accessToken=karate.callSingle('classpath:helpers/CreateToken.feature',config).authToken
  karate.configure('headers',{Authorization: 'Token ' + accessToken})
  return config;
}