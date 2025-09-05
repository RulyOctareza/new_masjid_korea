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
      // Gunakan Geolocator web API langsung
      final position = await Geolocator.getCurrentPosition();
      _currentPosition = position;
      _permissionGranted = true;
      _locationServiceEnabled = true;
      log('Web location data: ${_currentPosition?.latitude}, ${_currentPosition?.longitude}');
    } catch (e) {
      log('Error getting location on web: $e');
      _permissionGranted = false;
      _locationServiceEnabled = false;
    }
  }

  Future<void> _getLocationNative() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      log('Location services are disabled.');
      _locationServiceEnabled = false;
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

    _currentPosition = await Geolocator.getCurrentPosition();
    _locationServiceEnabled = true;
    log('Native location data: ${_currentPosition?.latitude}, ${_currentPosition?.longitude}');
  }
}
