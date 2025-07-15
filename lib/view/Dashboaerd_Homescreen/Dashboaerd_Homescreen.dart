import 'package:flutter/material.dart';
import 'package:real_project/Utilits/constants/image_constants.dart';
import 'package:real_project/widgets/Appbar_title.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:real_project/Utilits/constants/colorconstant.dart';
import 'package:real_project/view/login_screen/Login_screen.dart';


class Dashboaerd_Homescreen extends StatelessWidget {
  const Dashboaerd_Homescreen({super.key});

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
Widget build(BuildContext context) {
  List<String> bannerImages = [
    ImageConstants.ziyalogo1,
    ImageConstants.ziyalogo2,
    ImageConstants.ziyalogo3,
    ImageConstants.ziyalogo4
  ];

  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colorconstants.primarywhite,
      elevation: 0,
      leading: AppbarTitle()
      
  
    ),
    body: Stack(
      children: [
        Column(
          children: [
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.25,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                ),
                items: bannerImages.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Image.network(
                            imagePath,
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),

            Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16.0),
  child: Card(
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatusItem(
            icon: Icons.account_balance_wallet,
            label: 'Wallet',
            value: '₹500',
          ),
          _buildStatusItem(
            icon: Icons.star,
            label: 'Credits',
            value: '10',
            iconColor: Colors.amber,
          ),
          _buildStatusItem(
            icon: Icons.check_circle,
            label: 'Tasks',
            value: '15',
          ),
        ],
      ),
    ),
  ),
),

          ],
        ),

        
        Positioned(
          top: 0,
          right: 5,
          child: IconButton(
            icon: const Icon(Icons.logout, color: Colors.red, size: 28),
            onPressed: () => _logout(context),
            tooltip: 'Logout',
          ),
        ),
      ],
    ),
  );
}
Widget _buildStatusItem({
  required IconData icon,
  required String label,
  required String value,
  Color iconColor = Colors.blueAccent,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, color: iconColor, size: 28),
      const SizedBox(height: 6),
      Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
    ],
  );
}



}
