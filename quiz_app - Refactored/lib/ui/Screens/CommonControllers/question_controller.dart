import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionController extends GetxController {
  // To hold
  // List<ChosenModel> chosenAnswers = [];
  // RxBool isCorrect = false.obs;
  // bool isSelected = false;
  List? questionApi;
  RxString chosenCourse = ''.obs;
  RxString chosenCourseType = ''.obs;
  bool isFinal = false;

  Rx<ScrollController> scrolController = ScrollController().obs;
  Rx<ScrollController> reviewScrolController = ScrollController().obs;

  int optionList = 0;

  RxBool isEnabled = true.obs;
  bool isFinished = false;

// Groupping Radio button for each question
  RxList groupValue = [-1, 0, 5, 9, 13, 17, 21, 25, 29, 33, 37].obs;
  RxList value = [
    [0, 1, 2, 4],
    [5, 6, 7, 8],
    [9, 10, 11, 12],
    [13, 14, 15, 16],
    [17, 18, 19, 20],
    [21, 22, 23, 24],
    [25, 26, 27, 28],
    [29, 30, 31, 32],
    [33, 34, 35, 36],
    [37, 38, 39, 40]
  ].obs;
  RxInt qnIndex = 1.obs;
  int count = 0;

  // For Evaluation question Timer
  RxInt hour = 0.obs;
  RxInt minutes = 0.obs;
  RxInt seconds = 25.obs;

  //
  List answers = [];
  // List choices = [];
  List choices = [];
  int scoreCounter = 0;
}
