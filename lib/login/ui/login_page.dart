import 'package:flutter/material.dart';
import 'package:votingmobile/common/config/config.dart';
import 'package:votingmobile/common/loader/screen_loader.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/common/navigation/common_navigator.dart';
import 'package:votingmobile/common/ui/common_gradient_button.dart';
import 'package:votingmobile/common/ui/common_layout.dart';
import 'package:votingmobile/localization/translations.dart';
import 'package:votingmobile/login/backend/user_repository.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ScreenLoader {
  final UserRepository _userRepository = locator.get();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isValidationCorrect = true;

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget screen(BuildContext context) {
    final translations = Translations.of(context);
    return CommonLayout(
      displayLeftIcon: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      translations.login,
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(translations.loginDisclaimer),
                  ),
                  _InputForm(
                    loginController: _loginController,
                    passwordController: _passwordController,
                    isValidationCorrect: _isValidationCorrect,
                    onInputChange: () => setState(() {
                      _isValidationCorrect = true;
                    }),
                    onSubmit: () => _onLogin(context),
                    bottomSection: !_isValidationCorrect
                        ? Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8.0, top: 16.0),
                            child: Text(
                                translations.loginIncorrectUsernameOrPassword),
                          )
                        : null,
                  ),
                ],
              ),
            ),
            Container(
              constraints:
                  BoxConstraints(maxWidth: Config.maxElementInAppWidth),
              alignment: Alignment.center,
              child: CommonGradientButton(
                title: translations.login,
                onPressed: () => _onLogin(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onLogin(BuildContext context) async {
    final String login = _loginController.text;
    final String password = _passwordController.text;

    final isCredentialCorrect =
        await performFuture(() => _userRepository.login(login, password));
    if (isCredentialCorrect) {
      navigateToHomePage(context);
    } else {
      setState(() {
        _isValidationCorrect = false;
      });
    }
  }
}

class _InputForm extends StatefulWidget {
  final bool isValidationCorrect;
  final VoidCallback onInputChange;
  final VoidCallback onSubmit;
  final TextEditingController loginController;
  final TextEditingController passwordController;
  final Widget bottomSection;

  const _InputForm({
    @required this.isValidationCorrect,
    @required this.onInputChange,
    @required this.onSubmit,
    @required this.loginController,
    @required this.passwordController,
    this.bottomSection,
  });
  @override
  __InputFormState createState() => __InputFormState();
}

class __InputFormState extends State<_InputForm> {
  bool _isPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    return Container(
      constraints: BoxConstraints(maxWidth: Config.maxElementInAppWidth - 100),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                style: widget.isValidationCorrect
                    ? null
                    : TextStyle(color: Colors.red),
                autocorrect: false,
                autofocus: true,
                controller: widget.loginController,
                maxLines: 1,
                decoration: InputDecoration(labelText: translations.username),
                textInputAction: TextInputAction.next,
                onChanged: (_) => widget.onInputChange(),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).nextFocus();
                },
              ),
            ),
            TextFormField(
              style: widget.isValidationCorrect
                  ? null
                  : TextStyle(color: Colors.red),
              autocorrect: false,
              autofocus: false,
              controller: widget.passwordController,
              maxLines: 1,
              obscureText: _isPasswordObscured,
              onFieldSubmitted: (_) => widget.onSubmit(),
              onChanged: (_) => widget.onInputChange(),
              decoration: InputDecoration(
                labelText: translations.password,
                suffix: IconButton(
                  icon: Icon(
                    _isPasswordObscured
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordObscured = !_isPasswordObscured;
                    });
                  },
                ),
              ),
            ),
            if (widget.bottomSection != null) widget.bottomSection,
          ],
        ),
      ),
    );
  }
}
