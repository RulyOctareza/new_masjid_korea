import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:masjid_korea/models/remote/masjid_model.dart';

class MasjidService {
  final CollectionReference _masjidReference = FirebaseFirestore.instance
      .collection('masjids');



  Future<List<MasjidModel>> fetchMasjid() async {
    try {
      QuerySnapshot result = await _masjidReference.get();

      List<MasjidModel> masjid =
          result.docs.map((e) {
            return MasjidModel.fromJson(e.id, e.data() as Map<String, dynamic>);
          }).toList();

      return masjid;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<List<MasjidModel>> fetchMasjidByComunity(String comunity) async {
    try {
      QuerySnapshot result =
          await _masjidReference.where('comunity', isEqualTo: comunity).get();

      List<MasjidModel> masjid =
          result.docs
              .map(
                (e) => MasjidModel.fromJson(
                  e.id,
                  e.data() as Map<String, dynamic>,
                ),
              )
              .toList();

      return masjid;
    } catch (e) {
      rethrow;
    }
  }


}
