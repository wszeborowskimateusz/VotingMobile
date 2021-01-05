import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:votingmobile/common/config/config.dart';
import 'package:votingmobile/common/loader/screen_loader.dart';
import 'package:votingmobile/common/locator/locator.dart';
import 'package:votingmobile/common/navigation/common_navigator.dart';
import 'package:votingmobile/common/ui/common_gradient_button.dart';
import 'package:votingmobile/common/ui/common_layout.dart';
import 'package:votingmobile/localization/translations.dart';
import 'package:votingmobile/login/backend/user_repository.dart';
import 'package:votingmobile/voting/backend/votings_repository.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ScreenLoader {
  final UserRepository _userRepository = locator.get();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginStatus _loginStatus = LoginStatus.successful;

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
      displayLeftBackIcon: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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
                        padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                        child: Text(translations.loginDisclaimer,
                            textAlign: TextAlign.center),
                      ),
                      _InputForm(
                        loginController: _loginController,
                        passwordController: _passwordController,
                        loginStatus: _loginStatus,
                        onInputChange: () => setState(() {
                          _loginStatus = LoginStatus.successful;
                        }),
                        onSubmit: () => _onLogin(context),
                        bottomSection: _loginStatus != LoginStatus.successful
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8.0, top: 16.0),
                                child: Text(
                                  _getLoginErrorInfo(translations),
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle2
                                      .copyWith(
                                        color: Colors.red,
                                      ),
                                ),
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
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

  String _getLoginErrorInfo(Translations translations) {
    switch (_loginStatus) {
      case LoginStatus.wrongUsernameOrPassword:
        return translations.loginIncorrectUsernameOrPassword;
      case LoginStatus.noSession:
        return translations.loginIncorrectNoSession;
      case LoginStatus.userBlocked:
        return translations.loginIncorrectUserBlocked;
      default:
        return "";
    }
  }

  void _onLogin(BuildContext context) async {
    final String login = _loginController.text;
    final String password = _passwordController.text;

    final loginStatus =
        await performFuture(() => _userRepository.login(login, password));
    if (loginStatus == LoginStatus.successful) {
      navigateToHomePage(context);
      await Provider.of<ActiveVoting>(context, listen: false)
          .updateActiveVoting();
    } else {
      setState(() {
        _loginStatus = loginStatus;
      });
    }
  }
}

class _InputForm extends StatefulWidget {
  final LoginStatus loginStatus;
  final VoidCallback onInputChange;
  final VoidCallback onSubmit;
  final TextEditingController loginController;
  final TextEditingController passwordController;
  final Widget bottomSection;

  const _InputForm({
    @required this.loginStatus,
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
                style: widget.loginStatus == LoginStatus.successful
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
              style: widget.loginStatus == LoginStatus.successful
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
