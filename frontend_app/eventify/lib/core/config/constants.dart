final String _baseUrl = "http://localhost:8000/";


//auth routes

//post route required email username full name and password in request body
String signupUrl(String role) => "$_baseUrl/auth/signup?role=$role";

//post route required email and password in request body
final String loginUrl = "$_baseUrl/auth/login";

//public route

//get route to get all the events for users home screen
final String getEvents = "$_baseUrl/public/all";