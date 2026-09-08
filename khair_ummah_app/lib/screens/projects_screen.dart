import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../theme/app_theme.dart';
import '../widgets/project_card.dart';

class ProjectsScreen extends StatelessWidget {
  final Function(int) onTabChange;

  const ProjectsScreen({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('فلاحی منصوبے و شعبہ جات', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: AppData.projectCategories.length,
        itemBuilder: (context, index) {
          final project = AppData.projectCategories[index];
          return ProjectCard(
            project: project,
            onDonate: () => onTabChange(3),
          );
        },
      ),
    );
  }
}
