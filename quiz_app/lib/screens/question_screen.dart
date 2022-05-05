import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '/routes/router.gr.dart';
import '../Models/model.dart';
import '../controllers/profile_controllers.dart';

import '/widgets/rounded_button.dart';
import '../widgets/common_components/appbar.dart';
import '../controllers/question_controller.dart';
import '/widgets/pallete.dart';

class QuestionScreen extends StatelessWidget {
  QuestionScreen({Key? key, required this.icon}) : super(key: key);
  dynamic icon;

  final QuestionControl controller = Get.put(QuestionControl());

  @override
  Widget build(BuildContext context) {
    var isCorrect = false;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        appBar: QuizeAppbar(icon, context),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(5, 15, 5, 10),
          child: Column(
            children: [
              Obx(
                () => Text(
                    controller.qnIndex.toString() +
                        '/' +
                        controller.questions.length.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.white)),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 600.0,
                child: PageView.builder(
                    itemCount: controller.questions.length,
                    onPageChanged: (pageNumber) {
                      controller.qnIndex.value = pageNumber + 1;
                    },
                    itemBuilder: (context, snapshot) {
                      var options = controller.questions[snapshot]['options'];

                      return Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 88, 79, 79),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Spacer(
                              flex: 1,
                            ),
                            Text(
                              controller.questions[snapshot]['question']
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
                                                  controller.questions[snapshot]
                                                          ['answer']
                                                      .toString()) {
                                                isCorrect = true;
                                                print('object');
                                              } else {
                                                isCorrect = false;
                                              }
                                              updateJsonTime(
                                                answer: options[index],
                                                id: controller
                                                    .questions[snapshot]['id'],
                                                isCorrect: isCorrect,
                                              );
                                              print(options[index]);
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
                () => controller.questions.length == controller.qnIndex.value
                    ? ElevatedButton(
                        onPressed: () async {
                          controller.count = await fetchCorrectAnswers();

                          context.router.push(FinalScore(
                              outOf: controller.questions.length,
                              score: controller.count));
                        },
                        child: Text('Done'))
                    // ? const RoundedButton(
                    //     buttonName: 'Done',
                    //     page: '/finalScore',
                    //   )
                    : Container(),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}