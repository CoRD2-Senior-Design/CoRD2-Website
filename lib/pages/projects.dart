import 'package:flutter/material.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
              constraints: const BoxConstraints(
                maxWidth: 700.0, // Set the maximum width for the image
                maxHeight: 900.0, // Set the maximum height for the image
              ),
              child: Image.asset(
                'project.png', // Replace with the correct asset path
                fit: BoxFit.contain, // Fit the image within the container
                //alignment: Alignment.bottom, // Align the image to the bottom
              ),
            ),
          ],
        ),
      ),
    );
  }
}
