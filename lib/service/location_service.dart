import 'dart:developer';
import 'dart:html' as html;
import 'package:flutter/foundation.dart';
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
      await html.window.navigator.geolocation.getCurrentPosition().then((
        position,
      ) {
        _currentPosition = Position(
          latitude: position.coords!.latitude!.toDouble(),
          longitude: position.coords!.longitude!.toDouble(),
          timestamp: DateTime.now(),
          accuracy: position.coords!.accuracy?.toDouble() ?? 0.0,
          altitude: position.coords!.altitude?.toDouble() ?? 0.0,
          heading: position.coords!.heading?.toDouble() ?? 0.0,
          speed: position.coords!.speed?.toDouble() ?? 0.0,
          speedAccuracy: 0.0,
          altitudeAccuracy: 0,
          headingAccuracy: 0,
        );
        _permissionGranted = true;
        _locationServiceEnabled = true;
      });
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
    _locationServiceEnabled = true;

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    log('Location data: ${position.latitude}, ${position.longitude}');
    _currentPosition = position;
  }
}
