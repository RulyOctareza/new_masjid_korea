import 'dart:developer';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:geolocator/geolocator.dart';

class LocationService {
  Position? _currentPosition;
  bool _locationServiceEnabled = false;
  bool _permissionGranted = false;

  Position? get currentPosition => _currentPosition;
  bool get locationServiceEnabled => _locationServiceEnabled;
  bool get permissionGranted => _permissionGranted;

  Future<void> getLocation() async {
    if (kIsWeb) {
      await _getLocationWeb();
    } else {
      await _getLocationNative();
    }
  }

  Future<void> _getLocationWeb() async {
    try {
      // Geolocator web API akan memicu permission prompt
      final position = await Geolocator.getCurrentPosition();
      _currentPosition = position;
      _permissionGranted = true;
      _locationServiceEnabled = true;
      log('Web location data: ${_currentPosition?.latitude}, ${_currentPosition?.longitude}');
    } catch (e) {
      // Jika user menolak atau error lainnya, jangan crash
      log('Error getting location on web: $e');
      _permissionGranted = false;
      // Pada web, service dianggap selalu available meski permission ditolak
      _locationServiceEnabled = true;
      _currentPosition = null;
    }
  }

  Future<void> _getLocationNative() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      _locationServiceEnabled = serviceEnabled;
      if (!serviceEnabled) {
        log('Location services are disabled.');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          log('Location permission denied.');
          _permissionGranted = false;
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        log('Location permissions are permanently denied.');
        _permissionGranted = false;
        return;
      }

      _permissionGranted = true;

      try {
        _currentPosition = await Geolocator.getCurrentPosition();
      } catch (e) {
        log('Error fetching native current position: $e');
        _currentPosition = null;
      }
      _locationServiceEnabled = true;
      log('Native location data: ${_currentPosition?.latitude}, ${_currentPosition?.longitude}');
    } catch (e) {
      log('Location error (native): $e');
      _permissionGranted = false;
      // Service status tetap sesuai check awal
    }
  }
}
