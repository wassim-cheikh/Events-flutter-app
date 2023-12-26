import 'package:flutter/material.dart';
import 'package:test7/utils/db.dart';

import '../utils/EAColors.dart';
import 'EASelectCityScreen.dart';
import 'EventDetails.dart';
import 'UserFavorites.dart';
import 'UserProfile.dart';
import 'login.dart';

class EventsFeed extends StatefulWidget {
  final String username;
  final String? city;
  final String? type;

  EventsFeed({
    required this.username,
    this.city,
    this.type,
  });

  @override
  _EventsFeedState createState() => _EventsFeedState();
}

class _EventsFeedState extends State<EventsFeed> {
  List<Map> events = [];

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    String sql = 'SELECT * FROM Events';

    // Check if city and type parameters are provided
    if (widget.city != null && widget.type != null) {
        sql += ' WHERE city = "${widget.city}" AND type = "${widget.type}"';
      }


    List<Map> result = await db().readData(sql);

    setState(() {
      events = result;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events Feed'),
        backgroundColor: primaryColor1,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: primaryColor2,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('All Events'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventsFeed(username: widget.username),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Filter Events'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EASelectCityScreen(username: widget.username),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfilePage(username: widget.username , profile: true),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Favorites'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserFavorites(username: widget.username),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: events.isEmpty
          ? Center(
        child: Text('No events available'),
      )
          : ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return _buildEventCard(events[index]);
        },
      ),
    );
  }

  Widget _buildEventCard(Map event) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            height: 150, // Set the height of the clickable box
            child: Stack(
              children: [
                Image.network(
                  event['image_url'],
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        _navigateToDetailsScreen(event);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              'Name: ${event['name']}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('City: ${event['city']}'),
                Text('Type: ${event['type']}'),
                Text('Date: ${event['date']}'),
              ],
            ),
          ),
          ButtonBar(
            children: [
              FutureBuilder<bool>(
                future: _isEventInFavorites(event['id']),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error checking favorites');
                  } else {
                    bool isEventInFavorites = snapshot.data ?? false;
                    return TextButton(
                      onPressed: () {
                        if (isEventInFavorites) {
                          _removeFromFavorites(event['id']);
                        } else {
                          _addToFavorites(event['id']);
                        }
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                          isEventInFavorites ? primaryColor1 : primaryColor2,
                        ),
                      ),
                      child: Text(
                        isEventInFavorites ? 'Remove from Favorites' : 'Add to Favorites',
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<bool> _isEventInFavorites(int eventId) async {
    String username = widget.username;
    String sql = 'SELECT * FROM Favorites WHERE username = "$username" AND event_id = $eventId';
    List<Map> result = await db().readData(sql);
    return result.isNotEmpty;
  }

  Future<void> _addToFavorites(int eventId) async {
    String username = widget.username;
    String insertSql = 'INSERT INTO Favorites (username, event_id) VALUES ("$username", $eventId)';
    int result = await db().insertData(insertSql);

    if (result > 0) {
      setState(() {});
      print('Event added to favorites successfully');
    } else {
      print('Failed to add event to favorites');
    }
  }

  Future<void> _removeFromFavorites(int eventId) async {
    String username = widget.username;
    String deleteSql = 'DELETE FROM Favorites WHERE username = "$username" AND event_id =$eventId';
    int result = await db().deleteData(deleteSql);

    if (result > 0) {
      setState(() {});
      print('Event removed from favorites successfully');
    } else {
      print('Failed to remove event from favorites');
    }
  }

  void _navigateToDetailsScreen(Map event) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsScreen(event: event, username: widget.username),
      ),
    );
  }
}
