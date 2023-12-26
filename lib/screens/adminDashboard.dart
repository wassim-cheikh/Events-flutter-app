import 'package:flutter/material.dart';
import 'package:test7/screens/adminUsersPage.dart';
import 'package:test7/screens/adminAdminsPage.dart';
import '../utils/EAapp_widgets.dart';
import 'AdminReports.dart';
import 'form.dart';
import 'package:test7/screens/adminModifyEventsPage.dart';

class AdminDashboard extends StatelessWidget {
  final Color primaryColor1 = Color(0xFFED3269);
  final Color primaryColor2 = Color(0xFFFD5F3E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Admin Dashboard"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome Admin ! ',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminUsersPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: primaryColor1,
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                textStyle: TextStyle(
                  fontSize: 20.0,
                  color: primaryColor1,
                ),
              ),
              child: Text('Users'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminAdminsPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: primaryColor2,
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                textStyle: TextStyle(
                  fontSize: 20.0,
                  color: primaryColor2,
                ),
              ),
              child: Text('Admins'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminModifyEventsPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: primaryColor1,
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                textStyle: TextStyle(
                  fontSize: 20.0,
                  color: primaryColor1,
                ),
              ),
              child: Text('Events'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminReports()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: primaryColor1,
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                textStyle: TextStyle(
                  fontSize: 20.0,
                  color: primaryColor1,
                ),
              ),
              child: Text('Reports'),
            ),

          ],
        ),
      ),
    );
  }
}

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Color(0xFFED3269),
        secondary: Color(0xFFFD5F3E),
      ),
    ),
    home: AdminDashboard(),
  ),
);
