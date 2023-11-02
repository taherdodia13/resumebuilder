import 'package:resume_builder/utils/routes.dart';

import '../utils/exports.dart'; // Import your UserController

class ResumeCreatePage extends StatelessWidget {
  final ResumeController resumeController = Get.find();

  ResumeCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Resume resume = Resume(
        id: '', fullName: '', email: '', phone: '', education: '', summary: '');
    if (Get.arguments != null) {
      resume = Get.arguments as Resume;
    }
    final TextEditingController fullNameController = TextEditingController(
        text: resume.fullName.isNotEmptyAndNotNull ? resume.fullName : '');
    final TextEditingController emailController = TextEditingController(
        text: resume.email.isNotEmptyAndNotNull ? resume.email : '');
    final TextEditingController phoneController = TextEditingController(
        text: resume.phone.isNotEmptyAndNotNull ? resume.phone : '');
    final TextEditingController educationController = TextEditingController(
        text: resume.education.isNotEmptyAndNotNull ? resume.education : '');
    final TextEditingController summaryController = TextEditingController(
        text: resume.summary.isNotEmptyAndNotNull ? resume.summary : '');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Create New Resume'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildRoundedTextField(fullNameController, 'Full Name').p(10),
          _buildRoundedTextField(emailController, 'Email').p(10),
          _buildRoundedTextField(phoneController, 'Phone').p(10),
          _buildRoundedTextField(educationController, 'Education').p(10),
          _buildRoundedTextField(summaryController, 'Summary', maxLines: 4)
              .p(10),
          16.heightBox,
          _buildRoundedButton('Save', () {
            String fullName = fullNameController.text;
            String email = emailController.text;
            String phone = phoneController.text;
            String education = educationController.text;
            String summary = summaryController.text;

            if (fullName.isNotEmpty &&
                email.isNotEmpty &&
                phone.isNotEmpty &&
                education.isNotEmpty &&
                summary.isNotEmpty) {
              int existingIndex =
                  resumeController.resumes.indexWhere((r) => r.id == resume.id);

              if (existingIndex != -1) {
                // Update the existing resume in the ResumeController and Database
                resumeController.updateResume(Resume(
                  id: resume.id,
                  fullName: fullName,
                  email: email,
                  phone: phone,
                  education: education,
                  summary: summary,
                ));
              } else {
                // Create a new resume
                resumeController.addResume(
                  fullName: fullName,
                  email: email,
                  phone: phone,
                  education: education,
                  summary: summary,
                );
              }
              Get.toNamed(AppPages.homepage);
            } else {
              Get.snackbar('Error', 'All fields are required');
            }
          }),
        ],
      ).p(16),
    );
  }

  Widget _buildRoundedTextField(TextEditingController controller, String label,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
        ),
      ),
      maxLines: maxLines,
    );
  }

  Widget _buildRoundedButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Text(text),
    );
  }
}
