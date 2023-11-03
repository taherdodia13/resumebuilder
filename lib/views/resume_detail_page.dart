import '../utils/exports.dart';

class ResumeDetailPage extends GetView<ResumeController> {
  const ResumeDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Resume resume = Resume(
      id: '',
      fullName: '',
      email: '',
      phone: '',
      education: '',
      summary: '',
    );

    if (Get.arguments != null) {
      resume = Get.arguments as Resume;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Details'),
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
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Get.toNamed(
                AppPages.resumeCreatePage,
                arguments: resume,
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        color: Colors.white, 
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.pink, // Header color
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    resume.fullName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Email'),
                      Text(resume.email),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Phone'),
                      Text(resume.phone),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Education',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(resume.education),
              const SizedBox(height: 20),
              const Text(
                'Summary',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(resume.summary),
            ],
          ),
        ),
      ),
    );
  }
}
