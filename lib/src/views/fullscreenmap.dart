import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
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
      body: createMap(),
      floatingActionButton: floatingButtons(),
    );
  }

  Column floatingButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        //Symbols
        FloatingActionButton(
          child: const Icon(Icons.emoji_symbols_outlined),
          onPressed: () {
            mapController?.addSymbol(SymbolOptions(
              geometry: center,
              iconImage: 'assetImage',
              iconSize: 3,
              textField: 'Montana creada aquí',
              textOffset: const Offset(0, 2),
            ));
          },
        ),
        const SizedBox(height: 5),
        //Zoom In
        FloatingActionButton(
          child: const Icon(Icons.zoom_in_outlined),
          onPressed: () {
            mapController?.animateCamera(CameraUpdate.zoomIn());
          },
        ),
        const SizedBox(height: 5),
        //Zoom Out
        FloatingActionButton(
          child: const Icon(Icons.zoom_out_outlined),
          onPressed: () {
            mapController?.animateCamera(CameraUpdate.zoomOut());
          },
        ),
        const SizedBox(height: 5),
        //Change App Style
        FloatingActionButton(
          child: const Icon(Icons.add_to_home_screen_outlined),
          onPressed: () {
            if (selectedStyle == lightStyle) {
              selectedStyle = darkStyle;
            } else {
              selectedStyle = lightStyle;
            }
            _onStyleLoaded();
            setState(() {});
          },
        ),
      ],
    );
  }

  MapboxMap createMap() {
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

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    _onStyleLoaded();
  }

  void _onStyleLoadedCallback() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Style loaded :)"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: const Duration(seconds: 1),
    ));
  }

  void _onStyleLoaded() {
    addImageFromAsset("assetImage", "assets/custom-icon.png");
    addImageFromUrl("networkImage", "https://via.placeholder.com/50");
  }

  //Adds an asset image to the currently displayed style
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController?.addImage(name, list);
  }

  //Adds a network image to the currently displayed style
  Future<void> addImageFromUrl(String name, String url) async {
    var response = await http.get(url as Uri);
    return mapController?.addImage(name, response.bodyBytes);
  }
}
