import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final String latitude;
  final String longitude;
  final String sitename;

  const MapScreen({Key key, this.latitude, this.longitude, this.sitename}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState(this.latitude, this.longitude, this.sitename);
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController _controller;
  final String latitude;
  final String longitude;
  final String sitename;

  _MapScreenState(this.latitude, this.longitude, this.sitename);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        markers: _createMarker(),
        initialCameraPosition: CameraPosition(
          target: LatLng(double.parse(latitude), double.parse(longitude)),
          zoom: 12.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
      ),
    );
  }

  Set<Marker> _createMarker(){
    return <Marker>[
      Marker(
        markerId: MarkerId(sitename),
        position: LatLng(double.parse(latitude), double.parse(longitude)),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: sitename),
      ),
    ].toSet();
  }
}