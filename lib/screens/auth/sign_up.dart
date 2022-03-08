
import 'package:ecommerce/consts/colors.dart';
import 'package:ecommerce/provider/auth_provider.dart';
import 'package:ecommerce/widgets/custom_toast.dart';
import 'package:ecommerce/widgets/outlined_button.dart';
import 'package:ecommerce/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static const routeName = '/SignUpScreen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  bool _obscureText = true;
  String? _name;
  String? _phone;
  String? _emailAddress;
  String? _password;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void submit() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    FocusScope.of(context).unfocus();
    if (authProvider.userImage != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        authProvider
            .userRegister(
          name: _name!,
          phone: _phone!,
          email: _emailAddress!,
          password: _password!,
        )
            .then((value) {
          Navigator.canPop(context) ? Navigator.pop(context) : null;
        }).catchError(
          (error) {
            customFlushBar(
              context: context,
              message: error.toString(),
              title: 'Error',
              backgroundColor: Colors.red,
            );
          },
        );
      }
    } else {
      customFlushBar(
        context: context,
        message: 'Please, pick an image',
        title: '',
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
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
                  children: [
                    const SizedBox(height: 50),
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorsConsts.gradiendLEnd,
                          ),
                          child: Container(
                            height: 120,
                            width: 120,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: authProvider.userImage == null
                                ? Image.network(
                                    'https://as1.ftcdn.net/v2/jpg/03/46/83/96/1000_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg',
                                  )
                                : Image.file(
                                    authProvider.userImage!,
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text(
                                    'Choose Option',
                                    style: TextStyle(
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      dialogContent(
                                        context: context,
                                        title: 'Camera',
                                        icon: Icons.camera_alt,
                                        onTap: () {
                                          authProvider.getUserImage(
                                            source: ImageSource.camera,
                                          );
                                          Navigator.pop(context);
                                        },
                                      ),
                                      dialogContent(
                                        context: context,
                                        title: 'Gallery',
                                        icon: Icons.photo,
                                        onTap: () {
                                          authProvider.getUserImage(
                                            source: ImageSource.gallery,
                                          );
                                          Navigator.pop(context);
                                        },
                                      ),
                                      dialogContent(
                                        context: context,
                                        title: 'Remove',
                                        icon: Icons.remove_circle,
                                        onTap: () {
                                          setState(() {
                                            authProvider.userImage = null;
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              child: const Icon(Icons.camera_alt,
                                  color: Colors.white),
                              backgroundColor: ColorsConsts.gradiendLEnd,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    defaultFormField(
                      key: 'name',
                      labelText: 'Name',
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_phoneFocusNode),
                      keyboardType: TextInputType.text,
                      fillColor: Theme.of(context).backgroundColor,
                      onSaved: (value) {
                        _name = value;
                      },
                      prefixIcon: const Icon(
                        Icons.person,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      key: 'phone',
                      labelText: 'Phone',
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Please enter your phone number';
                        }
                        if (value.trim().length != 11) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_emailFocusNode),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.phone,
                      fillColor: Theme.of(context).backgroundColor,
                      onSaved: (value) {
                        _phone = value;
                      },
                      prefixIcon: const Icon(
                        Icons.phone,
                      ),
                      focusNode: _phoneFocusNode,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      key: 'email',
                      labelText: 'Email Address',
                      validator: (value) {
                        if (value!.trim().isEmpty ||
                            !value.trim().contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(_passwordFocusNode),
                      focusNode: _emailFocusNode,
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
                        if (value!.trim().isEmpty || value.trim().length < 7) {
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
                      prefixIcon: const Icon(Icons.lock),
                      focusNode: _passwordFocusNode,
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
                                'Sign Up',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                FeatherIcons.userPlus,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: const [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Divider(
                                    color: Colors.white,
                                    thickness: 2,
                                  ),
                                ),
                              ),
                              Text(
                                'Or continue with',
                                style: TextStyle(color: Colors.black),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Divider(
                                    color: Colors.white,
                                    thickness: 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              defaultOutlinedButton(
                                onPressed: () {},
                                text: 'Google + ',
                                borderColor: Colors.red,
                                textColor: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor!,
                              ),
                              defaultOutlinedButton(
                                onPressed: () {},
                                text: 'Sign in as a guest',
                                borderColor: Colors.deepPurple,
                                textColor: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor!,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget dialogContent({
    required BuildContext context,
    required String title,
    required IconData icon,
    Function()? onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
      ),
      iconColor: Colors.purpleAccent,
      title: Text(
        title,
        style: TextStyle(
          color: ColorsConsts.title,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
