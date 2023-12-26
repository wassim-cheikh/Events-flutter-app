
import 'package:flutter/material.dart';
import 'package:test7/utils/db.dart';

import 'UserProfile.dart';

class DetailsScreen extends StatefulWidget {
  final Map event;
  final String username;

  DetailsScreen({required this.event, required this.username});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<Map> comments = [];

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  Future<void> _loadComments() async {
    String sql = 'SELECT * FROM Comments WHERE event_id = ${widget.event['id']}';
    List<Map> result = await db().readData(sql);

    setState(() {
      comments = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: ListView(
        children: [
          Image.network(
            widget.event['image_url'],
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text('Name: ${widget.event['name']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('City: ${widget.event['city']}'),
                Text('Type: ${widget.event['type']}'),
                Text('Date: ${widget.event['date']}'),
                Text('Address: ${widget.event['adress']}'),
                Text('Theme: ${widget.event['theme']}'),
                Text('Description: ${widget.event['description']}'),
                Text('Number of tickets: ${widget.event['ntickets']}'),
                Text('Ticket Price: ${widget.event['price']}'),
                // Add more fields as needed
              ],
            ),
          ),
          SizedBox(height: 45),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () {
                    // Handle 'Buy Tickets' button press
                  },
                  child: Text('Buy Tickets'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle 'Report' button press
                    _showAddReportDialog();
                  },
                  child: Text('Report'),
                ),
                SizedBox(width: 10.0),              ],
            ),
          ),
          SizedBox(height: 25),
          Text(
            'Comments',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 35),
          comments.isEmpty
              ? Center(
            child: Text('No comments yet'),
          )
              :ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: comments.length,
            itemBuilder: (context, index) {
              return FutureBuilder<String?>(
                future: getUserImageUrl(comments[index]['username']),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // You can return a loading indicator or placeholder if needed
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    // Handle error
                    return Text('Error loading profile picture');
                  } else {
                    String? profilePictureUrl = snapshot.data;
                    return Card(
                      elevation: 3,
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(profilePictureUrl ?? ''),
                        ),
                        title: GestureDetector(
                          onTap: () {
                            // Handle username tap
                            _navigateToUserProfile(comments[index]['username']);
                          },
                          child: Text(
                            comments[index]['username'],
                            style: TextStyle(
                              color: Colors.pink, // You can change the color as needed

                            ),
                          ),
                        ),
                        subtitle: Text(comments[index]['comment']),
                      ),
                    );
                  }
                },
              );
            },
          ),


          SizedBox(height: 45),
          ElevatedButton(
            onPressed: () {
              // Handle 'Add Comment' button press
              _showAddCommentDialog();
            },
            child: Text('Add Comment'),
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }
  Future<void> _showAddReportDialog () async {
    TextEditingController Controller = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Report'),
          content: TextField(
              controller: Controller,
              decoration: InputDecoration(hintText: "What's Wrong ?")
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Handle 'Add Comment' button press
                String username = widget.username;
                String report =Controller.text;
                int eventId = widget.event['id'];

                String sql =
                    'INSERT INTO Reports (event_id, username, report) VALUES ($eventId, "$username", "$report")';

                await db().insertData(sql);
                _loadComments();
                Navigator.pop(context);
              },
              child: Text('Send Report'),
            ),
          ],
        );
      },
    );
  }
  Future<String?> getUserImageUrl(String username) async {
    try {
      String sql = 'SELECT image_url FROM Users WHERE username = "$username"';
      List<Map> result = await db().readData(sql);

      if (result.isNotEmpty) {
        // Assuming 'image_url' is the field name in the Users table
        return result[0]['image_url'] as String?;
      } else {
        return null;
      }
    } catch (e) {
      // Handle exceptions, e.g., print an error message
      print('Error fetching user image URL: $e');
      return null;
    }
  }  Future<void> _showAddCommentDialog() async {
    TextEditingController commentController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Comment'),
          content: TextField(
            controller: commentController,
            decoration: InputDecoration(hintText: 'Enter your comment'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Handle 'Add Comment' button press
                String username = widget.username;
                String comment = commentController.text;
                int eventId = widget.event['id'];

                String sql =
                    'INSERT INTO Comments (event_id, username, comment) VALUES ($eventId, "$username", "$comment")';

                await db().insertData(sql);
                _loadComments();
                Navigator.pop(context);
              },
              child: Text('Add Comment'),
            ),
          ],
        );
      },
    );
  }
  void _navigateToUserProfile(String username) {
    bool profile =false;
    if (username==widget.username){
      profile = true;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfilePage(username: username,profile :profile),
      ),
    );
  }

}

