import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/constants/constants.dart';
import 'package:themoviedb/ui/widgets/auth/auth_model.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(size: 30, text: 'Авторизация'),
        backgroundColor: lightPrimary,
        elevation: 0,
      ),
      backgroundColor: lightPrimary,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                _AuthThroughWidget(),
                SizedBox(height: 70),
                _FormWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AuthThroughWidget extends StatelessWidget {
  const _AuthThroughWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(size: 18, text: 'Войти с помощью'),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xff464140),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(Icons.error_outline, color: white),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xff464140),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(Icons.error_outline, color: white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _FormWidget extends StatelessWidget {
  const _FormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppText(size: 22, text: 'Войти с помощью логина', color: primaryText),
        const SizedBox(height: 25),
        TextField(
          style: const TextStyle(color: primaryText),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            hintStyle: const TextStyle(color: secondaryText),
            hintText: 'Login',
            prefixIcon: Icon(
              Icons.person,
              color: white.withOpacity(.8),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          controller: model.loginTextController,
        ),
        const SizedBox(height: 10),
        TextField(
          style: const TextStyle(color: primaryText),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            hintText: 'Password',
            hintStyle: const TextStyle(color: secondaryText),
            prefixIcon: Icon(Icons.lock, color: white.withOpacity(.8)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          obscureText: true,
          controller: model.passwordTextController,
        ),
        const SizedBox(height: 20),
        const _AuthButtonWidget(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AppText(
              size: 16,
              text: 'Еще нет аккаунта?',
              color: white.withOpacity(.8),
            ),
            TextButton(
              onPressed: () async {
                const url = "https://www.themoviedb.org/signup";
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  // can't launch url
                }
              },
              child: AppText(
                isBold: FontWeight.bold,
                color: const Color(0xff317cc0),
                size: 16,
                text: 'Зарегистрироваться',
              ),
            ),
          ],
        )
      ],
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AuthModel>();
    final onPressed = model.canStartAuth ? () => model.auth(context) : null;
    final btnBackground = model.isAuthProgress
        ? MaterialStateProperty.all(btnsColor.withOpacity(.5))
        : MaterialStateProperty.all(btnsColor);
    final child = model.isAuthProgress
        ? const SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(
              color: white,
              strokeWidth: 2,
            ),
          )
        : AppText(
            isBold: FontWeight.bold,
            size: 16,
            text: 'Войти',
            color: white,
          );
    return SizedBox(
      width: double.maxFinite,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          backgroundColor: btnBackground,
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 15)),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
