import 'package:hive_flutter/hive_flutter.dart';
part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  final String? firebaseId;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final String gmail;
  @HiveField(3)
  final String age;
  @HiveField(4)
  final String question;
  @HiveField(5)
  final Set<String> correctAnswerIndex;
  @HiveField(7)
  int score;
  @HiveField(8)
  int? id;

  UserModel(
      {required this.firebaseId,
      required this.username,
      required this.gmail,
      required this.age,
      required this.question,
      required this.correctAnswerIndex,
      required this.score,
      this.id});
}
