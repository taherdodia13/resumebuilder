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
            children: [
              for (final entry in resumeController.resumes.asMap().entries)
                GestureDetector(
                  key: ValueKey(entry.value.id),
                  onTap: () {
                    Get.toNamed(
                      AppPages.resumeCreatePage,
                      arguments: entry.value,
                    );
                  },
                  child: Container(
                    key: ValueKey(entry.value.id),
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey, // Change color as needed
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      key: ValueKey(entry.value.id),
                      title: Text('Name: ${entry.value.fullName}'),
                      subtitle: Text('Education: ${entry.value.education}'),
                      leading: const Icon(Icons.drag_handle),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          showDeleteConfirmation(entry.value.id,
                              context); // Handle the delete action
                        },
                      ),
                    ),
                  ),
                )
            ],
            onReorder: (oldIndex, newIndex) {
              if (oldIndex < newIndex) {
                newIndex--;
              }
              if (oldIndex == newIndex) {
                return;
              }
              final item = resumeController.resumes.removeAt(oldIndex);
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

  void showDeleteConfirmation(String id, context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this resume?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                resumeController.deleteResume(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
