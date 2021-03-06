// ignore_for_file: prefer_typing_uninitialized_variables
import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../controllers/question_controller.dart';
import '../Models/users.dart';
import '../controllers/profile_controllers.dart';
import '../widgets/user_profile_widget.dart';

final QuestionControl qcontroller = Get.put(QuestionControl());

class checkAnswer {
  var id;
  var answer;
  bool isCorrect;
  bool isSelected;

  checkAnswer(
      {this.id,
      this.answer,
      required this.isCorrect,
      required this.isSelected});

  factory checkAnswer.fromJson(Map<String, dynamic> json) {
    return checkAnswer(
      id: json['id'],
      answer: json['answer'],
      isCorrect: json['isCorrect'],
      isSelected: json['isSelected'],
    );
  }
}

// Add Choices
Future<checkAnswer> updateJsonTime({
  required String answer,
  required int id,
  required bool isCorrect,
  required bool isSelected,
}) async {
  final response = await http.patch(
    Uri.parse('http://localhost:3000/answers/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'answer': answer,
      'isCorrect': isCorrect,
      'isSelected': isSelected,
    }),
  );

  // final responseque = await http.patch(
  //   Uri.parse('http://localhost:3000/answers/$id'),
  //   headers: <String, String>{
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   },
  //   body: jsonEncode(<String, dynamic>{
  //     'isSelected': isSelected,
  //   }),
  // );

  log('log is ${response.statusCode}');
  if (response.statusCode == 200) {
    return checkAnswer.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(Error);
  }
}

// For Score page
Future<int> fetchCorrectAnswers() async {
  final response = await http.get(
    Uri.parse('http://localhost:3000/answers'),
  );
  var count = 0;

  // print(response.body);
  final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
  for (var item in parsed) {
    if (item['isCorrect'] == true) {
      count++;
    }
  }

  return count;
}

// For unanswered
Future<int> fetchSelectedQuestion() async {
  final response = await http.get(
    Uri.parse('http://localhost:3000/answers'),
  );
  var count = 0;

  // print(response.body);
  final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
  for (var item in parsed) {
    if (item['isSelected'] == true) {
      count++;
    }
  }

  return count;
}

// To update profile to Api
Future<Users> updateJprofile({
  required String id,
}) async {
  final response = await http.patch(
    Uri.parse('http://localhost:3000/Users/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'firstName': controller.firstName.value,
      'lastName': controller.lastName.value,
      'password': controller.password.value,
      'gender': controller.gender.value ? 'Male' : 'Female',
    }),
  );
  if (response.statusCode == 200) {
    return Users.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(Error);
  }
}

// Delete answers
Future deleteSavedAnswers(int optionLength) async {
  for (var i = 1; i < optionLength + 1; i++) {
    final response = await http.patch(
      Uri.parse('http://localhost:3000/answers/$i'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, bool>{
        'isCorrect': false,
        "isSelected": false,
      }),
    );
    print('patch response');

    Get.delete<QuestionControl>();
  }
}

// Logout
logOut() {
  Get.delete<ProfileController>();
  Get.delete<QuestionControl>();
}



//! hot fixes

//? issue with deleting saved answers
//? the system was saving practice scores
//? review answers shows up on evaluation screen
