import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/ui/Screens/Auth/Controllers/users.dart';
import 'package:quiz_app/ui/Screens/CommonControllers/profile_controllers.dart';
import 'package:quiz_app/ui/Screens/Profile/widgets/user_profile_widget.dart';

import '../../utils/pallete.dart';

class EditProfileScreen extends GetView<ProfileController> {
  EditProfileScreen({Key? key}) : super(key: key);

  GlobalKey<FormFieldState> pkey = GlobalKey<FormFieldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Edit Profile'),
          centerTitle: false,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const SizedBox(height: 20),
              customText('First Name', 18, false, false, kblue),
              const SizedBox(height: 15),
              Obx(
                () => buildTextField(controller.firstName.value, Icons.person,
                    controller.firstNameController.value, false, null),
              ),
              const SizedBox(height: 20),
              customText('Last Name', 18, false, false, kblue),
              const SizedBox(height: 15),
              Obx(
                () => buildTextField(controller.lastName.value, Icons.person,
                    controller.lastNameController.value, false, null),
              ),
              const SizedBox(height: 20),
              customText('Password', 18, false, false, kblue),
              const SizedBox(height: 15),
              Obx(
                () => buildTextFieldP(
                    'Enter new password ',
                    Icons.lock,
                    controller.passwordController.value,
                    true,
                    passwordVisibilityBtn(),
                    pkey),
              ),
              const SizedBox(height: 20),
              Obx(() => buildTile(
                    controller.gender.value ? Icons.male : Icons.female,
                    customText('Gender', 18, true, false, primaryColor),
                    null,
                    genderToggle(2),
                    false,
                  )),
              const SizedBox(height: 20),
              editProfilePic(context),
              const SizedBox(height: 40),
              Obx(
                () => buildUpdateButton(context, 'UPDATE', pkey),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
