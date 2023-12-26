import 'package:flutter/material.dart';
import 'package:test7/screens/login.dart';
import 'UserUpdateInfo.dart';
import 'package:test7/utils/db.dart';

class UserProfilePage extends StatefulWidget {
  final String username;
  final bool profile;

  const UserProfilePage({Key? key, required this.username, required this.profile}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final db database = db();
  Map<dynamic, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    String sql = 'SELECT * FROM Users WHERE username = "${widget.username}"';
    List<Map> result = await database.readData(sql);
    setState(() {
      userData = result.isNotEmpty ? result.first : {};
    });
  }

  Future<void> _showConfimDialog () async {

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are You Sure You Want To Permanently Delete Your Account ?'),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Handle 'Add Comment' button press
                String username = widget.username;

                String sql =
                    'DELETE FROM Users WHERE "username" = "$username" ;';

                await db().deleteData(sql);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage()
                  ),
                );
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
  void updateField(String field, dynamic value) async {
    String username = widget.username;
    String sql = 'UPDATE Users SET $field = ? WHERE username = "$username" ';
    await database.updateData(sql);
    loadUserData(); // Refresh user data after updating
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(userData['image_url'] ?? ''),
              ),
              SizedBox(height: 16),
              Text(
                widget.username,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 16),
              buildUserInfoItem('First Name', userData['first_name']),
              buildUserInfoItem('Last Name', userData['last_name']),
              buildUserInfoItem('Birth Date', userData['birth_date']),
              buildUserInfoItem('Sex', userData['sex']),
              buildUserInfoItem('Phone Number', userData['phone_number']?.toString() ?? ''),
              buildUserInfoItem('Bio', userData['bio']),
              SizedBox(height: 24), // Added extra spacing

            Visibility(
              visible: widget.profile == true,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserUpdateInfoPage(username: widget.username)),
                  );
                },
                child: Text('Update Information'),
              ),
            ),
              Visibility(
                visible: widget.profile == true,
                child: ElevatedButton(
                  onPressed: () {
                    _showConfimDialog();

                  },
                  child: Text('Delete Account'),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget buildUserInfoItem(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: TextStyle(color: Colors.grey[700]),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}


void main() {
  runApp(MaterialApp(
    home: UserProfilePage(username: '',profile: false), // Replace with the actual username
  ));
}
