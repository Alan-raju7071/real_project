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
  String selectedLocation = 'Ernakulam';

List<Map<String, String>> locationBasedBanners = [];

final Map<String, List<Map<String, String>>> locationBannerMap = {
  'Ernakulam': [
    {
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDxUlhDCrv9RmGFNVME75myxRdtkI_pfCLww&s",//
      "url": "https://www.instagram.com/p/C1B-SuCv6nv/"
    },
    {
      "image": "https://static.helioswatchstore.com/media/magespacex/storepickup/images/store/gallery/h/l/hlks_1.jpg",//
      "url": "https://www.helioswatchstore.com/store-locator/kochi/watch-store-in-lulu-mall"
    },

     {
      "image": "https://app.clicoffer.com/uploads/flyers/71779/Bakrid_LuLu-Kochi-4_thumb.webp",
      "url": "https://www.clicoffer.com/en/india/ernakulam/offers/lulu-hypermarket-11#google_vignette" //
    },
     {
      "image": "https://upload.wikimedia.org/wikipedia/commons/8/82/Forum_Mall%2C_Kochi.jpg",//
      "url": "https://en.wikipedia.org/wiki/Forum_Mall_Kochi"
    },
  ],
  'Palakkad': [
    {
      "image": "https://i.ytimg.com/vi/291RJEuF6uo/hqdefault.jpg",//4
      "url": "https://www.youtube.com/watch?v=291RJEuF6uo"
    },
    {
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIC9dw3jWizOA0d0c-9mvJ-aKczHGcNtVIzQ&s",//work
      "url": "https://www.facebook.com/easybuyindia.official/posts/hello-palakkad-we-are-open-and-we-are-excitedcome-and-experience-keralas-favorit/3178766095525217/"//
    },
    {
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTE15jOLxl2UxkcJk5occyLqdua9M4NeDR7tQ&s",
      "url": "https://www.instagram.com/p/C-AiXv3tFaH/"//work
    },
    {
      "image": "https://i.ytimg.com/vi/tMTe6J8SY40/sddefault.jpg",
      "url": "https://www.youtube.com/watch?v=tMTe6J8SY40"//work
    },
  ],
  'Thrissur': [
    {
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRyCRHgxxAphRHUNuSrXigacnv6b3knI4PLXg&s",//work
      "url": "https://www.facebook.com/THRISSUROFFERS/"
    },
    {
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQR8wWSVDyE8vUABEBny-jhqC96cWyFBWOcSA&s",//work
      "url": "https://www.instagram.com/p/DDRlIT_i_rO/"
    },
    {
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCZpJoG1_qAH-vfDwkBzOjZwtErQfvnOBS_Q&s",
      "url": "https://www.facebook.com/TSF2020HAPPYDAYS/"
    },
    {
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUcTWM_5Seo4hGnHfR26N3Qy3FPccd7g9W8Q&s",
      "url": "https://www.thrissuroffers.com/deal/best-optical-shop-in-thrissur.html"
    },
  ],
};

  String? userName;

  @override
void initState() {
  super.initState();
  fetchUserName();
  updateLocationBanners(selectedLocation);
}

void updateLocationBanners(String location) {
  setState(() {
    locationBasedBanners = locationBannerMap[location] ?? [];
  });
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
  padding: const EdgeInsets.only(bottom: 12.0),
  child: DropdownButton<String>(
    value: selectedLocation,
    onChanged: (String? newValue) {
      if (newValue != null) {
        setState(() {
          selectedLocation = newValue;
          updateLocationBanners(newValue);
        });
      }
    },
    items: locationBannerMap.keys.map((String location) {
      return DropdownMenuItem<String>(
        value: location,
        child: Text(location),
      );
    }).toList(),
  ),
),

            
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CarouselSlider(
                
  options: CarouselOptions(
    height: MediaQuery.of(context).size.height * 0.25,
    autoPlay: true,
    enlargeCenterPage: true,
    viewportFraction: 0.9,
  ),
  items: locationBasedBanners.map((banner) {
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
  items: locationBasedBanners.map((banner) {
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
