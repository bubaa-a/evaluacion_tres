import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/product_form_provider.dart';
import 'package:flutter_application_1/services/product_service.dart';

import 'package:provider/provider.dart';

import '../ui/input_decorations.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.SelectProduct!),
      child: _ProductScreenBody(
        productService: productService,
      ),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductService productService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Producto',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 154, 0, 243),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _ProductImageSection(productService: productService),
            const SizedBox(height: 20),
            _ProductForm(),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () async {
                if (!productForm.isValidForm()) return;
                await productService.deleteProduct(
                    productForm.product, context);
              },
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              child: const Icon(Icons.delete_forever),
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              onPressed: () async {
                if (!productForm.isValidForm()) return;
                await productService.editOrCreateProduct(productForm.product);
              },
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              child: const Icon(Icons.save_alt_outlined),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductImageSection extends StatelessWidget {
  const _ProductImageSection({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductService productService;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 150,
          width: 150,
          color: Colors.grey.shade200,
          child: productService.SelectProduct!.productImage != ''
              ? Image.network(
                  productService.SelectProduct!.productImage,
                  fit: BoxFit.cover,
                )
              : Icon(
                  Icons.image,
                  size: 100,
                  color: Colors.grey.shade500,
                ),
        ),
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: product.productName,
                onChanged: (value) => product.productName = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre es obligatorio';
                  }
                  return null;
                },
                decoration: InputDecortions.authInputDecoration(
                  hinText: 'Nombre del producto',
                  labelText: 'Nombre',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                initialValue: product.productPrice.toString(),
                onChanged: (value) {
                  if (int.tryParse(value) == null) {
                    product.productPrice = 0;
                  } else {
                    product.productPrice = int.parse(value);
                  }
                },
                decoration: InputDecortions.authInputDecoration(
                  hinText: 'Precio del producto',
                  labelText: 'Precio',
                ),
              ),
              const SizedBox(height: 20),
              SwitchListTile.adaptive(
                value: true,
                onChanged: (value) {},
                activeColor: Colors.purple.shade700,
                title: const Text('Disponible'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
