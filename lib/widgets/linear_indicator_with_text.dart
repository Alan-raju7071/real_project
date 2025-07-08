import 'package:flutter/material.dart';

class linear_indicator_with_text extends StatelessWidget {
  const linear_indicator_with_text({
    super.key,
    required this.steps,
    required this.currentStep,
  });

  final List<String> steps;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(steps.length, (index) {
            return Text(
              steps[index],
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: index == currentStep
                    ? Colors.blue
                    : Colors.grey.shade600,
              ),
            );
          }),
        ),
     
    const SizedBox(height: 6),
    
    
    LinearProgressIndicator(
      value: (currentStep + 1) / steps.length,
      backgroundColor: Colors.grey.shade300,
      color: Colors.blue,
      minHeight: 5,
    ),
     ],
    );
  }
}
