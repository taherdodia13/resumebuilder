class Resume {
  String id;
  String title;
  String description;

  Resume({required this.id, required this.title, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory Resume.fromMap(Map<String, dynamic> map) {
    return Resume(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }
}
