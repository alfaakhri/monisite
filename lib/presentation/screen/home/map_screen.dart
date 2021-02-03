import 'package:flutter/material.dart';
import 'package:flutter_monisite/external/color_helpers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';

class MapScreen extends StatefulWidget {
  final String latitude;
  final String longitude;
  final String sitename;

  const MapScreen({Key key, this.latitude, this.longitude, this.sitename})
      : super(key: key);

  @override
  _MapScreenState createState() =>
      _MapScreenState(this.latitude, this.longitude, this.sitename);
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
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              markers: _createMarker(),
              initialCameraPosition: CameraPosition(
                target: LatLng(double.parse(latitude), double.parse(longitude)),
                zoom: 12.0,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: RaisedButton(
              color: Colors.blue,
              onPressed: () async {
                final availableMaps = await MapLauncher.installedMaps;

                await availableMaps.first.showMarker(
                  coords: Coords(double.parse(latitude), double.parse(longitude)),
                  title: widget.sitename
                );

                Navigator.pop(context);
              },
              child: Text(
                "BUKA GOOGLE MAPS",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Set<Marker> _createMarker() {
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
