import 'package:geolocator/geolocator.dart';
import 'package:masjid_korea/data/models/remote/masjid_model.dart';
import 'package:masjid_korea/core/usecases/distance_calculate.dart';

class MasjidSortingService {
  static List<MasjidModel> sortMasjidsByDistance(
    Position? currentPosition,
    List<MasjidModel> masjids,
  ) {
    if (currentPosition == null) {
      return [];
    }

    masjids.sort((a, b) {
      double distanceA = calculateDistance(
        currentPosition.latitude,
        currentPosition.longitude,
        a.latitude,
        a.longitude,
      );
      double distanceB = calculateDistance(
        currentPosition.latitude,
        currentPosition.longitude,
        b.latitude,
        b.longitude,
      );
      return distanceA.compareTo(distanceB);
    });

    return masjids.take(10).toList();
  }
}
