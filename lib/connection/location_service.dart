import 'package:evently/view/location/location_picker.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  static Future<LatLng?> pickLocation(BuildContext context) async {
    LatLng? pickedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LocationPicker(),
      ),
    );

    return pickedLocation;
  }

  static Future<String?> getLocationDetails(LatLng location) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      location.latitude,
      location.longitude,
    );
    return placemarks.isNotEmpty
        ? '${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.country}'
        : null;
  }
}
