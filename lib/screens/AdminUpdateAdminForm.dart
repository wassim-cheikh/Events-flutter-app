import 'package:flutter/material.dart';

import '../utils/EAapp_widgets.dart';
import '../utils/db.dart';

class AdminUpdateAdminForm extends StatefulWidget {
  final int adminId;

  const AdminUpdateAdminForm({Key? key, required this.adminId}) : super(key: key);

  @override
  _AdminUpdateAdminFormState createState() => _AdminUpdateAdminFormState();
}

class _AdminUpdateAdminFormState extends State<AdminUpdateAdminForm> {
  final TextEditingController _passwordController = TextEditingController();
  final Color primaryColor1 = Color(0xFFED3269);
  final Color primaryColor2 = Color(0xFFFD5F3E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Edit Admin"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Admin ID: ${widget.adminId}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor1),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'New Password'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Update admin password in the database
                String newPassword = _passwordController.text;
                String sql = "UPDATE Admins SET password = '$newPassword' WHERE id = '${widget.adminId}'";
                await db().updateData(sql);

                // Navigate back to the admin admins page
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                primary: primaryColor2,
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              ),
              child: Text(
                'Update Admin',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
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
    home: AdminUpdateAdminForm(
      adminId: 0,
    ),
  ),
);
