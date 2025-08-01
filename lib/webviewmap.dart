import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class Webviewmap extends StatefulWidget {
  const Webviewmap({Key? key}) : super(key: key);

  @override
  _WebviewmapState createState() => _WebviewmapState();
}

class _WebviewmapState extends State<Webviewmap> {
  TextEditingController searchController = TextEditingController();

  // Coordinates for Highland Hospital, Mangalore (Latitude: 12.8703, Longitude: 74.8447)
  LatLng _hospitalPosition =
      LatLng(12.8703, 74.8447); // Highland Hospital location
  LatLng _currentPosition = LatLng(12.8703,
      74.8447); // Default position, updates to the user's current location

  Set<Marker> _markers = {};
  bool _searchBarVisible = false;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
    _addHospitalMarker();
  }

  // Request permission to access the user's location
  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      _updateUserLocation();
    } else {
      print("Location permission not granted.");
    }
  }

  // Update the user's location on the map
  Future<void> _updateUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _markers.add(
          Marker(
            point: _currentPosition,
            width: 30.0, // Width of the marker icon
            height: 30.0, // Height of the marker icon
            child: Icon(
              Icons.pin_drop,
              color: Colors.blue, // Color of the user's location marker
              size: 30.0, // Size of the icon
            ),
          ),
        );
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  // Add a marker for Highland Hospital
  void _addHospitalMarker() {
    setState(() {
      _markers.add(
        Marker(
          point: _hospitalPosition,
          width: 30.0, // Optional, you can adjust the size
          height: 30.0, // Optional, you can adjust the size
          child: Icon(
            Icons.pin_drop,
            color: Colors.red, // Highland Hospital marker color
            size: 30.0, // Optional, you can adjust the size of the icon
          ),
        ),
      );
    });
  }

  // Search for a place by name (e.g., "Highland Hospital")
  Future<void> _searchPlace(String place) async {
    print("Searching for: $place");

    // Example of searching for Highland Hospital and zooming into its position
    if (place.toLowerCase() == "highland hospital") {
      setState(() {
        _markers.add(
          Marker(
            point: _hospitalPosition,
            width: 30.0, // Optional, you can adjust the size
            height: 30.0, // Optional, you can adjust the size
            child: Icon(
              Icons.pin_drop,
              color: Colors.red, // Highland Hospital marker color
              size: 30.0, // Optional, you can adjust the size of the icon
            ),
          ),
        );
      });
    } else {
      print("No search results for: $place");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // OpenStreetMap using flutter_map
          FlutterMap(
            options: MapOptions(
                // center: _currentPosition, // Set the map's center position
                //zoom: 14.0, // Set the zoom level
                ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", // OSM tile URL
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: _markers.toList(), // Pass markers
              ),
            ],
          ),

          // Search Bar
          if (_searchBarVisible)
            Positioned(
              top: 40,
              left: 20,
              right: 20,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 2))
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.blue),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: "Search a place...",
                          border: InputBorder.none,
                        ),
                        onSubmitted: _searchPlace,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Floating Action Button for current location
          Positioned(
            bottom: 80,
            right: 16,
            child: FloatingActionButton(
              onPressed: _updateUserLocation,
              child: Icon(Icons.my_location, color: Colors.white),
              backgroundColor: Colors.blue,
            ),
          ),

          // Floating Action Button to show/hide the search bar
          Positioned(
            bottom: 80,
            left: 16,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _searchBarVisible = !_searchBarVisible;
                });
              },
              child: Icon(Icons.search, color: Colors.white),
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
