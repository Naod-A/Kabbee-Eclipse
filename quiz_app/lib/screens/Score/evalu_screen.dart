import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quiz_app/controllers/count_down.dart';
import 'package:quiz_app/controllers/profile_controllers.dart';

import '../../Models/scores.dart';
import '../../api.dart';
import '/routes/router.gr.dart';
import '../../Models/model.dart';
import '../../controllers/count_down.dart';

import '../../widgets/common_components/appbar_evalu.dart';
import '../../controllers/question_controller.dart';
import '/widgets/pallete.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class evaluationScreens extends StatelessWidget {
  evaluationScreens({Key? key, required this.icon, required this.path})
      : super(key: key);
  dynamic icon;
  String path;

  final QuestionControl controller = Get.put(QuestionControl());
  final ProfileController pcontroller = Get.put(ProfileController());
  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var isCorrect = false;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        appBar: evaluAppbar(icon, context),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
          child: Column(
            children: [
              MyTimer(),
              Spacer(),
              Obx(
                () => Text(
                    controller.qnIndex.toString() +
                        '/' +
                        pcontroller.questionApi!.length.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.white)),
              ),
              SizedBox(
                height: 600.0,
                child: PageView.builder(
                    itemCount: pcontroller.questionApi!.length,
                    onPageChanged: (pageNumber) {
                      controller.qnIndex.value = pageNumber + 1;
                    },
                    itemBuilder: (context, snapshot) {
                      var options =
                          pcontroller.questionApi![snapshot]['options'];

                      return Container(
                        padding: const EdgeInsets.fromLTRB(40, 10, 10, 0),
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                          // color: const Color.fromARGB(255, 88, 79, 79),
                          color: Color.fromARGB(176, 34, 34, 34),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Spacer(
                              flex: 1,
                            ),
                            Text(
                              pcontroller.questionApi![snapshot]['question']
                                  .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: Colors.white),
                            ),
                            Spacer(
                              flex: 2,
                            ),
                            Container(
                              height: 400.0,
                              child: ListView.builder(
                                itemCount: 4,
                                itemBuilder: (context, index) => ButtonBar(
                                  alignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Obx(
                                      () => Container(
                                        width: 300,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: controller.groupValue[
                                                          snapshot] ==
                                                      controller.value[snapshot]
                                                          [index]
                                                  ? kblue
                                                  : Color.fromARGB(
                                                      255, 117, 110, 110),
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: RadioListTile<int>(
                                            activeColor: kblue,
                                            title: Row(
                                              children: [
                                                Text(
                                                  options[index].toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(
                                                          color: Colors.white),
                                                ),
                                                Spacer(),
                                              ],
                                            ),
                                            controlAffinity:
                                                ListTileControlAffinity
                                                    .trailing,
                                            groupValue:
                                                controller.groupValue[snapshot],
                                            value: controller.value[snapshot]
                                                [index],
                                            onChanged: (newValue) {
                                              controller.groupValue[snapshot] =
                                                  newValue as int;
                                              if (options[index].toString() ==
                                                  pcontroller
                                                      .questionApi![snapshot]
                                                          ['answer']
                                                      .toString()) {
                                                isCorrect = true;
                                                print('object');
                                              } else {
                                                isCorrect = false;
                                              }
                                              updateJsonTime(
                                                answer: options[index],
                                                id: pcontroller
                                                        .questionApi![snapshot]
                                                    ['id'],
                                                isCorrect: isCorrect,
                                              );

                                              print(pcontroller
                                                      .questionApi![snapshot]
                                                  ['id']);
                                            }),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              Spacer(),
              Obx(
                () => pcontroller.questionApi!.length ==
                        controller.qnIndex.value
                    ? ElevatedButton(
                        onPressed: () async {
                          controller.count = await fetchCorrectAnswers();
                          controller.isEnabled.value = false;
                          CourseScore score = CourseScore(
                              courseName: controller.chosenCourse.value,
                              courseType: controller.chosenCourseType.value,
                              courseScore: controller.count,
                              userId: pcontroller.userInfo.value!.id);
                          saveUserScore(score);
                          context.router.push(FinalScore(
                              outOf: pcontroller.questionApi!.length,
                              score: controller.count));
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(300, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            primary: const Color.fromARGB(255, 255, 165, 0)),
                        child: const Text('Done'))
                    : Container(),
              ),
              // Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}