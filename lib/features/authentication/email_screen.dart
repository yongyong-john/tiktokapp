import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokapp/constants/gaps.dart';
import 'package:tiktokapp/constants/sizes.dart';
import 'package:tiktokapp/features/authentication/password_screen.dart';
import 'package:tiktokapp/features/authentication/view_models/signup_view_model.dart';
import 'package:tiktokapp/features/authentication/widgets/form_button.dart';

class EmailScreenArgs {
  final String username;

  EmailScreenArgs({required this.username});
}

class EmailScreen extends ConsumerStatefulWidget {
  final String username;

  const EmailScreen({
    super.key,
    required this.username,
  });

  @override
  ConsumerState<EmailScreen> createState() => EmailScreenState();
}

class EmailScreenState extends ConsumerState<EmailScreen> {
  final TextEditingController _emailController = TextEditingController();

  String _email = '';

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _isEmailValid() {
    if (_email.isEmpty) {
      return null;
    }

    // final regExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(_email)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmitTap() {
    if (_email.isEmpty || _isEmailValid() != null) return;
    ref.read(signupForm.notifier).state = {"email": _email};
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PasswordScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Sign up',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              Text(
                "What is your email ${widget.username}?",
                style: const TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v8,
              const Text(
                'You can always change this later.',
                style: TextStyle(
                  fontSize: Sizes.size16,
                  color: Colors.black54,
                ),
              ),
              Gaps.v16,
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                onEditingComplete: _onSubmitTap,
                decoration: InputDecoration(
                  hintText: 'Email',
                  errorText: _isEmailValid(),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
              Gaps.v16,
              GestureDetector(
                onTap: _onSubmitTap,
                child: FormButton(disabled: _email.isEmpty || _isEmailValid() != null),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
