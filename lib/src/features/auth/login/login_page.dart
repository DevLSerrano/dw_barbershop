import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/constants/constants_colors.dart';
import '../../../core/ui/constants/constants_image.dart';
import '../../../core/ui/helpers/form_helper.dart';
import '../../../core/ui/helpers/messages.dart';
import 'login_state.dart';
import 'login_vm.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController(text: 'rodrigorahman1@gmail.com');
  final passwordEC = TextEditingController(text: '123123');

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginVm(:login) = ref.watch(loginVmProvider.notifier);
    ref.listen(
      loginVmProvider,
      (previousState, nextState) {
        switch (nextState) {
          case LoginState(status: LoginStateStatus.initial):
            break;
          case LoginState(status: LoginStateStatus.error, :final errorMessage?):
            Messages.showError(errorMessage, context);
          case LoginState(status: LoginStateStatus.error):
            Messages.showError('Erro ao realizar login', context);
          case LoginState(status: LoginStateStatus.admLogin):
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/home/adm', (route) => false);
          case LoginState(status: LoginStateStatus.employeeLogin):
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/home/employee', (route) => false);
        }
      },
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: formKey,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                ConstantsImage.backgroundChair,
              ),
              opacity: .2,
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ConstantsImage.imageLogo,
                            width: 100,
                            height: 120,
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            onTapOutside: (event) => context.unFocus(),
                            validator: Validatorless.multiple([
                              Validatorless.required('Email obrigatório'),
                              Validatorless.email('Email inválido'),
                            ]),
                            controller: emailEC,
                            decoration: const InputDecoration(
                              label: Text('Email'),
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                color: Colors.black,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            validator: Validatorless.multiple([
                              Validatorless.required('Password obrigatório'),
                              Validatorless.min(6, 'Mínimo 6 caracteres'),
                            ]),
                            controller: passwordEC,
                            obscureText: true,
                            decoration: const InputDecoration(
                              label: Text('Password'),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: Colors.black,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Esqueceu a senha?',
                              style: TextStyle(
                                fontSize: 12,
                                color: ConstantsColors.brow,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              switch (formKey.currentState?.validate()) {
                                case (false || null):
                                  Messages.showError(
                                    'Campos inválidos',
                                    context,
                                  );
                                case true:
                                  login(
                                    email: emailEC.text,
                                    password: passwordEC.text,
                                  );
                              }
                            },
                            child: const Text('Acessar'),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: () => Navigator.of(context).pushNamed(
                            '/auth/register/user',
                          ),
                          child: const Text(
                            'Criar conta',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
