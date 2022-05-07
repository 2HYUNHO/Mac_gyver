import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:latlong2/latlong.dart';
import 'package:macgyver1/mypage.dart';
// import 'package:mapbox_search/mapbox_search.dart';
// import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';
import 'map_marker.dart';
import 'package:geolocator/geolocator.dart';

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

// var placesSearch = PlacesSearch(
//   apiKey:
//       'pk.eyJ1IjoiZGllZ292ZWxvcGVyIiwiYSI6ImNrdGppMnh0bjFjZ3MzMm5sejRtcTlwbTQifQ.lwdbukS6p7bBWBuk2URBKg',
//   limit: 5,
// );

// Future<List<MapBoxPlace>?> getPlaces() => placesSearch.getPlaces("New York");

const MAPBOX_ACCESS_TOKEN =
    // "pk.eyJ1IjoieWRnZ2dnIiwiYSI6ImNsMmc1Z2YzbjAwbjQzZW13b3dxbHQ1c24ifQ.RuRSZjLvfCYD6m_tExfEoQ";
    'pk.eyJ1IjoiZGllZ292ZWxvcGVyIiwiYSI6ImNrdGppMnh0bjFjZ3MzMm5sejRtcTlwbTQifQ.lwdbukS6p7bBWBuk2URBKg';
const MAPBOX_STYLE = 'mapbox/dark-v10';

const MARKER_COLOR = Color(0xFFf75e63);
const MARKER_SIZE_EXPANDED = 45.0;
const MARKER_SIZE_SHRINKED = 35.0;

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> with SingleTickerProviderStateMixin {
  final _pageController = PageController();
  late final AnimationController _animationController;
  int _selectedIndex = 0;
  LatLng _myLocation = LatLng(37.49794587164024, 127.02761007446635);
  MapController mapController = MapController();

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
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      Position position = await _determinePosition();
      _myLocation = LatLng(
        position.latitude,
        position.longitude,
      );
      setState(() {});
      print(position.latitude);
      print(position.longitude);
      mapController.move(_myLocation, 13);
    });
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
            icon: Icon(CupertinoIcons.person),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyPage()));
            },
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   label: Text('Search'),
      //   icon: Icon(Icons.search),
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => SearchPage(),
      //       ),
      //     );
      //   },
      // ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
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
          // Container(
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
          )
        ],
      ),
    );
  }
}

// nullsafe 애러 - > 수정

// class SearchPage extends StatelessWidget {
//   const SearchPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.arrow_back_ios),
//         onPressed: () {
//           Navigator.pop(context);
//         },
//       ),
//       body: SafeArea(
//         bottom: false,
//         child: MapBoxPlaceSearchWidget(
//           popOnSelect: true,
//           apiKey:
//               'pk.eyJ1IjoiZGllZ292ZWxvcGVyIiwiYSI6ImNrdGppMnh0bjFjZ3MzMm5sejRtcTlwbTQifQ.lwdbukS6p7bBWBuk2URBKg',
//           searchHint: 'Search around',
//           onSelected: (place) {},
//           context: context,
//         ),
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
      color: Colors.black,
      fontSize: 15,
    );

    // fontWeight: FontWeight.bold);
    // final Distance distance = Distance();
    // final int m = distance.as(LengthUnit.Meter, LatLng(37.5658091, 126.9729574),
    //     LatLng(37.4734153, 126.8301878)) as int;
    final _styleTime = TextStyle(color: Colors.red[600], fontSize: 12);
    final _styleAddress = TextStyle(color: Colors.grey[600], fontSize: 10);
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.zero,
            color: Colors.white,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 180.0),
                          child: Text(
                            '근처 업체 알아보기',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 13,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 10,
                            ),

                            GestureDetector(
                              onTap: () {
                                print('사진클릭');
                              },
                              child: SizedBox(
                                width: 130,
                                height: 145,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    mapMarker.image,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            // Container(
                            //   width: 5,
                            // ),
                            Container(
                              width: 190,
                              height: 140,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    // padding: const EdgeInsets.all(1.0),
                                    padding: EdgeInsets.only(right: 5),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 10,
                                        ),
                                        Text(
                                          mapMarker.title,
                                          style: _styleTitle,
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 145),
                                    child: Text(
                                      '10m',
                                      // distance,
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 10,
                                      ),
                                      Text(
                                        mapMarker.address,
                                        style: _styleAddress,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 55),
                                    child: Text(
                                      mapMarker.time,
                                      style: _styleTime,
                                    ),
                                  ),

                                  // Container(
                                  //   height: 30,
                                  // ),
                                  Container(
                                    // padding:
                                    // const EdgeInsets.only(
                                    //     top: 30, right: 50.0),
                                    alignment: Alignment(1.0, 1.0),
                                    child: RatingBar.builder(
                                      itemSize: 20,
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 2),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                  ),
                                  // )
                                ],
                              ),
                            ),
                            // MaterialButton(
                            //   padding: EdgeInsets.zero,
                            //   onPressed: () => null,
                            //   color: Colors.amber,
                            //   // color: MARKER_COLOR,
                            //   elevation: 6,
                            //   child: Text(
                            //     'More',
                            //     style: TextStyle(fontWeight: FontWeight.bold),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ])));
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    return Future.error('Location services are disabled');
  }

  permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      return Future.error("Location permission denied");
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied');
  }

  Position position = await Geolocator.getCurrentPosition();

  return position;
}
