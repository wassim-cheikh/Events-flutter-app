import 'package:flutter/material.dart';
import 'package:test7/screens/signup.dart';
import '../utils/db.dart';
import 'EASelectCityScreen.dart'; // Import the correct screen
import 'adminlogin.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
  ),
);

class LoginPage extends StatelessWidget {
  final Color primaryColor1 = Color(0xFFED3269);
  final Color primaryColor2 = Color(0xFFFD5F3E);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [primaryColor1, primaryColor2, Colors.white],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Welcome Back",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 60),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(225, 95, 27, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey.shade200),
                                  ),
                                ),
                                child: TextField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    hintText: "Email ",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey.shade200),
                                  ),
                                ),
                                child: TextField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                        Align(
                          alignment: Alignment.center,
                          child: MaterialButton(
                            onPressed: () async {
                              String email = emailController.text;
                              String password = passwordController.text;

                              Map<dynamic, dynamic> userData = await validateUser(email, password);

                              if (userData.isNotEmpty) {
                                String username = userData['username'];
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EASelectCityScreen(username: username),
                                  ),
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Authentication Failed"),
                                      content: Text("Invalid email or password."),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("OK"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            height: 50,
                            color: primaryColor1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(color: Colors.grey),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => SignupPage()),
                                  );
                                },
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(
                                    color: primaryColor1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                " / ",
                                style: TextStyle(color: Colors.grey),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => AdminLoginPage()),
                                  );
                                },
                                child: Text(
                                  "Admin Login",
                                  style: TextStyle(
                                    color: primaryColor1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<Map<dynamic, dynamic>> validateUser(String email, String password) async {
    String sql = "SELECT * FROM Users WHERE email = '$email' AND password = '$password'";
    List<Map<dynamic, dynamic>> result = await db().readData(sql);
    return result.isNotEmpty ? result.first : {};
  }
}
