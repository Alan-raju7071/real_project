import 'package:flutter/material.dart';
import 'package:real_project/Utilits/constants/colorconstant.dart';
import 'package:real_project/Utilits/constants/text_constants.dart';
import 'package:real_project/view/verify_screen/Verify_screen.dart';
import 'package:real_project/widgets/custom_button.dart';

class InterestsCategoriesWidget extends StatefulWidget {
  const InterestsCategoriesWidget({Key? key}) : super(key: key);

  @override
  State<InterestsCategoriesWidget> createState() =>
      _InterestsCategoriesWidgetState();
}

class _InterestsCategoriesWidgetState extends State<InterestsCategoriesWidget> {
  final Map<String, List<String>> interestCategories = {
    'Education': [
      'NIOS',
      'Online Learning',
      'School Life',
      'College Students',
      'Tuition & Coaching',
      'Skill Development',
      'Competitive Exams (NEET, UPSC, SSC)',
      'Spoken English',
      'Study Abroad',
    ],
    'Technology': [
      'Smartphones',
      'Mobile Apps',
      'Gadgets',
      'Internet Tips',
      'Digital Payments',
      'AI & ChatGPT',
      'Coding / Programming',
      'Web Development',
      'Ethical Hacking',
    ],
    'Lifestyle': [
      'Travel',
      'Fashion',
      'Health & Fitness',
      'Beauty & Makeup',
      'Food & Cooking',
      'Photography',
      'Parenting',
      'Journaling',
      'Minimalism',
    ],
    'Entertainment': [
      'Gaming (Mobile/PC/Console)',
      'Anime',
      'Cartoons',
      'Memes & Funny Videos',
      'Movies',
      'TV Shows',
      'Stand-up Comedy',
      'Music & Singing',
      'Dance & Reels',
    ],
    'Career & Money': [
      'Government Jobs',
      'Part-time Jobs',
      'Freelancing',
      'Internships',
      'Work From Home',
      'Side Hustles',
      'Resume Building',
      'Business Ideas',
      'Investment & Savings',
    ],
    'Social & Media': [
      'WhatsApp Status',
      'YouTube Shorts / Vlogs',
      'Instagram Reels',
      'TikTok (if regionally used)',
      'Snapchat Content',
      'ShareChat Content',
      'Influencer Marketing',
      'Affiliate Marketing',
      'Blogging & Vlogging',
    ],
    'Personal Growth': [
      'Motivation',
      'Time Management',
      'Goal Setting',
      'Self-Discipline',
      'Public Speaking',
      'Meditation / Mindfulness',
      'Productivity Tools',
      'Reading / Book Summaries',
    ],
    'Regional & Cultural': [
      'Malayalam Content',
      'Tamil Content',
      'Hindi Content',
      'Kerala Local News',
      'Tamil Nadu Updates',
      'Indian Culture & Festivals',
      'Village Life',
      'Art & Handicrafts',
    ],
    'Wellbeing & Awareness': [
      'Mental Health',
      'Physical Wellness',
      'Clean Living',
      'Women\'s Health',
      'Youth Guidance',
      'Toxic Parenting Awareness',
      'Study Motivation',
    ],
  };

  final Set<String> selectedInterests = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(TextConstants.intcat)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: interestCategories.entries.map((entry) {
                  final category = entry.key;
                  final items = entry.value;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '[$category]',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: items.map((item) {
                            final isSelected = selectedInterests.contains(item);
                            return ChoiceChip(
                              label: Text(
                                item,
                                style: const TextStyle(fontSize: 14),
                              ),
                              selected: isSelected,
                              onSelected: (bool selected) {
                                setState(() {
                                  if (category == 'Education') {
                                    selectedInterests
                                        .removeWhere((e) => interestCategories['Education']!.contains(e));
                                  }
                                  if (selected) {
                                    selectedInterests.add(item);
                                  } else {
                                    selectedInterests.remove(item);
                                  }
                                });
                              },
                              selectedColor: Colorconstants.primarygrey,
                              backgroundColor: Colorconstants.grey300,
                              labelStyle: TextStyle(
                                color: isSelected ? Colorconstants.primaryblue : Colorconstants.primaryblack,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
           Padding(
  padding: const EdgeInsets.symmetric(vertical: 16),
  child: GestureDetector(
    onTap: selectedInterests.length >= 5
        ? () {
            
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VerifyScreen()), 
            );
          }
        : null, 
    child: Opacity(
      opacity: selectedInterests.length >= 5 ? 1.0 : 0.5, 
      child: CustomButton(
        text: TextConstants.continu,
        color: Colorconstants.primaryblue,
      ),
    ),
  ),
),

           
          ],
        ),
      ),
    );
  }
}
