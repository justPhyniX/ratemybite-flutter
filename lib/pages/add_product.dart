import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ratemybite/Models/DTOs/ProductPostDto.dart';
import 'package:ratemybite/data_service.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddProduct extends StatefulWidget {

  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final dataService = DataService(); //handles the api calls
  final _addProductFormKey = GlobalKey<FormState>();
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _foodCategoryController = TextEditingController();

  List<String> _ingredients = [];
  List<String> _foodCategories = [];
  List<String> _selectedIngredients = [];
  String? _selectedFoodCategory;
  File? _productImage;

  @override
  void initState() {
    super.initState();
    _fetchIngredients();
    _fetchFoodCategories();
    _fetchFoodCategories();
  }

  Future<void> _fetchIngredients() async {
    final ingredients = await dataService.GetIngredients();
    setState(() {
      _ingredients = ingredients;
    });
  }

  Future<void> _fetchFoodCategories() async {
    final categories = await dataService.GetFoodCategories();
    setState(() {
      _foodCategories = categories;
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _productImage = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    _barcodeController.dispose();
    _productNameController.dispose();
    _brandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        toolbarHeight: 80,
        title: Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text(
            'Add Product',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24
            ),
          ),
        )
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20), //whole page padding
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Form(
                key: _addProductFormKey,
                child: Column(
                  children: [
                    // Add Image
                    FormField<File>(
                      validator: (value) {
                        if (_productImage == null) {
                          return 'Please provide a product image';
                        }
                        return null;
                      },
                      builder: (state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: _pickImage,
                              child: Container(
                                width: double.infinity,
                                height: 230,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                    color: state.hasError
                                      ? Theme.of(context).colorScheme.error
                                      : Colors.white.withAlpha(80),
                                  ),
                                ),
                                child: _productImage == null
                                ? Icon(
                                    Icons.add_a_photo_outlined,
                                    size: 80,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: Image.file(
                                      _productImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                              ),
                            ),
                            if(state.hasError)
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0, top: 5.0),
                              child: Text(
                                state.errorText ?? '',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 20),

                    // Barcode number
                    TextFormField(
                      controller: _barcodeController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if(value == null || value.trim().isEmpty) {
                          return 'Barcode fields is required';
                        }

                        if(!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Only numbers are allowed';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Barcode Number',
                        labelStyle: TextStyle(color: Colors.white.withAlpha(125)),
                        floatingLabelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: Colors.white.withAlpha(80),
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: Colors.white.withAlpha(80),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: Colors.white.withAlpha(80),
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.primaryContainer,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0)
                      ),
                    ),
                    SizedBox(height: 20),

                    // Product name
                    TextFormField(
                      controller: _productNameController,
                      validator: (value) {
                        if(value == null || value.trim().isEmpty) {
                          return 'Product name field is required';
                        }

                        if(!RegExp(r'^[a-zA-Z0-9\- ]+$').hasMatch(value)) {
                          return 'Only letters, numbers, spaces, and dashes are allowed';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Product Name',
                        labelStyle: TextStyle(color: Colors.white.withAlpha(125)),
                        floatingLabelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: Colors.white.withAlpha(80),
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: Colors.white.withAlpha(80),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: Colors.white.withAlpha(80),
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.primaryContainer,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0)
                      ),
                    ),
                    SizedBox(height: 20),

                    // Brand
                    TextFormField(
                      controller: _brandController,
                      validator: (value) {
                        if(value == null || value.trim().isEmpty) {
                          return 'Brand field is required';
                        }

                        if(!RegExp(r'^[a-zA-Z0-9\- ]+$').hasMatch(value)) {
                          return 'Only letters, numbers, spaces, and dashes are allowed';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Brand',
                        labelStyle: TextStyle(color: Colors.white.withAlpha(125)),
                        floatingLabelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: Colors.white.withAlpha(80),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: Colors.white.withAlpha(80),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: Colors.white.withAlpha(80),
                          ),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.primaryContainer,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0)
                      ),
                    ),
                    SizedBox(height: 20),

                    // Food Category Dropdown
                    DropdownButtonFormField<String>(
                      items: _foodCategories
                        .map((category) => DropdownMenuItem<String>(
                             value: category,
                             child: Text(
                               category,
                               style: TextStyle(color: Colors.white),
                             ),
                           ))
                        .toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedFoodCategory = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a food category that best describes your product';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Food Category',
                        labelStyle: TextStyle(color: Colors.white.withAlpha(125)),
                        floatingLabelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: Colors.white.withAlpha(80),
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: Colors.white.withAlpha(80),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: Colors.white.withAlpha(80),
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.primaryContainer,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0)
                      ),
                      dropdownColor: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    SizedBox(height: 20),

                    // Ingredients Dropdown 
                    FormField<List<String>>(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select ingredients';
                        }
                        return null;
                      },
                      builder: (state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MultiSelectDialogField<String>(
                              dialogHeight: 500,
                              items: _ingredients
                                  .map((ingredient) => MultiSelectItem<String>(ingredient, ingredient))
                                  .toList(),
                              title: Text("Select Ingredients"),
                              selectedColor: Theme.of(context).colorScheme.primary,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primaryContainer,
                                borderRadius: BorderRadius.all(Radius.circular(7)),
                                border: Border.all(
                                  color: state.hasError
                                    ? Theme.of(context).colorScheme.error
                                    : Colors.white.withAlpha(80),
                                  width: 1,
                                ),
                              ),
                              buttonIcon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white.withAlpha(125),
                              ),
                              buttonText: Text(
                                "Ingredients",
                                style: TextStyle(
                                  color: Colors.white.withAlpha(125),
                                  fontSize: 16,
                                  height: 2,
                                ),
                              ),
                              searchable: true,
                              listType: MultiSelectListType.LIST,
                              itemsTextStyle: TextStyle(
                                color: Colors.white
                              ),
                              selectedItemsTextStyle: TextStyle(
                                color: Colors.white
                              ),
                              onConfirm: (values) {
                                setState(() {
                                  _selectedIngredients = values;
                                  state.didChange(values);
                                });
                              },
                              chipDisplay: MultiSelectChipDisplay(
                                chipColor: Theme.of(context).colorScheme.primary,
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            if (state.hasError)
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0, top: 5.0),
                              child: Text(
                                state.errorText ?? '',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 80),
                  ],
                ),
              )
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () async {
            if (_addProductFormKey.currentState!.validate()) {
              // Rate the product based on its provided ingredients
              final ingredientScores = dataService.GetIngredientScores(_selectedIngredients);
              
              // Create a ProductPostDto from the user provided data
              final product = ProductPostDto(
                _barcodeController.text.trim(),
                _selectedFoodCategory!,
                _brandController.text.trim(),
                rate(await ingredientScores),
                _productNameController.text.trim(),
                _selectedIngredients
              );


              // TODO: send an actual productPostDto and check for exceptions with try-catch blocks
            }
          },
          child: Text(
            'Submit Product',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
