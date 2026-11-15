import 'package:flutter/material.dart';
import 'package:untitled1/src/features/shopping_list/viewmodels/listas_compras.dart';
import 'package:untitled1/src/features/shopping_list/models/ListaCompras.dart';      // Aponta para o Model na pasta models (ajuste o nome do arquivo se estiver com maiúscula)

class shopping_list_view extends StatefulWidget {
  final Listas_Compras viewModel;

  const shopping_list_view({super.key, required this.viewModel});

  @override
  State<shopping_list_view> createState() => _shopping_list_viewState();
}

class _shopping_list_viewState extends State<shopping_list_view> {
  void _mostrarModalAdicionarItem() {
    final nomeController = TextEditingController();
    final qtdController = TextEditingController();
    final unidadeController = TextEditingController(text: 'un');
    String setorSelecionado = 'Mercearia';

    final setores = ['Hortifruti', 'Açougue', 'Laticínios', 'Mercearia', 'Limpeza', 'Padaria'];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Adicionar Item Avulso', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  TextField(controller: nomeController, decoration: const InputDecoration(labelText: 'Nome do produto', border: OutlineInputBorder())),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(flex: 2, child: TextField(controller: qtdController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Qtd', border: OutlineInputBorder()))),
                      const SizedBox(width: 12),
                      Expanded(flex: 1, child: TextField(controller: unidadeController, decoration: const InputDecoration(labelText: 'Unidade', border: OutlineInputBorder()))),
                    ],
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: setorSelecionado,
                    decoration: const InputDecoration(labelText: 'Setor do Mercado', border: OutlineInputBorder()),
                    items: setores.map((setor) => DropdownMenuItem(value: setor, child: Text(setor))).toList(),
                    onChanged: (valor) {
                      if (valor != null) setModalState(() => setorSelecionado = valor);
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final nome = nomeController.text;
                      final qtd = double.tryParse(qtdController.text.replaceAll(',', '.')) ?? 1.0;
                      if (nome.trim().isNotEmpty) {
                        widget.viewModel.adicionarItemAvulso(
                          nome: nome,
                          quantidade: qtd,
                          unidade: unidadeController.text,
                          setorMercado: setorSelecionado,
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Adicionar à Lista'),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Compras')),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, child) {
          final itens = widget.viewModel.itens;

          if (itens.isEmpty) {
            return const Center(
              child: Text(
                'Sua lista está vazia.\nGere pelo cardápio ou adicione itens no botão +',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: itens.length,
            itemBuilder: (context, index) {
              final ListaCompras item = itens[index];

              return Dismissible(
                key: Key(item.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) => widget.viewModel.removerItem(item.id),
                child: CheckboxListTile(
                  value: item.comprado,
                  onChanged: (_) => widget.viewModel.alternarStatusComprado(item.id),
                  title: Text(
                    item.nome,
                    style: TextStyle(
                      decoration: item.comprado ? TextDecoration.lineThrough : null,
                      color: item.comprado ? Colors.grey : null,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text('${item.quantidade} ${item.unidade} • ${item.setorMercado}'),                  secondary: item.isAvulso ? const Chip(label: Text('Avulso', style: TextStyle(fontSize: 10))) : null,
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarModalAdicionarItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}