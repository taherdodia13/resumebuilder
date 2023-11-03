import '../helper/data_helper.dart';
import '../utils/exports.dart';

class ResumeController extends GetxController {
  DatabaseHelper dbHelper = DatabaseHelper.instance;
  RxList<Resume> resumes = <Resume>[].obs;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController summaryController = TextEditingController();

  @override
  void onInit() async {
    resumes.assignAll(await dbHelper.getResumes());
    Resume? resume = Get.arguments as Resume?;

    if (resume != null) {
      fullNameController.text = resume.fullName;
      emailController.text = resume.email;
      phoneController.text = resume.phone;
      educationController.text = resume.education;
      summaryController.text = resume.summary;
    }
    super.onInit();
  }

  @override
  void dispose() {
    fullNameController.text = '';
    emailController.text = '';
    phoneController.text = '';
    educationController.text = '';
    summaryController.text = '';
    super.dispose();
  }

  @override
  void onClose() {
    fullNameController.text = '';
    emailController.text = '';
    phoneController.text = '';
    educationController.text = '';
    summaryController.text = '';
    super.onClose();
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
    if (oldIndex < newIndex) {
      newIndex--;
    }
    if (oldIndex == newIndex) {
      return;
    }
    final item = resumes.removeAt(oldIndex);
    resumes.insert(newIndex, item);
    update();
  }
}
