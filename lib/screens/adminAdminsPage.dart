import 'package:flutter/material.dart';
import 'package:test7/screens/AddAdmin.dart';
import '../utils/EAapp_widgets.dart';
import '../utils/db.dart';
import 'AddAdmin.dart';
import 'AdminUpdateAdminForm.dart';

class AdminAdminsPage extends StatefulWidget {
  @override
  _AdminAdminsPageState createState() => _AdminAdminsPageState();
}

class _AdminAdminsPageState extends State<AdminAdminsPage> {
  List<Map<dynamic, dynamic>> _admins = [];
  final Color primaryColor1 = Color(0xFFED3269);
  final Color primaryColor2 = Color(0xFFFD5F3E);

  @override
  void initState() {
    super.initState();
    _loadAdmins();
  }

  Future<void> _loadAdmins() async {
    // Fetch admins from the database using the readData method
    String sql = "SELECT * FROM Admins";
    List<Map<dynamic, dynamic>> admins = await db().readData(sql);

    setState(() {
      _admins = admins;
    });
  }

  Future<void> _deleteAdmin(int adminId) async {
    // Delete the admin from the database using the deleteData method
    String sql = "DELETE FROM Admins WHERE id = '$adminId'";
    await db().deleteData(sql);

    // Reload the admins after deletion
    _loadAdmins();
  }

  void _updateAdmin(int adminId) {
    // Open the update admin form
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminUpdateAdminForm(adminId: adminId),
      ),
    ).then((_) {
      // Reload the admins after updating
      _loadAdmins();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:getAppBar("Admins"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddAdminPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: primaryColor2,
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Text('Add Admin', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            SizedBox(height: 16.0),
            Text(
              'Admins List',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            if (_admins.isEmpty)
              Text(
                'No admins found.',
                style: TextStyle(fontSize: 16),
              )
            else
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Admin ID')),
                    DataColumn(label: Text('Password')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: _admins.map((admin) {
                    return DataRow(
                      cells: [
                        DataCell(Text(admin['id'].toString())),
                        DataCell(Text(admin['password'].toString())),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  // Call the delete admin method when the delete button is pressed
                                  _deleteAdmin(admin['id']);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  // Call the update admin method when the edit button is pressed
                                  _updateAdmin(admin['id']);
                                },
                              ),
                            ],
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
    home: AdminAdminsPage(),
  ),
);
