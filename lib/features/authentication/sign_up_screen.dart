import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokapp/constants/gaps.dart';
import 'package:tiktokapp/constants/sizes.dart';
import 'package:tiktokapp/features/authentication/login_screen.dart';
import 'package:tiktokapp/features/authentication/username_screen.dart';
import 'package:tiktokapp/features/authentication/widgets/auth_button.dart';
import 'package:tiktokapp/generated/l10n.dart';
import 'package:tiktokapp/utils.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void _onUsernameTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // NOTE: Device에 설정된 locale을 확인하는 방법
    // print(Localizations.localeOf(context));
    return OrientationBuilder(
      // NOTE: Orientation의 portrait는 세로모드, landscape는 가로모드
      builder: (context, orientation) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
              child: Column(
                children: [
                  Gaps.v80,
                  Text(
                    S.of(context).signUpTitle(
                          "TikTok",
                          DateTime.now(),
                        ),
                    // NOTE: Theme을 사용 중 특별한 하나만 수정하고 싶으면 copywith로 일부만 수정 가능.
                    style: Theme.of(context).textTheme.headlineSmall!, //.copyWith(color: Colors.red),
                  ),
                  Gaps.v20,
                  Opacity(
                    opacity: 0.7,
                    child: Text(
                      S.of(context).signUpSubtitle(0),
                      style: Theme.of(context).textTheme.titleMedium,
                      // style: TextStyle(
                      //   fontSize: Sizes.size16,
                      // NOTE: isDarkMode로 컬러를 변환 할 수 있지만, 회색의 경우 Opacity 설정으로 한 번에 가능
                      // color: isDarkMode(context) ? Colors.grey.shade300 : Colors.black45,
                      // ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Gaps.v40,
                  // NOTE: Collection if를 1개 이상의 Widget에 적용하기 위해 ...[]으로 감싸 사용
                  if (orientation == Orientation.portrait) ...[
                    GestureDetector(
                      onTap: () => _onUsernameTap(context),
                      child: AuthButton(
                        icon: const FaIcon(FontAwesomeIcons.user),
                        text: S.of(context).emailPasswordButton,
                      ),
                    ),
                    Gaps.v16,
                    AuthButton(
                      icon: const FaIcon(FontAwesomeIcons.apple),
                      text: S.of(context).AppleLoginButton,
                    ),
                  ],
                  if (orientation == Orientation.landscape)
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _onUsernameTap(context),
                            child: AuthButton(
                              icon: const FaIcon(FontAwesomeIcons.user),
                              text: S.of(context).emailPasswordButton,
                            ),
                          ),
                        ),
                        Gaps.h16,
                        Expanded(
                          child: AuthButton(
                            icon: const FaIcon(FontAwesomeIcons.apple),
                            text: S.of(context).AppleLoginButton,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            // NOTE: isDarkMode에서 null을 설정하면 MaterialApp의 theme에서 설정한 color 값으로 적용
            color: isDarkMode(context) ? null : Colors.grey.shade50,
            child: Padding(
              padding: const EdgeInsets.only(
                top: Sizes.size32,
                bottom: Sizes.size48,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).alreadyHaveAnAccount),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => _onLoginTap(context),
                    child: Text(
                      S.of(context).logIn("female"),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
