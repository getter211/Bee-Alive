import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final bool isLogin;
  final Function(String email, String password, String? name) onSubmit;

  const AuthForm({Key? key, required this.isLogin, required this.onSubmit})
      : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String? _name;

  void _trySubmit() {
    final isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      _formKey.currentState?.save();
      widget.onSubmit(_email, _password, _name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          if (!widget.isLogin)
            TextFormField(
              key: ValueKey('name'),
              decoration: InputDecoration(labelText: 'Nombre'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa tu nombre';
                }
                return null;
              },
              onSaved: (value) {
                _name = value!;
              },
            ),
          TextFormField(
            key: ValueKey('email'),
            decoration: InputDecoration(labelText: 'Correo electrónico'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || !value.contains('@')) {
                return 'Por favor ingresa un correo válido';
              }
              return null;
            },
            onSaved: (value) {
              _email = value!;
            },
          ),
          TextFormField(
            key: ValueKey('password'),
            decoration: InputDecoration(labelText: 'Contraseña'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.length < 6) {
                return 'La contraseña debe tener al menos 6 caracteres';
              }
              return null;
            },
            onSaved: (value) {
              _password = value!;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _trySubmit,
            child: Text(widget.isLogin ? 'Login' : 'Register'),
          ),
        ],
      ),
    );
  }
}
