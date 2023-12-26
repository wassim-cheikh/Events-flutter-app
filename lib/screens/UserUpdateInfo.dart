import 'package:flutter/material.dart';
import 'package:test7/utils/db.dart'; // Replace with the actual path to your database config file

class UserUpdateInfoPage extends StatefulWidget {
  final String username;

  const UserUpdateInfoPage({Key? key, required this.username}) : super(key: key);

  @override
  _UserUpdateInfoPageState createState() => _UserUpdateInfoPageState();
}

class _UserUpdateInfoPageState extends State<UserUpdateInfoPage> {
  final db database = db();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    String sql = 'SELECT * FROM Users WHERE username = "${widget.username}"';
    List<Map> result = await database.readData(sql);
    if (result.isNotEmpty) {
      setState(() {
        firstNameController.text = result.first['first_name'] ?? '';
        lastNameController.text = result.first['last_name'] ?? '';
        birthDateController.text = result.first['birth_date'] ?? '';
        sexController.text = result.first['sex'] ?? '';
        phoneNumberController.text = result.first['phone_number']?.toString() ?? '';
        bioController.text = result.first['bio'] ?? '';
      });
    }
  }

  void submitForm() async {
    // Perform validation if needed
    String fname=firstNameController.text;
    String lname=lastNameController.text;
    String bdate=birthDateController.text;
    String sex=sexController.text;
    int phone=int.tryParse(phoneNumberController.text) ?? 0;
    String bio=bioController.text;
    String username= widget.username;
    await database.updateData('''
      UPDATE Users SET
        first_name = "$fname" ,
        last_name = "$lname" ,
        birth_date = "$bdate",
        sex = "$sex",
        phone_number = "$phone",
        bio = "$bio"
      WHERE username = "$username"
    ''', );


    // Navigate back to the user profile page
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Information'),
      ),
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextFormField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextFormField(
              controller: birthDateController,
              decoration: InputDecoration(labelText: 'Birth Date'),
            ),
            TextFormField(
              controller: sexController,
              decoration: InputDecoration(labelText: 'Sex'),
            ),
            TextFormField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            TextFormField(
              controller: bioController,
              decoration: InputDecoration(labelText: 'Bio'),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: submitForm,
              child: Text('Submit'),
            ),
          ],
        ),
      ),)
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UserUpdateInfoPage(username: 'example_username'), // Replace with the actual username
  ));
}
