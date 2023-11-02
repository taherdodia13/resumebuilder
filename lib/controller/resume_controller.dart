import '../helper/data_helper.dart';
import '../utils/exports.dart';

class ResumeController extends GetxController {
  DatabaseHelper dbHelper = DatabaseHelper.instance;
  RxList<Resume> resumes = <Resume>[].obs;

  Future<void> init() async {
    resumes.assignAll(await dbHelper.getResumes());
  }

  Future<void> addResume(String title, String description) async {
    final newResume = Resume(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
    );

    await dbHelper.insertResume(newResume);
    resumes.add(newResume);
  }

  void reorderResumes(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = resumes.removeAt(oldIndex);
    resumes.insert(newIndex, item);
    update(); // Ensure to notify the UI after reordering the list
  }
}
