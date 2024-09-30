import 'package:flutter/material.dart';

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicativo CRUD',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TelaFormulario(),
    );
  }
}

// Tela do formulário
class TelaFormulario extends StatefulWidget {
  @override
  _TelaFormularioState createState() => _TelaFormularioState();
}

class _TelaFormularioState extends State<TelaFormulario> {
  final _formKey = GlobalKey<FormState>();
  final _controladorItem = TextEditingController();
  List<String> _itens = [];

  void _adicionarItem() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _itens.add(_controladorItem.text);
        _controladorItem.clear();
      });
    }
  }

  void _navegarParaLista() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaLista(itens: _itens),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Item')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _controladorItem,
                decoration: InputDecoration(labelText: 'Item'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um item';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _adicionarItem,
                child: Text('Adicionar'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _navegarParaLista,
                child: Text('Ver Lista'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Tela da lista
class TelaLista extends StatelessWidget {
  final List<String> itens;

  TelaLista({required this.itens});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Itens')),
      body: ListView.builder(
        itemCount: itens.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(itens[index]),
          );
        },
      ),
    );
  }
}
