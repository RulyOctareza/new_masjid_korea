import 'dart:nativewrappers/_internal/vm/lib/developer.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:masjid_korea/models/remote/masjid_model.dart';
import 'package:masjid_korea/service/masjid_service.dart';

part 'masjid_state.dart';

class MasjidCubit extends Cubit<MasjidState> {
  MasjidCubit() : super(MasjidInitial());
  // fetch data from masjid
  void fetchMasjid() async {
    try {
      emit(MasjidLoading());

      List<MasjidModel> masjid = await MasjidService().fetchMasjid();

      emit(MasjidSuccess(masjid));
    } catch (e) {
      log(e.toString());
      emit(MasjidFailed(e.toString()));
    }
  }

  //fetch data from comunity masjid

  void fetchMasjidByComunity(String comunity) async {
    try {
      emit(MasjidLoading());

      List<MasjidModel> masjid = await MasjidService().fetchMasjidByComunity(
        comunity,
      );
      emit(MasjidSuccess(masjid));
    } catch (e) {
      log(e.toString());
      emit(MasjidFailed(e.toString()));
    }
  }
}
