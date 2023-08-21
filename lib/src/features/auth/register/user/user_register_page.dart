import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/ui/helpers/form_helper.dart';
import '../../../../core/ui/helpers/messages.dart';
import 'user_register_vm.dart';

class UserRegisterPage extends ConsumerStatefulWidget {
  const UserRegisterPage({super.key});

  @override
  ConsumerState<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends ConsumerState<UserRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController(text: 'Leonardo Serrano');
  final emailEC = TextEditingController(text: 'leonardo@gmail.com');
  final passwordEC = TextEditingController(text: '123123');

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userRegisterVM = ref.watch(userRegisterVmProvider.notifier);
    ref.listen(
      userRegisterVmProvider,
      (previousState, nextState) {
        switch (nextState) {
          case UserRegisterStateStatus.initial:
            break;
          case UserRegisterStateStatus.success:
            Navigator.of(context).pushNamed('/auth/register/barbershop');
          case UserRegisterStateStatus.error:
            Messages.showError('Error ao registar utilizardor ADM!', context);
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onTapOutside: (_) => context.unFocus(),
                  controller: nameEC,
                  validator: Validatorless.required('Nome é obrigatório'),
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: emailEC,
                  onTapOutside: (_) => context.unFocus(),
                  validator: Validatorless.multiple([
                    Validatorless.required('E-mail é obrigatório'),
                    Validatorless.email('E-mail inválido'),
                  ]),
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: passwordEC,
                  onTapOutside: (_) => context.unFocus(),
                  obscureText: true,
                  validator: Validatorless.multiple([
                    Validatorless.required('Senha é obrigatória'),
                    Validatorless.min(
                      6,
                      'Senha deve ter no mínimo 6 caracteres',
                    ),
                  ]),
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  obscureText: true,
                  onTapOutside: (_) => context.unFocus(),
                  validator: Validatorless.multiple([
                    Validatorless.required('Confirmar Senha é obrigatória'),
                    Validatorless.compare(passwordEC, 'Senhas não conferem'),
                  ]),
                  decoration: const InputDecoration(
                    labelText: 'Confirmar Senha',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  onPressed: () {
                    switch (formKey.currentState?.validate()) {
                      case null || false:
                        Messages.showError('Formulario inválido.', context);
                      case true:
                        userRegisterVM.register(
                          name: nameEC.text,
                          email: emailEC.text,
                          password: passwordEC.text,
                        );
                    }
                  },
                  child: const Text('Criar Conta'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
