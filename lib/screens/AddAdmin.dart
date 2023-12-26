import 'package:flutter/material.dart';
import '../utils/EAapp_widgets.dart';
import '../utils/db.dart';

class AddAdminPage extends StatefulWidget {
  @override
  _AddAdminPageState createState() => _AddAdminPageState();
}

class _AddAdminPageState extends State<AddAdminPage> {
  final TextEditingController _adminIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _verificationMessage = '';
  bool _isError = false;
  final Color primaryColor1 = Color(0xFFED3269);
  final Color primaryColor2 = Color(0xFFFD5F3E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Add Admin"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _adminIdController,
              decoration: InputDecoration(labelText: 'Admin ID'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String adminId = _adminIdController.text;
                String password = _passwordController.text;

                // Check if the admin ID already exists
                bool adminExists = await _checkAdminExists(adminId);

                if (adminExists) {
                  setState(() {
                    _verificationMessage = 'Admin ID already exists. Please choose a different one.';
                    _isError = true;
                  });
                } else {
                  // Insert the new admin into the database
                  String sql = "INSERT INTO Admins (id, password) VALUES ('$adminId', '$password')";
                  await db().insertData(sql);

                  setState(() {
                    _verificationMessage = 'Admin added successfully!';
                    _isError = false;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                primary: primaryColor2,
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              ),
              child: Text('Submit', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            SizedBox(height: 16.0),
            Text(
              _verificationMessage,
              style: TextStyle(
                color: _isError ? Colors.red : primaryColor2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _checkAdminExists(String adminId) async {
    String sql = "SELECT * FROM Admins WHERE id = '$adminId'";
    List<Map> result = await db().readData(sql);
    return result.isNotEmpty;
  }
}

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AddAdminPage(),
  ),
);
