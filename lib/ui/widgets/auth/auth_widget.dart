import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/constants/constants.dart';
import 'package:themoviedb/ui/widgets/auth/auth_model.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Image(
          image: AssetImage('assets/images/logo.png'),
          fit: BoxFit.fitHeight,
          width: 200,
        ),
        centerTitle: true,
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: _HeaderWidget(),
        ),
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25),
          AppText(
              size: 20,
              text: 'Войти в свою учётную запись',
              color: primaryColor),
          const SizedBox(height: 12),
          AppText(
              size: 16,
              text:
                  'Чтобы пользоваться правкой и возможностями рейтинга TMDB, а также получить персональные рекомендации, необходимо войти в свою учётную запись. Если у вас нет учётной записи, её регистрация является бесплатной и простой.'),
          const SizedBox(height: 6),
          AppText(
            size: 16,
            text: 'Нажмите здесь, чтобы начать.',
            color: secondaryColor,
          ),
          const SizedBox(height: 25),
          const _FormWidget()
        ],
      ),
    );
  }
}

class _FormWidget extends StatelessWidget {
  const _FormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthModel>();
    const textFieldDecorator = InputDecoration(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(size: 16, text: 'Имя пользователя'),
        const SizedBox(height: 5),
        TextField(
          decoration: textFieldDecorator,
          controller: model.loginTextController,
        ),
        const SizedBox(height: 20),
        AppText(size: 16, text: 'Пароль'),
        const SizedBox(height: 5),
        TextField(
          decoration: textFieldDecorator,
          obscureText: true,
          controller: model.passwordTextController,
        ),
        const SizedBox(height: 25),
        Row(
          children: [
            const _AuthButtonWidget(),
            const SizedBox(width: 25),
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5)),
              ),
              onPressed: () {},
              child: AppText(
                isBold: FontWeight.w400,
                size: 16,
                text: 'Забыл пароль?',
                color: secondaryColor,
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
    final child = model.isAuthProgress
        ? const SizedBox(
            height: 16,
            width: 16,
            child: CircularProgressIndicator(
              color: whiteColor,
              strokeWidth: 2,
            ),
          )
        : AppText(
            isBold: FontWeight.bold,
            size: 16,
            text: 'Войти',
            color: whiteColor,
          );
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(secondaryColor),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
