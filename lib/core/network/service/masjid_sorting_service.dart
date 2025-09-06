import 'package:geolocator/geolocator.dart';
import 'package:masjid_korea/data/models/remote/masjid_model.dart';
import 'package:masjid_korea/core/usecases/distance_calculate.dart';

class MasjidSortingService {
  static List<MasjidModel> sortMasjidsByDistance(
    Position? currentPosition,
    List<MasjidModel> masjids,
  ) {
    // Jika posisi belum tersedia, jangan mengubah list sumber dan kembalikan kosong
    if (currentPosition == null) {
      return [];
    }

    // Salin list agar tidak memutasi state sumber (menghindari race condition pada UI)
    final List<MasjidModel> sorted = List<MasjidModel>.from(masjids);

    // Saring koordinat tidak valid (0,0) atau NaN yang dapat menyebabkan hasil aneh
    final filtered = sorted.where((m) {
      final lat = m.latitude;
      final lon = m.longitude;
      final valid = lat != 0.0 || lon != 0.0;
      return valid && lat.isFinite && lon.isFinite;
    }).toList();

    filtered.sort((a, b) {
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

    // Ambil maksimal 10 terdekat
    return filtered.take(10).toList();
  }
}
