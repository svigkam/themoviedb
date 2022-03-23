import 'package:flutter/material.dart';
import 'package:themoviedb/Libarary/Widgets/Inherited/provider.dart';
import 'package:themoviedb/constants/constants.dart';
import 'package:themoviedb/ui/widgets/auth/auth_model.dart';

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

class _FormWidget extends StatelessWidget {
  const _FormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<AuthModel>(context);
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
          controller: model?.loginTextController,
        ),
        const SizedBox(height: 20),
        AppText(size: 16, text: 'Пароль'),
        const SizedBox(height: 5),
        TextField(
          decoration: textFieldDecorator,
          obscureText: true,
          controller: model?.passwordTextController,
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
    final model = NotifierProvider.watch<AuthModel>(context);
    final onPressed =
        model?.canStartAuth == true ? () => model?.auth(context) : null;
    final child = model?.isAuthProgress == true
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
        child: child);
  }
}
