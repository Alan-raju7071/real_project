import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:real_project/Utilits/constants/colorconstant.dart';
import 'package:real_project/Utilits/constants/image_constants.dart';
import 'package:real_project/view/login_screen/Login_screen.dart';
import 'package:real_project/widgets/Appbar_title.dart';
import 'package:url_launcher/url_launcher.dart';

class Dashboaerd_Homescreen extends StatefulWidget {
  const Dashboaerd_Homescreen({super.key});

  @override
  State<Dashboaerd_Homescreen> createState() => _Dashboaerd_HomescreenState();
}

class _Dashboaerd_HomescreenState extends State<Dashboaerd_Homescreen> {
  String? userName;

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }
  Future<void> _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}


  Future<void> fetchUserName() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        debugPrint(" User UID is null");
        return;
      }

      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (!mounted) return;

      if (doc.exists && doc.data()!.containsKey('name')) {
        final name = doc['name'];
        debugPrint(" Fetched user name: $name");
        setState(() {
          userName = name;
        });
      } else {
        debugPrint(" Document missing or name not found for UID: $uid");
      }
    } catch (e) {
      debugPrint(" Error fetching username: $e");
    }
  }

  String getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

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
    List<Map<String, String>> bannerImages = [
  {"image": ImageConstants.ziyalogo1, "url": "https://www.ziyaacademy.co.in/assets/images/Ziya_Academy_Path_to_Success.png"},
  {"image": ImageConstants.ziyalogo2, "url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRADVvka688dohfIdgNPFf2Szfw8-7MjYWPmQ&s"},
  {"image": ImageConstants.ziyalogo3, "url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-k2ZC2FKoVT47gc8TBZiX5n0T4kJj2II9lw&s"},
  {"image": ImageConstants.ziyalogo4, "url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFJshYPwOJtRHZ6GsMrKkE53NP48_oLx33cA&s"},
];

List<Map<String, String>> bottombaner = [
  {"image": ImageConstants.ziyalogobottom1, "url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzbPiniWXteFtK9_PIcsJFw9UMZgieIWs1aBtPtrkoElwo4ZT3u9024fgs7CXdA1g7ERE&usqp=CAU"},
  {"image": ImageConstants.ziyalogobottom2, "url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2i4xjgfo4XvfNUWJJ83Boh9qCzwguhJczWQ&s"},
  {"image": ImageConstants.ziyalogobottom3, "url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQudBKrM7BpKMZZZyyCkFd5clOHKsCkH3GX6Q&s"},
  {"image": ImageConstants.ziyalogobottom4, "url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR35l0GmK7otFHlAInmIlGrkGAxR71cQRkfUg&s"},
];


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colorconstants.primarywhite,
        elevation: 0,
        title: AppbarTitle(userName: userName ?? ""),
        actions: [ CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.notifications, color: Colors.white),
                ),],
      ),
      body: Stack(
  children: [
    SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CarouselSlider(
  options: CarouselOptions(
    height: MediaQuery.of(context).size.height * 0.25,
    autoPlay: true,
    enlargeCenterPage: true,
    viewportFraction: 0.9,
  ),
  items: bannerImages.map((banner) {
    return Builder(
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: GestureDetector(
              onTap: () => _launchURL(banner['url']!),
              child: Image.network(
                banner['image']!,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        );
      },
    );
  }).toList(),
),

            ),
        
            
            if (userName != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                child: Text(
                  "${getGreetingMessage()}, $userName ",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
        
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 12.0),
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
        
            
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Card(
                elevation: 3,
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildButtonItem(
                        icon: Icons.add_task,
                        label: 'New Task',
                        onTap: () => debugPrint('New Task tapped'),
                      ),
                      _buildButtonItem(
                        icon: Icons.card_giftcard,
                        label: 'Invite & Earn',
                        onTap: () => debugPrint('Invite tapped'),
                        iconColor: Colors.purple,
                      ),
                      _buildButtonItem(
                        icon: Icons.account_balance_wallet_outlined,
                        label: 'Wallet',
                        onTap: () => debugPrint('Wallet tapped'),
                        iconColor: Colors.green,
                      ),
                      _buildButtonItem(
                        icon: Icons.history,
                        label: 'Task History',
                        onTap: () => debugPrint('History tapped'),
                        iconColor: Colors.orange,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        
            
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CarouselSlider(
  options: CarouselOptions(
    height: MediaQuery.of(context).size.height * 0.20,
    autoPlay: true,
    enlargeCenterPage: true,
    viewportFraction: 0.9,
  ),
  items: bottombaner.map((banner) {
    return Builder(
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: GestureDetector(
              onTap: () => _launchURL(banner['url']!),
              child: Image.network(
                banner['image']!,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        );
      },
    );
  }).toList(),
),

            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
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
  Widget _buildButtonItem({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
  Color iconColor = Colors.blue,
}) {
  return Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: iconColor.withOpacity(0.1),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
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
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: Colors.grey),
        ),
      ],
    );
  }
}
