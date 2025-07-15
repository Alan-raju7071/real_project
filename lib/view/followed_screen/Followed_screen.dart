import 'package:flutter/material.dart';
import 'package:real_project/Utilits/constants/colorconstant.dart';
import 'package:real_project/Utilits/constants/image_constants.dart';
import 'package:real_project/Utilits/constants/text_constants.dart';
import 'package:real_project/view/Splash_screen/Splash_screen.dart';
import 'package:real_project/widgets/Custom_image_container.dart';
import 'package:real_project/widgets/FollowCard.dart';
import 'package:url_launcher/url_launcher.dart';


class FollowScreen extends StatefulWidget {
  const FollowScreen({Key? key}) : super(key: key);

  @override
  State<FollowScreen> createState() => _FollowScreenState();
}

class _FollowScreenState extends State<FollowScreen> {
  Future<void> _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}

  List<bool> followed = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    int completed = followed.where((f) => f).length;

    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Custom_image_container(),
              ),
              Text(TextConstants.welcpost,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colorconstants.primaryblue),),
              SizedBox(height: 10,),
              Text(TextConstants.getstart),
              SizedBox(height: 10,),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("progress", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("$completed/4", style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(value: completed / 4),
              const SizedBox(height: 16),
          
              
              ListView(
                physics: const NeverScrollableScrollPhysics(), 
                 shrinkWrap: true, 
                
                children: [
                  FacebookCard(
                    followe: TextConstants.follow,
                    tile: TextConstants.title,
                    subtitles: TextConstants.subtitle,
                    followtext: TextConstants.follow,
                    followedsstext: TextConstants.followedtext,
                    imageUrl: ImageConstants.facebooklogo,
                    followed: followed[0],
                     onFollow: () async {
    await _launchURL('https://www.facebook.com/people/Ziya-Academy/61571052597141/?_rdr'); 
    setState(() {
      followed[0] = true;
    });
  },
                  ),
                  FacebookCard(
  followe: TextConstants.follow,
  tile: TextConstants.instatitle,
  subtitles: TextConstants.instasubtitle,
  followtext: TextConstants.follow,
  followedsstext: TextConstants.followedtext,
  imageUrl: ImageConstants.instalogo,
  followed: followed[1],
  onFollow: () async {
    await _launchURL('https://www.instagram.com/ziya_academy_/?hl=en'); 
    setState(() {
      followed[1] = true;
    });
  },
),

                  
                   FacebookCard(
                    followe: TextConstants.subscribe,
                    tile: TextConstants.yutibtitle,
                    subtitles: TextConstants.yotubsubtitle,
                    followtext: TextConstants.subscribe,
                    followedsstext: TextConstants.subscribed,
                    imageUrl: ImageConstants.youTubelogo,
                    followed: followed[2],
                    onFollow: () async {
    await _launchURL('https://www.instagram.com/your_page'); 
    setState(() {
      followed[2] = true;
    });
  },
                    
                  ),
                   FacebookCard(
                    followe: TextConstants.join,
                    tile: TextConstants.watstitle,
                    subtitles: TextConstants.watssubtitle,
                    followtext: TextConstants.join,
                    followedsstext: TextConstants.joined,
                    imageUrl: ImageConstants.wattaapplogo,
                    followed: followed[3],
                     onFollow: () async {
    await _launchURL('https://www.instagram.com/your_page'); 
    setState(() {
      followed[3] = true;
    });
  },
                  ),
                   ],
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),    
                child: Text(TextConstants.followabove),
              ),
               InkWell(
                onTap: completed == 4
      ? () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>SplashScreen ()),
          );
        }
      : null,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                       color: completed == 4 ? Colors.blue : Colorconstants.primarygrey,
                       borderRadius: BorderRadius.circular(5)
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10,),
                   
                    child: Center(child: Text("Complete all follows to continue",style: TextStyle(fontWeight: FontWeight.bold,color: Colorconstants.darkgrey),)),
                  
                  ),
                ))
              
            ],
          ),
        ),
      ),
    );
  }
}
