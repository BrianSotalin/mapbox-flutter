import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mapbox_test/screens/map_maker.dart';

const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1Ijoicml2aWFuMC0xMCIsImEiOiJjbGdxdmVjeHAxYmc1M2lwbTN0eHF0Ym83In0.wuI5gcg0PRXSvPDP7B3OGQ';

final myPosition = LatLng(-12.0362176, -77.0296812);
//-0.2702, -79.2262

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _pageController = PageController();

  List<Marker> _buildMarkers() {
    final _markerList = <Marker>[];
    for (int i = 0; i < mapMakers.length; i++) {
      final mapItem = mapMakers[i];
      _markerList.add(
        Marker(
          height: 50,
          width: 50,
          point: mapItem.location,
          builder: (_) {
            return GestureDetector(
              onTap: () {
                _pageController.jumpToPage(i);
                print('Selected: ${mapItem.title} - $i ${mapItem.address}');
              },
              child: const Icon(
                Icons.place_sharp,
                color: Colors.blueAccent,
                size: 40,
              ),
            );
          },
        ),
      );
    }

    return _markerList;
  }

  @override
  Widget build(BuildContext context) {
    final _markers = _buildMarkers();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(''),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: myPosition,
              minZoom: 5,
              maxZoom: 25,
              zoom: 18,
            ),
            nonRotatedChildren: [
              TileLayer(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                additionalOptions: const {
                  'accessToken': MAPBOX_ACCESS_TOKEN,
                  'id': 'mapbox/streets-v12'
                },
              ),
              MarkerLayer(
                markers: _markers,
              ),
              MarkerLayer(
                markers: [
                  Marker(
                      point: myPosition,
                      builder: (context) {
                        return const _MyLocationMarker();
                      }),
                ],
              ),
            ],
          ),
          //add a page view
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            height: MediaQuery.of(context).size.height * 0.3,
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: mapMakers.length,
              itemBuilder: (context, index) {
                final item = mapMakers[index];
                return _MapItemDetails(
                  mapMaker: item,
                );
              },
              //keepPage: true,
            ),
          ),
        ],
      ),
    );
  }
}

class _MyLocationMarker extends StatelessWidget {
  const _MyLocationMarker({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: const BoxDecoration(
        color: Colors.blueAccent,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _MapItemDetails extends StatelessWidget {
  const _MapItemDetails({
    Key? key,
    required this.mapMaker,
  }) : super(key: key);

  final MapMaker mapMaker;

  @override
  Widget build(BuildContext context) {
    final _styleTitle = TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w800);
    final _styleAddress = TextStyle(color: Colors.grey.shade800, fontSize: 14);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(child: Image.asset(mapMaker.image)),
                  Expanded(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        mapMaker.title,
                        style: _styleTitle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        mapMaker.address,
                        style: _styleAddress,
                      ),
                    ],
                  )),
                ],
              ),
            ),
            const MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: _handleButtonPress,
              color: Colors.greenAccent,
              elevation: 6,
              child: Text(
                'Call',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _handleButtonPress() {
  // Do something here when the button is pressed
  print('Button pressed!');
}
