
import 'package:test7/model/EAWalkThroughModel.dart';
import 'EAImages.dart';

List<EAWalkThrough> walkThroughList = [
  EAWalkThrough(image: event_ic_walk_through2, title: "EVENTS COLLECTION", subtitle: "Discover the best things to do this week in this city"),
  EAWalkThrough(image: event_ic_walk_through3, title: "CONNECT & FOLLOW", subtitle: "Connect with your friends, follow tastemakers and people who share your interest."),
  EAWalkThrough(image: event_ic_walk_through1, title: "BOOK & SHARE", subtitle: "Book events so easy in this two steps ans share it with your friends."),
];

List<EACityModel> cityList = [
  EACityModel(name: "Tunis", subtitle: "TUN", image: event_ic_tunis),
  EACityModel(name: "Hammamet", subtitle: "TUN", image: event_ic_hammamet),
  EACityModel(name: "Kelibia", subtitle: "TUN", image: event_ic_kelibia),
  EACityModel(name: "Djerba", subtitle: "TUN", image: event_ic_djerba),
  EACityModel(name: "Sousse", subtitle: "TUN", image: event_ic_sousse),
  EACityModel(name: "Tabarka", subtitle: "TUN", image: event_ic_tabarka),
];

List<EACityModel> hashtagList = [
  EACityModel(name: "Music", subtitle: "2k+ events", image: event_ic_music, selectHash: false),
  EACityModel(name: "Festival Madina", subtitle: "10+ events", image: event_ic_festival, selectHash: false),
  EACityModel(name: "Gaming", subtitle: "20+ events", image: event_ic_gaming, selectHash: false),
  EACityModel(name: "Cinema", subtitle: "1.5k+ events", image: event_ic_cinema, selectHash: false),
  EACityModel(name: "Art", subtitle: "30+ events", image: event_ic_art, selectHash: false),
  EACityModel(name: "Theatre", subtitle: "100+ events", image: event_ic_theatre, selectHash: false),
];


List<EACityModel> filterHashtagList = [
  EACityModel(name: "All Hashtags", isSelected: false),
  EACityModel(name: "music", isSelected: false),
  EACityModel(name: "festival", isSelected: false),
  EACityModel(name: "food", isSelected: false),
  EACityModel(name: "cinema", isSelected: false),
  EACityModel(name: "music", isSelected: false),
  EACityModel(name: "festival", isSelected: false),
];
