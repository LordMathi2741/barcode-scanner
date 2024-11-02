import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/scan_model.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    MapType currentMapType = MapType.normal;
    final ScanModel? scan = ModalRoute.of(context)?.settings.arguments as ScanModel?;
    final CameraPosition kGooglePlex = CameraPosition(
      target:  scan!.getLatLng(),
      zoom: 14.4746,
      tilt: 50
    );
    Set<Marker> markers = <Marker>{};
    markers.add(
        Marker(
            markerId: const MarkerId(
                'geo-location'),
            position: scan.getLatLng()
        )
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Center(
          child: Text(
            "Mapa",
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async{
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: scan.getLatLng(),
                        zoom: 17.5,
                      tilt: 50
                    )
                )
                );
              },
              icon: const Icon(
                  Icons.location_on_sharp,
                color: Colors.white,
              )
          )
        ],
      ),
      body: GoogleMap(
        markers: markers,
        myLocationButtonEnabled: false,
        mapType: currentMapType,
        initialCameraPosition: kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.layers),
          onPressed: (){
              setState(() {
                if(currentMapType == MapType.normal){
                  currentMapType = MapType.satellite;
                }else{
                  currentMapType = MapType.normal;
                }
              });
          }
      ),
    );
  }
}

