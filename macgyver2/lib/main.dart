import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'map_marker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Map(),
    );
  }
}

const MAPBOX_ACCESS_TOKEN =
    // "pk.eyJ1IjoieWRnZ2dnIiwiYSI6ImNsMmc1Z2YzbjAwbjQzZW13b3dxbHQ1c24ifQ.RuRSZjLvfCYD6m_tExfEoQ";
    'pk.eyJ1IjoiZGllZ292ZWxvcGVyIiwiYSI6ImNrdGppMnh0bjFjZ3MzMm5sejRtcTlwbTQifQ.lwdbukS6p7bBWBuk2URBKg';
const MAPBOX_STYLE = 'mapbox/dark-v10';

const MARKER_COLOR = Color(0xFFf75e63);
const MARKER_SIZE_EXPANDED = 45.0;
const MARKER_SIZE_SHRINKED = 35.0;

final _myLocation = LatLng(37.49794587164024, 127.02761007446635);

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> with SingleTickerProviderStateMixin {
  final _pageController = PageController();
  late final AnimationController _animationController;
  int _selectedIndex = 0;

  List<Marker> _buildMarkers() {
    final _markerList = <Marker>[];
    for (int i = 0; i < mapMarkers.length; i++) {
      final mapItem = mapMarkers[i];

      _markerList.add(
        Marker(
          height: MARKER_SIZE_EXPANDED,
          width: MARKER_SIZE_EXPANDED,
          point: mapItem.location,
          builder: (_) {
            return GestureDetector(
              onTap: () {
                _selectedIndex = i;
                setState(
                  () {
                    _pageController.animateToPage(i,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.elasticOut);
                    print('Selected: ${mapItem.title}');
                  },
                );
              },
              child:
                  // [_LocationMarker1(
                  //   selected: _selectedIndex == i,
                  // ),
                  _LocationMarker1(
                      selected: _selectedIndex == i, mapMarker: mapItem),
              // ],
            );
          },
        ),
      );
    }
    return _markerList;
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _markers = _buildMarkers();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // title: Text('Macgyver'),
        actions: [
          IconButton(
            color: Colors.black,
            icon: Icon(Icons.person_pin_circle_rounded),
            onPressed: () => null,
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              minZoom: 5,
              maxZoom: 18,
              zoom: 13,
              center: _myLocation,
            ),
            nonRotatedLayers: [
              TileLayerOptions(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/ydgggg/cl2j2qkk8002t14mjde1a3ngm/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoieWRnZ2dnIiwiYSI6ImNsMmc1Z2YzbjAwbjQzZW13b3dxbHQ1c24ifQ.RuRSZjLvfCYD6m_tExfEoQ',
                // 'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                additionalOptions: {
                  'accessToken': MAPBOX_ACCESS_TOKEN,
                  'id': MAPBOX_STYLE,
                },
              ),
              MarkerLayerOptions(
                markers: _markers,
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                      height: 60,
                      width: 60,
                      point: _myLocation,
                      builder: (_) {
                        return _MyLocationMarker(_animationController);
                      }),
                ],
              ),
            ],
          ),
          // Add a pageview
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            height: MediaQuery.of(context).size.height * 0.3,
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: mapMarkers.length,
              itemBuilder: (context, index) {
                final item = mapMarkers[index];
                return _MapItemDetails(
                  mapMarker: item,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// class _LocationMarker extends StatefulWidget {
//   const _LocationMarker({Key? key, this.selected = false}) : super(key: key);

//   final bool selected;

//   @override
//   State<_LocationMarker> createState() => _LocationMarkerState();
// }

// class _LocationMarkerState extends State<_LocationMarker> {
//   @override
//   Widget build(BuildContext context) {
//     final size = widget.selected ? MARKER_SIZE_EXPANDED : MARKER_SIZE_SHRINKED;

//     return Center(
//       child: AnimatedContainer(
//         height: size,
//         width: size,
//         duration: const Duration(milliseconds: 400),
//         // child: Image.asset(mapMarker.logo),
//         child: Image.asset('lib/assets/marker.png'),
//       ),
//     );
//   }
// }

class _LocationMarker1 extends StatelessWidget {
  const _LocationMarker1({
    Key? key,
    required this.mapMarker,
    required bool selected,
  }) : super(key: key);

  final MapMarker mapMarker;
  @override
  Widget build(BuildContext context) {
// class _LocationMarker1 extends StatefulWidget {
//   const _LocationMarker1({Key? key, this.selected = false}) : super(key: key);

//   final bool selected;

//   @override
//   State<_LocationMarker1> createState() => _LocationMarker1State();
// }

// class _LocationMarker1State extends State<_LocationMarker1> {
    // @override
    // Widget build(BuildContext context) {
    //   final size = widget.selected ? MARKER_SIZE_EXPANDED : MARKER_SIZE_SHRINKED;

    //   var mapMarker;
    return Center(
      child: AnimatedContainer(
        height: 35,
        width: 35,
        duration: const Duration(milliseconds: 400),
        child: Image.asset(mapMarker.marker),
        // child: Image.asset('lib/assets/marker.png'),
      ),
    );
  }
}

class _MyLocationMarker extends AnimatedWidget {
  const _MyLocationMarker(Animation<double> animation, {Key? key})
      : super(
          key: key,
          listenable: animation,
        );

  @override
  Widget build(BuildContext context) {
    final value = (listenable as Animation<double>).value;
    final newValue = lerpDouble(0.5, 1.0, value)!;
    final size = 50.0;
    return Center(
      child: Stack(
        children: [
          Center(
            child: Container(
              height: size * newValue,
              width: size * newValue,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MARKER_COLOR.withOpacity(0.5),
              ),
            ),
          ),
          Center(
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: MARKER_COLOR,
                shape: BoxShape.circle,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _MapItemDetails extends StatelessWidget {
  const _MapItemDetails({
    Key? key,
    required this.mapMarker,
  }) : super(key: key);

  final MapMarker mapMarker;

  @override
  Widget build(BuildContext context) {
    final _styleTitle = TextStyle(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);
    final _styleAddress = TextStyle(color: Colors.grey[800], fontSize: 14);
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
                  Container(
                    width: 160,
                    height: 200,
                    child: Image.asset(
                      mapMarker.image,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          mapMarker.title,
                          style: _styleTitle,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          mapMarker.address,
                          style: _styleAddress,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () => null,
              color: Colors.amber,
              // color: MARKER_COLOR,
              elevation: 6,
              child: Text(
                'More',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
