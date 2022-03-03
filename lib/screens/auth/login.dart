import 'package:ecommerce/consts/colors.dart';
import 'package:ecommerce/provider/auth_provider.dart';
import 'package:ecommerce/screens/auth/forget_password.dart';
import 'package:ecommerce/widgets/custom_toast.dart';
import 'package:ecommerce/widgets/navigation_widget.dart';
import 'package:ecommerce/widgets/text_button.dart';
import 'package:ecommerce/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _focusNode = FocusNode();
  bool _obscureText = true;
  String? _emailAddress;
  String? _password;
  final _formKey = GlobalKey<FormState>();

  void submit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Provider.of<AuthProvider>(context, listen: false)
          .userLogin(
        email: _emailAddress!,
        password: _password!,
      )
          .then((value) {
        Navigator.canPop(context) ? Navigator.pop(context) : null;
      }).catchError((error) {
        customFlushBar(
          context: context,
          message: error.toString(),
          title: 'Error',
          backgroundColor: Colors.red,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.95,
            child: RotatedBox(
              quarterTurns: 2,
              child: WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [
                      ColorsConsts.gradiendFStart,
                      ColorsConsts.gradiendLStart,
                    ],
                    [
                      ColorsConsts.gradiendFEnd,
                      ColorsConsts.gradiendLEnd,
                    ],
                  ],
                  durations: [19440, 10800],
                  heightPercentages: [0.20, 0.24],
                  blur: const MaskFilter.blur(
                    BlurStyle.solid,
                    10,
                  ),
                  gradientBegin: Alignment.bottomLeft,
                  gradientEnd: Alignment.topRight,
                ),
                waveAmplitude: 0,
                size: const Size(
                  double.infinity,
                  double.infinity,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(height: 50),
                    Container(
                      height: 120,
                      width: 120,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.rectangle,
                      ),
                      child: const Image(
                        image: NetworkImage(
                          'https://cdn-icons-png.flaticon.com/512/869/869636.png',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    defaultFormField(
                      key: 'email',
                      labelText: 'Email Address',
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_focusNode),
                      keyboardType: TextInputType.emailAddress,
                      fillColor: Theme.of(context).backgroundColor,
                      onSaved: (value) {
                        _emailAddress = value;
                      },
                      prefixIcon: const Icon(Icons.email),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      key: 'password',
                      labelText: 'Password',
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          return 'Please enter a valid password';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      onEditingComplete: submit,
                      keyboardType: TextInputType.emailAddress,
                      fillColor: Theme.of(context).backgroundColor,
                      onSaved: (value) {
                        _password = value;
                      },
                      obscureText: _obscureText,
                      prefixIcon: const Icon(
                        Icons.lock,
                      ),
                      focusNode: _focusNode,
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: defaultTextButton(
                        text: 'Forget Password',
                        textStyle: const TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                        onPressed: () {
                          navigateTo(
                            context: context,
                            widget: const ForgetPassword(),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(width: 10),
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                side: BorderSide(
                                    color: ColorsConsts.backgroundColor),
                              ),
                            ),
                          ),
                          onPressed: submit,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                FeatherIcons.user,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
