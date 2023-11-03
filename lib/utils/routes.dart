import 'package:resume_builder/views/resume_create_page.dart';

import '../utils/exports.dart';
import '../views/resume_detail_page.dart';

class AppPages {
  static const String homepage = '/homepage';
  static const String resumeCreatePage = '/resumeCreatePage';
  static const String resumeDetailPage = '/resumeDetailPage';

  static List<GetPage<dynamic>> get routes {
    return [
      GetPage(
        name: AppPages.homepage,
        page: () => const HomePage(),
        binding: BindingsBuilder.put(() => ResumeController()),
      ),
      GetPage(
        name: AppPages.resumeCreatePage,
        page: () => const ResumeCreatePage(),
        binding: BindingsBuilder.put(() => ResumeController()),
      ),
      GetPage(
        name: AppPages.resumeDetailPage,
        page: () => const ResumeDetailPage(),
        binding: BindingsBuilder.put(() => ResumeController()),
      ),
    ];
  }
}
