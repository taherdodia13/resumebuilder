import '../helper/data_helper.dart';
import '../utils/exports.dart';

class ResumeController extends GetxController {
  DatabaseHelper dbHelper = DatabaseHelper.instance;
  RxList<Resume> resumes = <Resume>[].obs;

  Future<void> init() async {
    resumes.assignAll(await dbHelper.getResumes());
  }

  void updateResume(Resume updatedResume) async {
    final index = resumes.indexWhere((resume) => resume.id == updatedResume.id);
    if (index != -1) {
      resumes[index] = updatedResume;
      await dbHelper.updateResume(updatedResume);
    }
  }

  Future<void> addResume({
    required String fullName,
    required String email,
    required String phone,
    required String education,
    required String summary,
  }) async {
    final newResume = Resume(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      fullName: fullName,
      email: email,
      phone: phone,
      education: education,
      summary: summary,
    );

    await dbHelper.insertResume(newResume);
    resumes.add(newResume);
  }

   void deleteResume(String id) async {
    final index = resumes.indexWhere((resume) => resume.id == id);
    if (index != -1) {
      resumes.removeAt(index);
      await dbHelper.deleteResume(id);
    }
  }

  void reorderResumes(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = resumes.removeAt(oldIndex);
    resumes.insert(newIndex, item);
    update();
  }
}
