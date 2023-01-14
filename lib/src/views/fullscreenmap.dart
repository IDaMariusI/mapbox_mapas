import 'package:flutter/material.dart';

import 'package:mapbox_gl/mapbox_gl.dart';

class FullScreenMap extends StatefulWidget {
  const FullScreenMap({super.key});

  @override
  State<FullScreenMap> createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  String selectedStyle = MapboxStyles.LIGHT;
  String lightStyle = MapboxStyles.LIGHT;
  String darkStyle = MapboxStyles.DARK;

  final center = const LatLng(37.810575, -122.477174);

  MapboxMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: crearMapa(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: const Icon(Icons.add_to_home_screen_outlined),
            onPressed: () {
              if (selectedStyle == lightStyle) {
                selectedStyle = darkStyle;
              } else {
                selectedStyle = lightStyle;
              }

              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  MapboxMap crearMapa() {
    return MapboxMap(
      styleString: selectedStyle,
      onMapCreated: _onMapCreated,
      onStyleLoadedCallback: _onStyleLoadedCallback,
      initialCameraPosition: CameraPosition(
        target: center,
        zoom: 14,
      ),
    );
  }

  _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  _onStyleLoadedCallback() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Style loaded :)"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: const Duration(seconds: 1),
    ));
  }
}
