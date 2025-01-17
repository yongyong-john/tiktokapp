import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktokapp/constants/gaps.dart';
import 'package:tiktokapp/constants/sizes.dart';
import 'package:tiktokapp/features/authentication/widgets/form_button.dart';
import 'package:tiktokapp/features/onboarding/interests_screen.dart';

class LoginFormScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginFormScreen({super.key});

  final Map<String, String> _formMap = <String, String>{};

  void _onSubmitTap(BuildContext context) {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        context.goNamed(InterestsScreen.routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          Sizes.size36,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: 'Email'),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Please write your email.";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  if (newValue != null) {
                    _formMap['email'] = newValue;
                  }
                },
              ),
              Gaps.v16,
              TextFormField(
                decoration: const InputDecoration(hintText: 'Password'),
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Please write your password.";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  if (newValue != null) {
                    _formMap['password'] = newValue;
                  }
                },
              ),
              Gaps.v28,
              GestureDetector(
                onTap: () => _onSubmitTap(context),
                child: const FormButton(disabled: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
