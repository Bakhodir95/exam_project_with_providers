import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geoposition;

class GooleMapService {
  static final _location = Location();

  static bool _isServiceEnabled = false;
  static PermissionStatus _permissionStatus = PermissionStatus.denied;
  static LocationData? currentLocation;

  static Future<void> init() async {
    await _checkService();
    await _checkPermission();

    await _location.changeSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
      interval: 1000,
    );
  }

  // joylashuvni olish xizmati yoqilganmi tekshiramiz
  static Future<void> _checkService() async {
    _isServiceEnabled = await _location.serviceEnabled();

    if (!_isServiceEnabled) {
      _isServiceEnabled = await _location.requestService();
      if (!_isServiceEnabled) {
        return; // Redirect to Settings - Sozlamalardan to'g'irlash kerak endi
      }
    }
  }

  // joylashuvni olish uchun ruxsat berilganmi tekshiramiz
  static Future<void> _checkPermission() async {
    _permissionStatus = await _location.hasPermission();

    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await _location.requestPermission();
      if (_permissionStatus != PermissionStatus.granted) {
        return; // Sozlamalardan to'g'irlash kerak (ruxsat berish kerak)
      }
    }
  }

  // hozirgi joylashuvni olamiz
  static Future<void> getCurrentLocation() async {
    print(_permissionStatus);
    if (_isServiceEnabled && _permissionStatus == PermissionStatus.granted) {
      currentLocation = await _location.getLocation();
    }
  }

  static Stream<LocationData> getLiveLocation() async* {
    yield* _location.onLocationChanged;
  }

  static Future<String> getLocationInformation(
      double latitude, double longitude) async {
    try {
      List<geoposition.Placemark> placemarks =
          await geoposition.placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        final geoposition.Placemark place = placemarks[0];
        return "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      } else {
        return "No address available";
      }
    } catch (e) {
      return "Error: $e";
    }
  }
}
