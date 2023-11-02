import 'package:resume_builder/views/resume_create_page.dart';

import '../utils/exports.dart';

class AppPages {
  static const String homepage = '/homepage';
  static const String resumeCreatePage = '/resumeCreatePage';

  static List<GetPage<dynamic>> get routes {
    return [
      // GetPage(
      // name: AppPages.mainpage,
      // page: () => const MainPage(),
      // binding: BindingsBuilder.put(() => MainPageController()),
      // ),
      GetPage(
        name: AppPages.homepage,
        page: () => HomePage(),
        // binding: BindingsBuilder.put(() => HomePageController()),
      ),
      GetPage(
        name: AppPages.resumeCreatePage,
        page: () => ResumeCreatePage(),
        binding: BindingsBuilder.put(() => ResumeController()),
      ),
    ];
  }
}
