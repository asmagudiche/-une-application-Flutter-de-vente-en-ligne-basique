// lib/views/admin/product_form_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../../providers/product_provider.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product;
  const ProductFormScreen({super.key, this.product});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl,
      _descCtrl,
      _priceCtrl,
      _imageCtrl,
      _stockCtrl;
  bool _isFeatured = false;
  double _discount = 0.0;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.product?.name ?? '');
    _descCtrl = TextEditingController(text: widget.product?.description ?? '');
    _priceCtrl =
        TextEditingController(text: widget.product?.price.toString() ?? '');
    _imageCtrl = TextEditingController(text: widget.product?.imageUrl ?? '');
    _stockCtrl =
        TextEditingController(text: widget.product?.stock.toString() ?? '999');
    _isFeatured = widget.product?.isFeatured ?? false;
    _discount = widget.product?.discount ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.product == null ? 'Nouveau produit' : 'Modifier produit'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                  controller: _nameCtrl,
                  decoration: const InputDecoration(labelText: 'Nom'),
                  validator: (v) => v!.isEmpty ? 'Requis' : null),
              const SizedBox(height: 16),
              TextFormField(
                  controller: _descCtrl,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3),
              const SizedBox(height: 16),
              TextFormField(
                  controller: _priceCtrl,
                  decoration: const InputDecoration(labelText: 'Prix (€)'),
                  keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              TextFormField(
                  controller: _imageCtrl,
                  decoration: const InputDecoration(labelText: 'URL Image')),
              const SizedBox(height: 16),
              TextFormField(
                  controller: _stockCtrl,
                  decoration: const InputDecoration(labelText: 'Stock'),
                  keyboardType: TextInputType.number),
              const SizedBox(height: 20),
              SwitchListTile(
                  title: const Text('Produit vedette'),
                  value: _isFeatured,
                  onChanged: (v) => setState(() => _isFeatured = v)),
              const SizedBox(height: 20),
              Text('Réduction : ${(_discount * 100).toInt()}%'),
              Slider(
                  value: _discount,
                  min: 0,
                  max: 0.7,
                  divisions: 14,
                  onChanged: (v) => setState(() => _discount = v)),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newProduct = Product(
                      id: widget.product?.id ??
                          DateTime.now().millisecondsSinceEpoch.toString(),
                      name: _nameCtrl.text,
                      description: _descCtrl.text,
                      price: double.parse(_priceCtrl.text),
                      imageUrl: _imageCtrl.text,
                      stock: int.parse(_stockCtrl.text),
                      isFeatured: _isFeatured,
                      discount: _discount > 0 ? _discount : null,
                    );
                    if (widget.product == null) {
                      context.read<ProductProvider>().addProduct(newProduct);
                    } else {
                      context.read<ProductProvider>().updateProduct(newProduct);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.product == null ? 'Ajouter' : 'Sauvegarder'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
