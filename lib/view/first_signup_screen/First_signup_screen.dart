import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:location/location.dart';
 import 'dart:html' as html;

import 'package:real_project/Utilits/constants/colorconstant.dart';
import 'package:real_project/Utilits/constants/text_constants.dart';
import 'package:real_project/view/Interest_screen/Interest_screen.dart';
import 'package:real_project/widgets/Custom_Textfield.dart';
import 'package:real_project/widgets/ProfileImagePicker.dart';
import 'package:real_project/widgets/User_details_container.dart';
import 'package:real_project/widgets/custom_button.dart';
import 'package:real_project/widgets/linear_indicator_with_text.dart';

String? formatDateAndAge(DateTime date) {
  final now = DateTime.now();
  int age = now.year - date.year;
  if (now.month < date.month || (now.month == date.month && now.day < date.day)) {
    age--;
  }
  return (age >= 16) ? "${DateFormat('dd/MM/yyyy').format(date)} (Age: $age)" : null;
}

class FirstSignupScreen extends StatefulWidget {
  const FirstSignupScreen({super.key});

  @override
  State<FirstSignupScreen> createState() => FirstSignupScreenState();
}

class FirstSignupScreenState extends State<FirstSignupScreen> {
  final int currentStep = 0;
  final List<String> steps = ['Personal Info', 'Interests', 'Verify'];

  final TextEditingController occupationController = TextEditingController();
  final TextEditingController otherQualificationController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  String city = '', state = '', pincode = '';
  String? selectedGender;
  File? profileImage;
  Uint8List? webImageBytes;
  String? selectedCountry;

  String? getFinalQualification() {
    final trimmed = otherQualificationController.text.trim();
    return trimmed.isNotEmpty ? trimmed : null;
  }

  Future<void> pickImage() async {
    try {
      if (kIsWeb) {
        final result = await FilePicker.platform.pickFiles(type: FileType.image);
        if (result != null && result.files.single.bytes != null) {
          if (!mounted) return;
          setState(() {
            webImageBytes = result.files.single.bytes!;
            profileImage = null;
          });
        }
      } else {
        final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          if (!mounted) return;
          setState(() {
            profileImage = File(pickedFile.path);
            webImageBytes = null;
          });
        }
      }
    } catch (e) {
      showMessage("Error picking image: $e");
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      final formatted = formatDateAndAge(picked);
      if (formatted == null) {
        showMessage("You must be at least 16 years old");
        return;
      }
      if (!mounted) return;
      setState(() {
        dobController.text = formatted;
      });
    }
  }

  Future<void> _autofillLocation() async {
    if (kIsWeb) {
      try {
        
       

        html.window.navigator.geolocation.getCurrentPosition().then((pos) async {
          final lat = pos.coords?.latitude;
          final lon = pos.coords?.longitude;

          if (lat != null && lon != null) {
            final response = await http.get(
              Uri.parse('https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$lat&lon=$lon'),
              headers: {'User-Agent': 'FlutterWebApp'},
            );

            if (response.statusCode == 200) {
              final data = jsonDecode(response.body);
              final address = data['address'];
              setState(() {
                city = address['city'] ?? address['town'] ?? address['village'] ?? '';
                state = address['state'] ?? '';
                pincode = address['postcode'] ?? '';
                locationController.text = '$city, $state - $pincode';
              });
            } else {
              showMessage("Failed to get location info from server.");
            }
          }
        }).catchError((e) {
          showMessage("Web geolocation failed: $e");
        });
      } catch (e) {
        showMessage("Web location error: $e");
      }
      return;
    }

    try {
      final location = Location();

      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          showMessage("Location services are disabled.");
          return;
        }
      }

      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          showMessage("Location permission denied.");
          return;
        }
      }

      final locData = await location.getLocation();

      final response = await http.get(
        Uri.parse(
          'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=${locData.latitude}&lon=${locData.longitude}',
        ),
        headers: {'User-Agent': 'FlutterApp'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final address = data['address'];

        setState(() {
          city = address['city'] ?? address['town'] ?? address['village'] ?? '';
          state = address['state'] ?? '';
          pincode = address['postcode'] ?? '';
          locationController.text = '$city, $state - $pincode';
        });
      } else {
        showMessage("Failed to get location info from server.");
      }
    } catch (e) {
      debugPrint("Location Error: $e");
      showMessage("Failed to detect location. Please try again.");
    }
  }

  void showMessage(String message) {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(TextConstants.notice),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(TextConstants.ok),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    final localeCountryCode = WidgetsBinding.instance.platformDispatcher.locale.countryCode;
    final countryMap = {'US': 'USA', 'IN': 'India', 'GB': 'UK'};
    selectedCountry = countryMap[localeCountryCode] ?? 'USA';
    Future.microtask(() => _autofillLocation());
  }

  @override
  void dispose() {
    dobController.dispose();
    occupationController.dispose();
    otherQualificationController.dispose();
    addressController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(TextConstants.signup,
                  style: TextStyle(
                      color: Colorconstants.primaryblack,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              const SizedBox(height: 24),
              linear_indicator_with_text(steps: steps, currentStep: currentStep),
              const SizedBox(height: 24),
              const Text(TextConstants.createacc,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Center(
                child: ProfileImagePicker(
                  webImageBytes: webImageBytes,
                  fileImage: profileImage,
                  onPickImage: pickImage,
                ),
              ),
              const SizedBox(height: 24),
              User_details_container(
                dobController: dobController,
                selectedGender: selectedGender,
                onDateTap: () => selectDate(context),
                onGenderChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text(TextConstants.locat, style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              TextFormField(
                controller: locationController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Your current location",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Unavailable' : null,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _autofillLocation,
                  child: const Text(
                    TextConstants.redetet,
                    style: TextStyle(color: Colorconstants.primaryblue),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(TextConstants.addres,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: "Street, Building, etc.",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
              ),
              const SizedBox(height: 20),
              const Text(TextConstants.qualif, style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                controller: otherQualificationController,
                decoration: InputDecoration(
                  labelText: 'Enter or select qualification',
                  labelStyle: TextStyle(color: Colorconstants.primarygrey),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: occupationController,
                decoration: InputDecoration(
                  labelText: 'Enter or select occupation',
                  labelStyle: TextStyle(color: Colorconstants.primarygrey),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
              ),
              const SizedBox(height: 16),
              const Text(TextConstants.referal, style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              CustomTextField(
                label: 'Enter referral code',
                labelColor: Colorconstants.primarygrey,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: InkWell(
                  onTap: () {
                    final finalQualification = getFinalQualification();
                    if (finalQualification == null) {
                      showMessage("Please enter your qualification");
                      return;
                    }
                    if (locationController.text.trim().isEmpty) {
                      showMessage("Please detect your location before continuing");
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const InterestsCategoriesWidget()),
                    );
                  },
                  child: CustomButton(
                    text: TextConstants.continu,
                    color: Colorconstants.primaryblue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
