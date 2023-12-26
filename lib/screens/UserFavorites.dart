import 'package:flutter/material.dart';
import 'package:test7/utils/db.dart'; // Import your database configuration file

class Event {
  final int id;
  final String name;
  final String type;
  final String city;
  final String address;
  final String date;
  final String time;
  final String theme;
  final String description;
  final double price;
  final int nTickets;
  final String imageUrl;

  Event({
    required this.id,
    required this.name,
    required this.type,
    required this.city,
    required this.address,
    required this.date,
    required this.time,
    required this.theme,
    required this.description,
    required this.price,
    required this.nTickets,
    required this.imageUrl,
  });
}

class UserFavorites extends StatefulWidget {
  final String username;

  UserFavorites({required this.username});

  @override
  _UserFavoritesState createState() => _UserFavoritesState();
}

class _UserFavoritesState extends State<UserFavorites> {
  List<Event> favoriteEvents = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteEvents();
  }

  Future<void> _loadFavoriteEvents() async {
    String username = widget.username;
    String sql = '''
    SELECT Events.* 
    FROM Events
    INNER JOIN Favorites ON Events.id = Favorites.event_id
    WHERE Favorites.username = "$username"
  ''';

    List<Map> result = await db().readData(sql);

    setState(() {
      favoriteEvents = result.map((eventMap) {
        return Event(
          id: eventMap['id'] ?? 0,
          name: eventMap['name'] ?? 'No Name',
          type: eventMap['type'] ?? 'No Type',
          city: eventMap['city'] ?? 'No City',
          address: eventMap['address'] ?? 'No Address',
          date: eventMap['date'] ?? 'No Date',
          time: eventMap['time'] ?? 'No Time',
          theme: eventMap['theme'] ?? 'No Theme',
          description: eventMap['description'] ?? 'No Description',
          price: eventMap['price']?.toDouble() ?? 0.0,
          nTickets: eventMap['ntickets'] ?? 0,
          imageUrl: eventMap['image_url'] ?? 'No Image',
        );
      }).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Events'),
      ),
      body: favoriteEvents.isEmpty
          ? Center(
        child: Text('No favorite events available'),
      )
          : ListView.builder(
        itemCount: favoriteEvents.length,
        itemBuilder: (context, index) {
          return _buildEventCard(favoriteEvents[index]);
        },
      ),
    );
  }

  Widget _buildEventCard(Event event) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Image.network(
            event.imageUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text('Name: ${event.name}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('City: ${event.city}'),
                Text('Type: ${event.type}'),
                Text('Date: ${event.date}'),
              ],
            ),
          ),
          // You can add more details or actions as needed
        ],
      ),
    );
  }
}
