import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:masjid_korea/data/models/remote/masjid_model.dart';
import 'package:masjid_korea/core/usecases/distance_calculate.dart';
import 'package:masjid_korea/core/usecases/location_service.dart';
import 'package:masjid_korea/core/network/service/masjid_sorting_service.dart';
import 'package:masjid_korea/presentation/widgets/card/masjid_card.dart';

class MasjidTerdekat extends StatefulWidget {
  final List<MasjidModel> masjids;

  const MasjidTerdekat({required this.masjids, super.key});

  @override
  State<MasjidTerdekat> createState() => _MasjidTerdekatState();
}

class _MasjidTerdekatState extends State<MasjidTerdekat> {
  final LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();
    _locationService.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    if (!_locationService.locationServiceEnabled ||
        !_locationService.permissionGranted) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Please allow location services !'),
            ElevatedButton(
              onPressed: () async {
                await _locationService.getLocation();
                setState(() {});
              },
              child: const Text('Try Again !'),
            ),
          ],
        ),
      );
    }

    if (_locationService.currentPosition == null) {
      return  Center(child: Lottie.asset('assets/loading.json', width: 150, height: 150),
      );
    }

    List<MasjidModel> nearbyMasjids =
        MasjidSortingService.sortMasjidsByDistance(
          _locationService.currentPosition,
          widget.masjids,
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Mosques closest to you',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        ...nearbyMasjids.map((masjid) {
          double distance = calculateDistance(
            _locationService.currentPosition!.latitude,
            _locationService.currentPosition!.longitude,
            masjid.latitude,
            masjid.longitude,
          );

          return MasjidCard(masjid, distance: distance);
        }),
      ],
    );
  }
}
