part of 'masjid_cubit.dart';

abstract class MasjidState extends Equatable {
  const MasjidState();

  @override
  List<Object> get props => [];
}

final class MasjidInitial extends MasjidState {}

final class MasjidLoading extends MasjidState {}

final class MasjidSuccess extends MasjidState {
  final List<MasjidModel> masjid;

  const MasjidSuccess(this.masjid);

  @override
  List<Object> get props => [masjid];
}

final class MasjidFailed extends MasjidState {
  final String error;

  const MasjidFailed(this.error);

  @override
  List<Object> get props => [error];
}
