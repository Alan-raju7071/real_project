import 'package:flutter/material.dart';
import 'package:real_project/Utilits/constants/colorconstant.dart';
import 'package:real_project/Utilits/constants/image_constants.dart';

class FacebookCard extends StatefulWidget {
  final bool followed;
  final VoidCallback onFollow;
  final String imageUrl;
  final String tile;
  final String subtitles;
  final String followtext;
  final String followedsstext;
  final String followe;

  const FacebookCard({
    Key? key,
    required this.followed,
    required this.followe,
    required this.onFollow,
    required this.imageUrl,
    required this.tile,
    required this.subtitles,
    required this.followtext,
    required this.followedsstext,
    
  }) : super(key: key);

  @override
  State<FacebookCard> createState() => _FacebookCardState();
}

class _FacebookCardState extends State<FacebookCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.08, 
  width: MediaQuery.of(context).size.width * 0.12,

                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.imageUrl)),
                  borderRadius: BorderRadius.circular(5),
                ),
                
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(widget.tile, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(widget.subtitles, style: TextStyle(color: Colors.black54)),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

      
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children:  [
                    Icon(Icons.person_add_outlined, size: 16),
                    SizedBox(width: 5),
                    Text(widget.followe, style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
              const Spacer(),
             GestureDetector(
  onTap: widget.onFollow,
  child: Container(
   height: MediaQuery.of(context).size.height * 0.05, 
    width: MediaQuery.of(context).size.width * 0.3, 
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Colorconstants.darkblue, Colorconstants.darkviolet],
      ),
      borderRadius: BorderRadius.circular(6),
    ),
    alignment: Alignment.center, 
    child: Text(
      widget.followed ? widget.followedsstext : widget.followtext,
      style: TextStyle(
        color: widget.followed ? Colors.white : Colors.white,
        fontSize: 14, 
        fontWeight: FontWeight.w500, 
      ),
    ),
  ),
),

            ],
          ),
        ],
      ),
    );
  }
}
