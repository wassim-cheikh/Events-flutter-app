import 'package:flutter/material.dart';
import '../utils/db.dart';
import 'login.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SignupPage(),
  ),
);

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final Color primaryColor1 = Color(0xFFED3269);
  final Color primaryColor2 = Color(0xFFFD5F3E);
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  String passwordError = '';
  String usernameError = '';
  String emailError = '';

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
                    "Sign Up",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Create an Account",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
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
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200),
                                  ),
                                ),
                                child: TextField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                    errorText: emailError.isNotEmpty
                                        ? emailError
                                        : null,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200),
                                  ),
                                ),
                                child: TextField(
                                  controller: usernameController,
                                  decoration: InputDecoration(
                                    hintText: "Username",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                    errorText: usernameError.isNotEmpty
                                        ? usernameError
                                        : null,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200),
                                  ),
                                ),
                                child: TextField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                    errorText: passwordError.isNotEmpty
                                        ? passwordError
                                        : null,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: confirmPasswordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: "Confirm Password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                    errorText: passwordController.text !=
                                        confirmPasswordController.text
                                        ? "Passwords do not match"
                                        : null,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: firstNameController,
                                  decoration: InputDecoration(
                                    hintText: "First Name",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: lastNameController,
                                  decoration: InputDecoration(
                                    hintText: "Last Name",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: birthDateController,
                                  decoration: InputDecoration(
                                    hintText: "Birth Date",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: sexController,
                                  decoration: InputDecoration(
                                    hintText: "Sex",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: phoneNumberController,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    hintText: "Phone Number",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: bioController,
                                  decoration: InputDecoration(
                                    hintText: "Bio",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: imageUrlController,
                                  decoration: InputDecoration(
                                    hintText: "Image URL",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                        MaterialButton(
                          onPressed: () async {
                            // Validate the form
                            if (_validateForm()) {
                              // Extract values from text fields
                              String username = usernameController.text;
                              String email = emailController.text;
                              String fullName = fullNameController.text;
                              String password = passwordController.text;
                              String firstName = firstNameController.text;
                              String lastName = lastNameController.text;
                              String birthDate = birthDateController.text;
                              String sex = sexController.text;
                              String phoneNumber =
                                  phoneNumberController.text;
                              String bio = bioController.text;
                              String imageUrl = imageUrlController.text;

                              // Construct the SQL query for inserting a new user
                              String sql = '''
                                INSERT INTO "Users" (
                                  "username", 
                                  "email", 
                                  "password",
                                  "first_name",
                                  "last_name",
                                  "birth_date",
                                  "sex",
                                  "phone_number",
                                  "bio",
                                  "image_url"
                                ) VALUES (
                                  "$username", 
                                  "$email", 
                                  "$password",
                                  "$firstName",
                                  "$lastName",
                                  "$birthDate",
                                  "$sex",
                                  "$phoneNumber",
                                  "$bio",
                                  "$imageUrl"
                                )
                              ''';

                              // Insert the user into the database
                              int response = await db().insertData(sql);

                              if (response > 0) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                );
                              } else {
                                // Handle the case where the user was not added successfully
                                // You can show an error message or take appropriate action
                              }
                            }
                          },
                          height: 50,
                          color: primaryColor1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Move the login button outside the SingleChildScrollView
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Already have an account? ",
                ),
                InkWell(
                  onTap: () {
                    // Navigate to the login screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text(
                    "Login",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool _validateForm() {
    // Validate the form
    if (usernameController.text.isEmpty) {
      setState(() {
        usernameError = "Username cannot be empty";
      });
      return false;
    } else {
      setState(() {
        usernameError = '';
      });
    }

    if (emailController.text.isEmpty) {
      setState(() {
        emailError = "Email cannot be empty";
      });
      return false;
    } else {
      setState(() {
        emailError = '';
      });
    }

    if (passwordController.text.isEmpty) {
      setState(() {
        passwordError = "Password cannot be empty";
      });
      return false;
    } else {
      setState(() {
        passwordError = '';
      });
    }

    if (confirmPasswordController.text.isEmpty) {
      setState(() {
        passwordError = "Confirm Password cannot be empty";
      });
      return false;
    } else {
      setState(() {
        passwordError = '';
      });
    }

    if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        passwordError = "Passwords do not match";
      });
      return false;
    } else {
      setState(() {
        passwordError = '';
      });
    }

    return true;
  }

  Future<bool> checkUsernameAvailability(String username) async {
    // Implement logic to check if the username already exists in the database
    // Return true if it exists, false otherwise
    // You can use your existing database functions for this
    // For example:
    String sql = 'SELECT * FROM "Users" WHERE "username" = "$username"';
    List<Map> result = await db().readData(sql);
    return result.isNotEmpty;
  }

  Future<bool> checkEmailAvailability(String email) async {
    // Implement logic to check if the email already exists in the database
    // Return true if it exists, false otherwise
    // You can use your existing database functions for this
    // For example:
    String sql = 'SELECT * FROM "Users" WHERE "email" = "$email"';
    List<Map> result = await db().readData(sql);
    return result.isNotEmpty;
  }
}
