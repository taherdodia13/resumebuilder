import 'package:resume_builder/utils/routes.dart';

import '../utils/exports.dart'; // Import your UserController

class ResumeCreatePage extends StatelessWidget {
  final ResumeController resumeController = Get.find();

  ResumeCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Resume'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            ElevatedButton(
              onPressed: () {
                String title = titleController.text;
                String description = descriptionController.text;

                if (title.isNotEmpty && description.isNotEmpty) {
                  resumeController.addResume(title, description);
                  titleController.clear();
                  descriptionController.clear();

                  Get.toNamed(AppPages.homepage);
                } else {
                  Get.snackbar(
                      'Error', 'Title and description cannot be empty');
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
