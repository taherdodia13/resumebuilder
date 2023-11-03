import 'utils/exports.dart';

void main() {
  dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Anime Trix',
          initialRoute: AppPages.homepage,
          getPages: AppPages.routes,
          debugShowCheckedModeBanner: false,
          // theme: appThemeData,
        );
      },
    );
  }
}

void dependencies() {
  Get.put(() => ResumeController(), permanent: true);
}
