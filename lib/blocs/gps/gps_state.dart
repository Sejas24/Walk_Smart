part of 'gps_bloc.dart';

class GpsState extends Equatable {
  final bool isGpsEnabled;
  final bool isGpsPermissionGrandted;

  bool get isAllGranted => isGpsEnabled && isGpsPermissionGrandted;

  const GpsState({
    required this.isGpsEnabled,
    required this.isGpsPermissionGrandted,
  });

  GpsState copywith({bool? isGpsEnabled, bool? isGpsPermissionGrandted}) =>
      GpsState(
        isGpsEnabled: isGpsEnabled ?? this.isGpsEnabled,
        isGpsPermissionGrandted:
            isGpsPermissionGrandted ?? this.isGpsPermissionGrandted,
      );

  @override
  List<Object> get props => [isGpsEnabled, isGpsPermissionGrandted];

  @override
  String toString() =>
      '{ $isGpsEnabled, isGpsPermissionGranted: $isGpsPermissionGrandted }';
}
