import '../utils/exports.dart';

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
                      AppPages.resumeDetailPage,
                      arguments: entry.value,
                    );
                  },
                  child: Container(
                    key: ValueKey(entry.value.id),
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.listTileColor,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      key: ValueKey(entry.value.id),
                      title: Text(
                        entry.value.fullName,
                        style: TextStyle(
                            color: AppColor.educationDesc,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(
                        'Education: ${entry.value.education}',
                        style: TextStyle(
                            color: AppColor.educationDesc,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          size: 20.sp,
                          color: AppColor.deleteButtonColor,
                        ),
                        onPressed: () {
                          showDeleteConfirmation(entry.value.id, context);
                        },
                      ),
                    ),
                  ),
                )
            ],
            onReorder: (oldIndex, newIndex) {
              resumeController.reorderResumes(oldIndex, newIndex);
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
              child: const Text(
                'Delete',
                style: TextStyle(color: AppColor.deleteButtonColor),
              ),
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
