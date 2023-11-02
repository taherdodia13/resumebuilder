class Resume {
  String id;
  String fullName;
  String email;
  String phone;
  String education;
  String summary;

  Resume({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.education,
    required this.summary,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'education': education,
      'summary': summary,
    };
  }

  factory Resume.fromMap(Map<String, dynamic> map) {
    return Resume(
      id: map['id'],
      fullName: map['fullName'],
      email: map['email'],
      phone: map['phone'],
      education: map['education'],
      summary: map['summary'],
    );
  }
}
