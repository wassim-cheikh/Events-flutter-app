// details.dart

import 'package:flutter/material.dart';
import 'package:test7/utils/db.dart';

class DetailsScreen extends StatelessWidget {
  final Map event;

  DetailsScreen({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${event['name']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Type: ${event['type']}'),
            Text('City: ${event['city']}'),
            Text('Address: ${event['adress']}'),
            Text('Date: ${event['date']}'),
            Text('Time: ${event['time']}'),
            Text('Theme: ${event['theme']}'),
            Text('Description: ${event['description']}'),
            Text('Price: ${event['price']}'),
            Text('Number of Tickets: ${event['ntickets']}'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CommentsScreen(eventId: event['id'])),
                );
              },
              child: Text('View Comments'),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentsScreen extends StatefulWidget {
  final int eventId;

  CommentsScreen({required this.eventId});

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController commentController = TextEditingController();
  List<Map> comments = [];

  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  Future<void> fetchComments() async {
    try {
      String sql = 'SELECT * FROM Comments WHERE event_id = ${widget.eventId}';
      List<Map> result = await db().readData(sql);
      setState(() {
        comments = result;
      });
    } catch (e) {
      print('Error fetching comments: $e');
    }
  }

  Future<void> addComment() async {
    String comment = commentController.text;
    if (comment.isNotEmpty) {
      String sql = 'INSERT INTO Comments (event_id, comment) VALUES (${widget.eventId}, "$comment")';
      await db().insertData(sql);
      // Clear the text field after adding the comment
      commentController.clear();
      // Refresh the comments list
      fetchComments();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(comments[index]['comment']),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: addComment,
                  child: Text('Add'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
