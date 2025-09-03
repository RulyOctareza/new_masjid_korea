import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:masjid_korea/data/models/remote/masjid_model.dart';

class MasjidService {
  final CollectionReference _masjidReference = FirebaseFirestore.instance
      .collection('masjids');

  Future<List<MasjidModel>> fetchMasjid() async {
    try {
      QuerySnapshot result = await _masjidReference.get();

      if (result.docs.isEmpty) {
        log('Warning: No masjid documents found in Firestore');
        return [];
      }

      List<MasjidModel> masjid = result.docs.map((e) {
        try {
          return MasjidModel.fromJson(e.id, e.data() as Map<String, dynamic>);
        } catch (error) {
          log('Error parsing masjid document: $error');
          return null;
        }
      })
      .where((model) => model != null)
      .cast<MasjidModel>()
      .toList();

      return masjid;
    } catch (e) {
      log('Error fetching masjid data: ${e.toString()}');
      // Return empty list instead of rethrowing to prevent app crashes
      return [];
    }
  }

  Future<List<MasjidModel>> fetchMasjidByComunity(String comunity) async {
    try {
      if (comunity.isEmpty) {
        log('Warning: Empty community parameter provided');
        return [];
      }
      
      QuerySnapshot result =
          await _masjidReference.where('comunity', isEqualTo: comunity).get();

      if (result.docs.isEmpty) {
        log('Warning: No masjid documents found for community: $comunity');
        return [];
      }

      List<MasjidModel> masjid = result.docs.map((e) {
        try {
          return MasjidModel.fromJson(
            e.id,
            e.data() as Map<String, dynamic>,
          );
        } catch (error) {
          log('Error parsing masjid document: $error');
          return null;
        }
      })
      .where((model) => model != null)
      .cast<MasjidModel>()
      .toList();

      return masjid;
    } catch (e) {
      log('Error fetching masjid data by community: ${e.toString()}');
      // Return empty list instead of rethrowing to prevent app crashes
      return [];
    }
  }
}
