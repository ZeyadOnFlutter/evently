import 'package:evently/providers/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker({super.key});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  LatLng? selectedLocation;

  void onTap(LatLng location) {
    setState(() {
      selectedLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Picker'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context, selectedLocation);
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: locationProvider.currentLocation ?? const LatLng(31.236655, 29.959907),
          zoom: 17,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        onTap: onTap,
        markers: selectedLocation != null
            ? {
                Marker(
                  markerId: const MarkerId('selected-location'),
                  position: selectedLocation!,
                )
              }
            : {},
      ),
    );
  }
}
