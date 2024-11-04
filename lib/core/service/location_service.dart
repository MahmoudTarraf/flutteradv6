// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart'; // For reverse geocoding

// class LocationService {
//   String location = "No Location Found";
//   String address = "No Address Found";

//   // Check location permission
//   Future<String> checkPermission() async {
//     LocationPermission permission;

//     // Check if location services are enabled
//     bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!isLocationEnabled) {
//       location = "Location services are disabled.";
//       return location;
//     }

//     // Request permission if it's not already granted
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.deniedForever) {
//         location = "Location permissions are permanently denied.";
//         return location;
//       }
//       if (permission == LocationPermission.denied) {
//         location = "Location permission denied.";
//         return location;
//       }
//     }

//     // Permission is granted
//     return "Permission granted";
//   }

//   // Function to check permission and get the current user location
//   Future<String> getUserLocation() async {
//     // Check permission first
//     String permissionStatus = await checkPermission();
//     if (permissionStatus != "Permission granted") {
//       return permissionStatus; // Return the permission status if not granted
//     }

//     try {
//       // Get the user's current position (latitude, longitude)
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       // Now use reverse geocoding to get address from lat, long
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         position.latitude,
//         position.longitude,
//       );

//       // Check if placemarks are found
//       if (placemarks.isNotEmpty) {
//         Placemark place = placemarks[0];
//         address =
//             "${place.name}, ${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}"; // Full address details
//         // Print the address
//         return address;
//       } else {
//         address = "No address found";
//         return address;
//       }
//     } catch (e) {
//       location = "Error: ${e.toString()}";
//       return location;
//     }
//   }

//   // Function to get the address from selected latitude and longitude
//   Future<String> getAddressFromCoordinates(
//       {required double latitude, required double longitude}) async {
//     try {
//       List<Placemark> placemarks =
//           await placemarkFromCoordinates(latitude, longitude);

//       // Check if placemarks are found
//       if (placemarks.isNotEmpty) {
//         Placemark place = placemarks[0];
//         address =
//             "${place.name}, ${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}"; // Full address details        // Print the address
//         return address;
//       } else {
//         address = "No address found";
//         return address;
//       }
//     } catch (e) {
//       location = "Error: ${e.toString()}";
//       return location;
//     }
//   }
// }
