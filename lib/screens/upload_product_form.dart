import 'package:ecommerce/provider/products_provider.dart';
import 'package:ecommerce/widgets/custom_toast.dart';
import 'package:ecommerce/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UploadProductForm extends StatefulWidget {
  const UploadProductForm({Key? key}) : super(key: key);

  @override
  _UploadProductFormState createState() => _UploadProductFormState();
}

class _UploadProductFormState extends State<UploadProductForm> {
  String? categoryValue;
  String? brandValue;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController brandController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomSheet: Container(
        height: kBottomNavigationBarHeight * 0.8,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: const Border(
            top: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
        ),
        child: TextButton.icon(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (productsProvider.productImage == null) {
                customFlushBar(
                  context: context,
                  message: 'Please, pick a product image',
                  title: '',
                  backgroundColor: Colors.red,
                );
              } else {
                FocusScope.of(context).unfocus();
                productsProvider.uploadProduct(
                  title: titleController.text,
                  price: double.parse(priceController.text),
                  categoryName: categoryController.text,
                  brandName: brandController.text,
                  description: descriptionController.text,
                  quantity: quantityController.text,
                );
              }
            }
          },
          label: Text(
            'Upload',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
          icon: const Icon(
            FeatherIcons.upload,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                right: 10,
                left: 10,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    defaultFormField(
                      key: 'Title',
                      controller: titleController,
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
                      hintText: 'Title',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      onSaved: (value) {
                        titleController.text = value!;
                      },
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: defaultFormField(
                            key: 'Quantity',
                            controller: quantityController,
                            fillColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            hintText: 'Quantity',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the Quantity';
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]'),
                              ),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            keyboardType: TextInputType.number,
                            onSaved: (value) {
                              quantityController.text = value!;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          flex: 1,
                          child: defaultFormField(
                            key: 'Price',
                            controller: priceController,
                            hintText: 'Price \$',
                            fillColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Price is missed';
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]'),
                              ),
                            ],
                            keyboardType: TextInputType.number,
                            onSaved: (value) {
                              priceController.text = value!;
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: productsProvider.productImage == null
                              ? Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10, right: 10),
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                    borderRadius: BorderRadius.circular(4),
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                )
                              : Container(
                                  margin: const EdgeInsets.all(10),
                                  height: 200,
                                  width: 200,
                                  child: Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                    child: Image.file(
                                      productsProvider.productImage!,
                                      fit: BoxFit.contain,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              child: TextButton.icon(
                                onPressed: () =>
                                    productsProvider.getProductImage(
                                  source: ImageSource.camera,
                                ),
                                icon: const Icon(
                                  Icons.camera,
                                  color: Colors.purpleAccent,
                                ),
                                label: Text(
                                  'Camera',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                  ),
                                ),
                              ),
                            ),
                            FittedBox(
                              child: TextButton.icon(
                                onPressed: () =>
                                    productsProvider.getProductImage(
                                  source: ImageSource.gallery,
                                ),
                                icon: const Icon(
                                  Icons.image,
                                  color: Colors.purpleAccent,
                                ),
                                label: Text(
                                  'Gallery',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                  ),
                                ),
                              ),
                            ),
                            FittedBox(
                              child: TextButton.icon(
                                onPressed: () {
                                  productsProvider.productImage = null;
                                },
                                icon: const Icon(
                                  Icons.remove_circle_rounded,
                                  color: Colors.red,
                                ),
                                label: const Text(
                                  'Remove',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: defaultFormField(
                            key: 'Category',
                            controller: categoryController,
                            hintText: 'Category',
                            fillColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please select a category';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            onSaved: (value) {
                              categoryController.text = value!;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        DropdownButton<String>(
                          dropdownColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          items: const [
                            DropdownMenuItem<String>(
                              child: Text('Phones'),
                              value: 'Phones',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Laptops'),
                              value: 'Laptops',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Clothes'),
                              value: 'Clothes',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Beauty & health'),
                              value: 'Beauty',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Shoes'),
                              value: 'Shoes',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Funiture'),
                              value: 'Funiture',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Watches'),
                              value: 'Watches',
                            ),
                          ],
                          hint: const Text(
                            'Select a Category',
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              categoryValue = value;
                              categoryController.text = value!;
                            });
                          },
                          value: categoryValue,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: defaultFormField(
                            key: 'Brand',
                            controller: brandController,
                            hintText: 'Brand',
                            fillColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please select a brand';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            onSaved: (value) {
                              brandController.text = value!;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        DropdownButton<String>(
                          dropdownColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          items: const [
                            DropdownMenuItem<String>(
                              child: Text('Brandless'),
                              value: 'Brandless',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Addidas'),
                              value: 'Addidas',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Apple'),
                              value: 'Apple',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Dell'),
                              value: 'Dell',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('H&M'),
                              value: 'H&M',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Nike'),
                              value: 'Nike',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Samsung'),
                              value: 'Samsung',
                            ),
                            DropdownMenuItem<String>(
                              child: Text('Huawei'),
                              value: 'Huawei',
                            ),
                          ],
                          onChanged: (String? value) {
                            setState(() {
                              brandValue = value;
                              brandController.text = value!;
                              // print(_productBrand);
                            });
                          },
                          hint: const Text('Select a Brand'),
                          value: brandValue,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      key: const ValueKey('Description'),
                      controller: descriptionController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'product description is required';
                        }
                        return null;
                      },
                      maxLines: 10,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        //  counterText: charLength.toString(),
                        hintText: 'Description',

                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) {
                        descriptionController.text = value!;
                      },
                      onChanged: (text) {
                        // setState(() => charLength -= text.length);
                      },
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
