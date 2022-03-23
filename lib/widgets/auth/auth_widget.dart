import 'package:flutter/material.dart';
import 'package:themoviedb/constants/constants.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu, color: whiteColor),
        ),
        title: const Image(
          image: AssetImage('assets/images/logo.png'),
          fit: BoxFit.fitHeight,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person, color: whiteColor),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: secondaryColor),
          ),
        ],
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

class _FormWidget extends StatefulWidget {
  const _FormWidget({Key? key}) : super(key: key);

  @override
  State<_FormWidget> createState() => __FormWidgetState();
}

class __FormWidgetState extends State<_FormWidget> {
  final _loginTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  void _auth() {
    final login = _loginTextController.text;
    final password = _loginTextController.text;

    if (login == 'admin' && password == 'admin') {
      Navigator.of(context).pushReplacementNamed('/main_screen');
    } else {
      showSnackBar(context, 'error: Invalid email or password');
    }
  }

  void _resetPassword() {}

  @override
  Widget build(BuildContext context) {
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
          controller: _loginTextController,
        ),
        const SizedBox(height: 20),
        AppText(size: 16, text: 'Пароль'),
        const SizedBox(height: 5),
        TextField(
          decoration: textFieldDecorator,
          obscureText: true,
          controller: _passwordTextController,
        ),
        const SizedBox(height: 25),
        Row(
          children: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(secondaryColor),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
              ),
              onPressed: _auth,
              child: AppText(
                isBold: FontWeight.bold,
                size: 16,
                text: 'Войти',
                color: whiteColor,
              ),
            ),
            const SizedBox(width: 25),
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5)),
              ),
              onPressed: _resetPassword,
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
