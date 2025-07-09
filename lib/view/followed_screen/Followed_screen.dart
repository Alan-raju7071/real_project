import 'package:flutter/material.dart';
import 'package:real_project/Utilits/constants/image_constants.dart';
import 'package:real_project/Utilits/constants/text_constants.dart';
import 'package:real_project/widgets/FollowCard.dart';


class FollowScreen extends StatefulWidget {
  const FollowScreen({Key? key}) : super(key: key);

  @override
  State<FollowScreen> createState() => _FollowScreenState();
}

class _FollowScreenState extends State<FollowScreen> {
  List<bool> followed = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    int completed = followed.where((f) => f).length;

    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Progress", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("$completed/4", style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: completed / 4),
            const SizedBox(height: 16),

            
            Expanded(
              child: ListView(
                
                children: [
                  FacebookCard(
                    followe: TextConstants.follow,
                    tile: TextConstants.title,
                    subtitles: TextConstants.subtitle,
                    followtext: TextConstants.follow,
                    followedsstext: TextConstants.followedtext,
                    imageUrl: ImageConstants.facebooklogo,
                    followed: followed[0],
                    onFollow: () {
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
                    onFollow: () {
                      setState(() {
                        followed[1] = true;
                      });
                    },
                  ),
                   FacebookCard(
                    followe: TextConstants.follow,
                    tile: TextConstants.yutibtitle,
                    subtitles: TextConstants.yotubsubtitle,
                    followtext: TextConstants.follow,
                    followedsstext: TextConstants.followedtext,
                    imageUrl: ImageConstants.youTubelogo,
                    followed: followed[2],
                    onFollow: () {
                      setState(() {
                        followed[2] = true;
                      });
                    },
                  ),
                   FacebookCard(
                    followe: TextConstants.follow,
                    tile: TextConstants.title,
                    subtitles: TextConstants.subtitle,
                    followtext: TextConstants.follow,
                    followedsstext: TextConstants.followedtext,
                    imageUrl: ImageConstants.wattaapplogo,
                    followed: followed[3],
                    onFollow: () {
                      setState(() {
                        followed[3] = true;
                      });
                    },
                  ),
                   ],
              ),
            ),
              ElevatedButton(
              onPressed: completed == 4 ? () {} : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: completed == 4 ? Colors.blue : Colors.grey,
              ),
              child: const Text("Complete all follows to continue"),
            ),
          ],
        ),
      ),
    );
  }
}
