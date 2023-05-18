import 'package:latlong2/latlong.dart';

class MapMaker {
  const MapMaker({
    required this.image,
    required this.title,
    required this.address,
    required this.location,
  });
  final String image;
  final String title;
  final String address;
  final LatLng location;
}

final _locations = [
  LatLng(-12.0080041, -77.0778237),
  LatLng(-12.0430962, -77.0208307),
  LatLng(-12.0480045, -77.0205112),
  LatLng(-12.0654067, -77.0257675),
  LatLng(-12.0238438, -77.0822122),
  LatLng(-12.0211287, -77.0502137),
  LatLng(-12.0622444, -77.0708716),
];
const _path = 'assets/animated_markers_map/';

final mapMakers = [
  MapMaker(
      image: '${_path}domino.png',
      title: 'Domino Pizza',
      address: 'Abbey Road 2420',
      location: _locations[0]),
  MapMaker(
      image: '${_path}pizzaHut.png',
      title: 'Pizza Hut',
      address: 'Rodeo Drive 405',
      location: _locations[1]),
  MapMaker(
      image: '${_path}papaJhons.png',
      title: 'Papa Jhons',
      address: 'La Rambla 143',
      location: _locations[2]),
  MapMaker(
      image: '${_path}caesars.png',
      title: 'Little Caesars',
      address: 'Via Veneto, 097',
      location: _locations[3]),
  MapMaker(
      image: '${_path}sbarro.png',
      title: 'Sbarro',
      address: 'Ginza Rode 903',
      location: _locations[4]),
  MapMaker(
      image: '${_path}telePizza.png',
      title: 'TelePizza',
      address: 'Orchard Road 784',
      location: _locations[5]),
  MapMaker(
      image: '${_path}pizzaExpress.png',
      title: 'PizzaExpress',
      address: 'Champs-Élysées 823',
      location: _locations[6]),
];
