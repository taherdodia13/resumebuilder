import '../utils/exports.dart';

class ResumeCreatePage extends GetView<ResumeController> {
  const ResumeCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Create New Resume'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            controller.fullNameController.text = '';
            controller.emailController.text = '';
            controller.phoneController.text = '';
            controller.educationController.text = '';
            controller.summaryController.text = '';
            Get.back();
          },
        ),
      ),
      body: Obx(() {
        if (controller.resumes.isNotEmpty) {
          // ignore: unused_local_variable
          var a = controller.resumes.first;
          controller.onInit();
        }
        return Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildRoundedTextField(
                        controller.fullNameController,
                        'Full Name (Two words, max 16 characters)',
                      ).p(10),
                      _buildRoundedTextField(
                        controller.emailController,
                        'Email (Valid email)',
                      ).p(10),
                      _buildRoundedTextField(
                        controller.phoneController,
                        'Phone (Numeric only)',
                      ).p(10),
                      _buildRoundedTextField(
                        controller.educationController,
                        'Education',
                      ).p(10),
                      _buildRoundedTextField(
                        controller.summaryController,
                        'Summary',
                        maxLines: 4,
                      ).p(10),
                    ],
                  ),
                ),
              ),
              _buildRoundedButton('Save', () {
                String fullName = controller.fullNameController.text;
                String email = controller.emailController.text;
                String phone = controller.phoneController.text;
                String education = controller.educationController.text;
                String summary = controller.summaryController.text;

                RegExp nameRegex = RegExp(r'^[A-Za-z]{1,16}\s[A-Za-z]{1,16}$');
                RegExp emailRegex = RegExp(
                    r'^([a-zA-Z]([^~`?\/\\{\}\|\+=_\-*&\^$#!@<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\\"]+)*){6,30}|(\".+\"))@((([a-zA-Z0-9]+\.)+[a-zA-Z]{2,}))$');
                RegExp phoneRegex = RegExp(r'^[0-9]*$');

                if (nameRegex.hasMatch(fullName) &&
                    emailRegex.hasMatch(email) &&
                    phoneRegex.hasMatch(phone) &&
                    fullName.isNotEmpty &&
                    email.isNotEmpty &&
                    phone.isNotEmpty &&
                    education.isNotEmpty &&
                    summary.isNotEmpty) {
                  int existingIndex = controller.resumes
                      .indexWhere((r) => r.fullName == fullName);

                  if (existingIndex != -1) {
                    // Update the existing resume in the controller and Database
                    controller.updateResume(Resume(
                      id: controller.resumes[existingIndex].id,
                      fullName: fullName,
                      email: email,
                      phone: phone,
                      education: education,
                      summary: summary,
                    ));
                  } else {
                    // Create a new resume
                    controller.addResume(
                      fullName: fullName,
                      email: email,
                      phone: phone,
                      education: education,
                      summary: summary,
                    );

                    controller.fullNameController.text = '';
                    controller.emailController.text = '';
                    controller.phoneController.text = '';
                    controller.educationController.text = '';
                    controller.summaryController.text = '';
                  }
                  Get.toNamed(AppPages.homepage);
                } else {
                  if (!nameRegex.hasMatch(fullName) || (fullName.isEmpty)) {
                    Get.snackbar('Error', 'Please enter full name');
                  } else if ((!emailRegex.hasMatch(email)) || (email.isEmpty)) {
                    Get.snackbar('Error', 'Please enter correct email');
                  } else if ((!phoneRegex.hasMatch(phone)) || phone.isEmpty) {
                    Get.snackbar('Error', 'Please enter correct phone number');
                  } else if (education.isEmpty) {
                    Get.snackbar('Error', 'Please enter education information');
                  } else if (summary.isEmpty) {
                    Get.snackbar('Error', 'Please enter summary information');
                  } else {
                    Get.snackbar('Error', 'Please enter valid information');
                  }
                }
              }, context),
            ],
          ).p(16),
        );
      }),
    );
  }

  Widget _buildRoundedTextField(TextEditingController controller, String label,
      {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: AppColor.focusedTextfieldBorder,
            width: 2.0,
          ),
        ),
      ),
      maxLines: maxLines,
      validator: (value) {
        if (label.contains('Full Name')) {
          RegExp nameRegex = RegExp(r'^[A-Za-z]{1,16}\s[A-Za-z]{1,16}$');
          if (!nameRegex.hasMatch(value!)) {
            return 'Enter two words with a maximum of 16 characters each.';
          }
        } else if (label.contains('Email')) {
          RegExp emailRegex = RegExp(
              r'^([a-zA-Z0-9_\\-\\.+]+)@([a-zA-Z0-9_\\-\\.]+)\.([a-zA-Z]{2,5})$');
          if (!emailRegex.hasMatch(value!)) {
            return 'Enter a valid email address';
          }
        } else if (label.contains('Phone')) {
          RegExp phoneRegex = RegExp(r'^[0-9]*$');
          if (!phoneRegex.hasMatch(value!)) {
            return 'Enter a valid numeric phone number';
          }
        }
        return null;
      },
    );
  }

  Widget _buildRoundedButton(
      String text, VoidCallback onPressed, BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: 50,
      minWidth: context.width,
      color: AppColor.focusedTextfieldBorder,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text),
    );
  }
}
