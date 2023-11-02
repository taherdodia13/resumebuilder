import '../utils/exports.dart';
import '../utils/routes.dart';

class HomePage extends StatelessWidget {
  final ResumeController resumeController = Get.find();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    resumeController.init();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Resumes'),
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        if (resumeController.resumes.isEmpty) {
          return const Center(child: Text('Create your new resume'));
        } else {
          return ReorderableListView(
            children: resumeController.resumes.asMap().entries.map((entry) {
              final Resume resume = entry.value;

              return ListTile(
                key: ValueKey(resume.id),
                title: Text(resume.title),
                subtitle: Text(resume.description),
                leading: const Icon(Icons.drag_handle),
              );
            }).toList(),
            onReorder: (oldIndex, newIndex) {
              if (oldIndex < newIndex) {
                // If an item is moved downwards
                newIndex -= 1;
              }

              final item = resumeController.resumes.removeAt(oldIndex);

              if (newIndex > oldIndex) {
                newIndex -= 1;
              }

              resumeController.resumes.insert(newIndex, item);
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppPages.resumeCreatePage);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
