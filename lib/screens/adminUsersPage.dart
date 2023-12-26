import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Add this line for caching images
import '../utils/EAapp_widgets.dart';
import '../utils/db.dart';

class AdminUsersPage extends StatefulWidget {
  @override
  _AdminUsersPageState createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage> {
  List<Map<dynamic, dynamic>> _users = [];
  final Color primaryColor1 = Color(0xFFED3269);
  final Color primaryColor2 = Color(0xFFFD5F3E);

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    // Fetch users from the database using the readData method
    String sql = "SELECT * FROM Users";
    List<Map<dynamic, dynamic>> users = await db().readData(sql);

    setState(() {
      _users = users;
    });
  }

  Future<void> _deleteUser(String username) async {
    // Delete the user from the database using the deleteData method
    String sql = "DELETE FROM Users WHERE username = '$username'";
    await db().deleteData(sql);

    // Reload the users after deletion
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:getAppBar("Users"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Users List',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor1),
            ),
            SizedBox(height: 16.0),
            if (_users.isEmpty)
              Text(
                'No users found.',
                style: TextStyle(fontSize: 16, color: primaryColor1),
              )
            else
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Image')),
                    DataColumn(label: Text('Username')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Password')),
                    DataColumn(label: Text('First Name')),
                    DataColumn(label: Text('Last Name')),
                    DataColumn(label: Text('Birth Date')),
                    DataColumn(label: Text('Sex')),
                    DataColumn(label: Text('Phone Number')),
                    DataColumn(label: Text('Bio')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: _users.map((user) {
                    return DataRow(
                      cells: [
                        DataCell(
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: CachedNetworkImageProvider(user['image_url'].toString()),
                          ),
                        ),
                        DataCell(Text(user['username'].toString(), style: TextStyle(color: primaryColor1))),
                        DataCell(Text(user['email'].toString(), style: TextStyle(color: primaryColor1))),
                        DataCell(Text(user['password'].toString(), style: TextStyle(color: primaryColor1))),
                        DataCell(Text(user['first_name'].toString(), style: TextStyle(color: primaryColor1))),
                        DataCell(Text(user['last_name'].toString(), style: TextStyle(color: primaryColor1))),
                        DataCell(Text(user['birth_date'].toString(), style: TextStyle(color: primaryColor1))),
                        DataCell(Text(user['sex'].toString(), style: TextStyle(color: primaryColor1))),
                        DataCell(Text(user['phone_number'].toString(), style: TextStyle(color: primaryColor1))),
                        DataCell(Text(user['bio'].toString(), style: TextStyle(color: primaryColor1))),

                        DataCell(
                          IconButton(
                            icon: Icon(Icons.delete, color: primaryColor2),
                            onPressed: () {
                              // Call the delete user method when the delete button is pressed
                              _deleteUser(user['username']);
                            },
                          ),
                        ),
                      ],
                    );
                  }).toList(),
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
    home: AdminUsersPage(),
  ),
);
