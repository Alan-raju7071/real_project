import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'dart:html' as html;

class AutofillController {
  static Future<String?> autofillLocation() async {
    try {
      if (kIsWeb) {
        final position = await html.window.navigator.geolocation.getCurrentPosition();
        final lat = position.coords?.latitude;
        final lon = position.coords?.longitude;

        if (lat != null && lon != null) {
          final response = await http.get(
            Uri.parse('https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$lat&lon=$lon'),
            headers: {'User-Agent': 'FlutterWebApp'},
          );

          if (response.statusCode == 200) {
            final data = jsonDecode(response.body);
            final address = data['address'];
            final city = address['city'] ?? address['town'] ?? address['village'] ?? '';
            final state = address['state'] ?? '';
            final pincode = address['postcode'] ?? '';
            return '$city, $state - $pincode';
          }
        }
      } else {
        final location = Location();
        bool serviceEnabled = await location.serviceEnabled();
        if (!serviceEnabled) {
          serviceEnabled = await location.requestService();
          if (!serviceEnabled) return null;
        }

        PermissionStatus permissionGranted = await location.hasPermission();
        if (permissionGranted == PermissionStatus.denied) {
          permissionGranted = await location.requestPermission();
          if (permissionGranted != PermissionStatus.granted) return null;
        }

        final locData = await location.getLocation();
        final response = await http.get(
          Uri.parse('https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=${locData.latitude}&lon=${locData.longitude}'),
          headers: {'User-Agent': 'FlutterApp'},
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final address = data['address'];
          final city = address['city'] ?? address['town'] ?? address['village'] ?? '';
          final state = address['state'] ?? '';
          final pincode = address['postcode'] ?? '';
          return '$city, $state - $pincode';
        }
      }
    } catch (e) {
      print("Autofill Location Error: $e");
    }

    return null;
  }
}
