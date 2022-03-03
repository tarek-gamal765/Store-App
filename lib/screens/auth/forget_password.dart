import 'package:ecommerce/provider/auth_provider.dart';
import 'package:ecommerce/widgets/custom_toast.dart';
import 'package:ecommerce/widgets/deafult_button.dart';
import 'package:ecommerce/widgets/text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> submit() async {
    try {
      FocusScope.of(context).unfocus();
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        await Provider.of<AuthProvider>(context, listen: false)
            .resetPassword(email: emailController.text.trim())
            .then(
          (value) {
            emailController.clear();
            customFlushBar(
              context: context,
              message: 'email sent successfully',
              title: 'Success',
              backgroundColor: Colors.deepPurple,
            );
          },
        );
      }
    } on FirebaseException catch (error) {
      customFlushBar(
        context: context,
        message: error.message!,
        title: 'Error',
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Text(
                'Forget Password',
                style: TextStyle(
                  fontSize: 26,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: defaultFormField(
                  key: 'email',
                  controller: emailController,
                  labelText: 'Email Address',
                  validator: (value) {
                    if (value!.trim().isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => submit(),
                  keyboardType: TextInputType.emailAddress,
                  fillColor: Theme.of(context).backgroundColor,
                  onSaved: (value) {
                    emailController.text = value!;
                  },
                  prefixIcon: const Icon(Icons.email),
                ),
              ),
              defaultButton(
                width: double.infinity,
                height: 40,
                color: Colors.deepPurple,
                text: 'Reset Password',
                onPressed: submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
