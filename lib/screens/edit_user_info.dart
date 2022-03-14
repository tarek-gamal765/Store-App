import 'package:ecommerce/consts/colors.dart';
import 'package:ecommerce/provider/auth_provider.dart';
import 'package:ecommerce/widgets/custom_toast.dart';
import 'package:ecommerce/widgets/deafult_button.dart';
import 'package:ecommerce/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditUserInfo extends StatefulWidget {
  const EditUserInfo({Key? key}) : super(key: key);

  @override
  State<EditUserInfo> createState() => _EditUserInfoState();
}

class _EditUserInfoState extends State<EditUserInfo> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();

  Future<void> submit() async {
    final AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    authProvider
        .updateUser(
      name: nameController.text,
      phone: phoneController.text,
      email: emailController.text,
      password: passwordController.text,
    )
        .then((value) {
      authProvider.getUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    nameController.text = authProvider.userModel!.name!;
    emailController.text = authProvider.userModel!.email!;
    phoneController.text = authProvider.userModel!.phone!;
    passwordController.text = authProvider.userModel!.password!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit',
          style: TextStyle(
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Column(
          children: [
            defaultFormField(
                key: 'edit name',
                controller: nameController,
                hintText: 'Name',
                textInputAction: TextInputAction.next,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(phoneFocusNode),
                keyboardType: TextInputType.text,
                fillColor: Theme.of(context).backgroundColor,
                prefixIcon: const Icon(
                  Icons.person,
                ),
                onSaved: (value) {
                  nameController.text = value!;
                }),
            const SizedBox(
              height: 15,
            ),
            defaultFormField(
              key: 'edit phone',
              controller: phoneController,
              hintText: 'Phone',
              textInputAction: TextInputAction.next,
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(emailFocusNode),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.phone,
              fillColor: Theme.of(context).backgroundColor,
              prefixIcon: const Icon(
                Icons.phone,
              ),
              focusNode: phoneFocusNode,
            ),
            const SizedBox(
              height: 15,
            ),
            defaultFormField(
              key: 'edit email',
              controller: emailController,
              hintText: 'Email Address',
              textInputAction: TextInputAction.next,
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(passwordFocusNode),
              focusNode: emailFocusNode,
              keyboardType: TextInputType.emailAddress,
              fillColor: Theme.of(context).backgroundColor,
              prefixIcon: const Icon(Icons.email),
            ),
            const SizedBox(
              height: 15,
            ),
            defaultFormField(
              key: 'edit password',
              controller: passwordController,
              hintText: 'Password',
              textInputAction: TextInputAction.next,
              onEditingComplete: submit,
              keyboardType: TextInputType.emailAddress,
              fillColor: Theme.of(context).backgroundColor,
              prefixIcon: const Icon(Icons.lock),
              focusNode: passwordFocusNode,
            ),
            const SizedBox(
              height: 20,
            ),
            defaultButton(
              color: ColorsConsts.gradiendLStart,
              text: 'Edit',
              height: 40,
              borderRadius: 5,
              width: double.infinity,
              textStyle: TextStyle(
                color: Theme.of(context).textSelectionTheme.selectionColor,
                fontSize: 16,
              ),
              onPressed: submit,
            ),
          ],
        ),
      ),
    );
  }
}
