import 'package:evently/connection/location_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationProvider with ChangeNotifier {
  LatLng? _currentLocation;

  LatLng? get currentLocation => _currentLocation;
  String? _address;
  String? get address => _address;
  Future<void> fetchCurrentLocation(BuildContext context) async {
    PermissionStatus permission = await Permission.location.request();

    if (permission == PermissionStatus.granted) {
      Position position =
          await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _currentLocation = LatLng(position.latitude, position.longitude);
      _address = await LocationService.getLocationDetails(_currentLocation!);
    } else if (permission.isDenied) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Location permission denied"),
          ),
        );
      } else if (permission.isPermanentlyDenied) {
        await openAppSettings();
      }
    }
    notifyListeners();
  }
}
