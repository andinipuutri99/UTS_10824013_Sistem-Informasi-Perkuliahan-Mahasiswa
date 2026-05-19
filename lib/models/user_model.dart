// lib/models/user_model.dart

class UserProfile {
  final String fullName;
  final String nim;
  final String username;
  final String email;
  final String className;
  final String studyProgram;
  final String faculty;
  final String yearOfEntry;
  final int points;
  final String level;
  final String? profileImage;

  UserProfile({
    required this.fullName,
    required this.nim,
    required this.username,
    required this.email,
    required this.className,
    required this.studyProgram,
    required this.faculty,
    required this.yearOfEntry,
    this.points = 0,
    this.level = 'Bronze',
    this.profileImage,
  });

  UserProfile copyWith({
    String? fullName,
    String? nim,
    String? username,
    String? email,
    String? className,
    String? studyProgram,
    String? faculty,
    String? yearOfEntry,
    int? points,
    String? level,
    String? profileImage,
  }) {
    return UserProfile(
      fullName: fullName ?? this.fullName,
      nim: nim ?? this.nim,
      username: username ?? this.username,
      email: email ?? this.email,
      className: className ?? this.className,
      studyProgram: studyProgram ?? this.studyProgram,
      faculty: faculty ?? this.faculty,
      yearOfEntry: yearOfEntry ?? this.yearOfEntry,
      points: points ?? this.points,
      level: level ?? this.level,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'nim': nim,
        'username': username,
        'email': email,
        'className': className,
        'studyProgram': studyProgram,
        'faculty': faculty,
        'yearOfEntry': yearOfEntry,
        'points': points,
        'level': level,
        'profileImage': profileImage,
      };

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        fullName: json['fullName'] ?? '',
        nim: json['nim'] ?? '',
        username: json['username'] ?? '',
        email: json['email'] ?? '',
        className: json['className'] ?? '',
        studyProgram: json['studyProgram'] ?? '',
        faculty: json['faculty'] ?? '',
        yearOfEntry: json['yearOfEntry'] ?? '',
        points: json['points'] ?? 0,
        level: json['level'] ?? 'Bronze',
        profileImage: json['profileImage'],
      );
}

enum ClassStatus { ongoing, upcoming, canceled }

class ScheduleItem {
  final String id;
  final String day;
  final String courseName;
  final String lecturer;
  final String room;
  final String timeStart;
  final String timeEnd;
  final ClassStatus status;
  final String? description;

  ScheduleItem({
    required this.id,
    required this.day,
    required this.courseName,
    required this.lecturer,
    required this.room,
    required this.timeStart,
    required this.timeEnd,
    required this.status,
    this.description,
  });

  String get statusLabel {
    switch (status) {
      case ClassStatus.ongoing:
        return 'Ongoing';
      case ClassStatus.upcoming:
        return 'Upcoming';
      case ClassStatus.canceled:
        return 'Canceled';
    }
  }
}

class NewsItem {
  final String id;
  final String title;
  final String content;
  final String category;
  final String imageUrl;
  final String publishedAt;

  NewsItem({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.imageUrl,
    required this.publishedAt,
  });
}
