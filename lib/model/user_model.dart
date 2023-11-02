import '../utils/exports.dart';

class User {
  String id;
  String name;
  List<Resume> resumes;

  User({required this.id, required this.name, this.resumes = const []});
}

