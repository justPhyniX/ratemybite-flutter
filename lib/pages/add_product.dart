import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 350,
                        height: 230,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withAlpha(80),
                            width: 2,
                          ),
                        ),
                        child: _productImage == null
                            ? Icon(
                                Icons.photo_camera,
                                color: Colors.white.withAlpha(180),
                                size: 48,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.file(
                                  _productImage!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Barcode number
                    TextFormField(
                      controller: _barcodeController,
                      decoration: InputDecoration(
                        labelText: 'Barcode Number',
                        labelStyle: TextStyle(color: Colors.white.withAlpha(125)),
                        floatingLabelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Product name
                    TextFormField(
                      controller: _productNameController,
                      decoration: InputDecoration(
                        labelText: 'Product Name',
                        labelStyle: TextStyle(color: Colors.white.withAlpha(125)),
                        floatingLabelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Brand
                    TextFormField(
                      controller: _brandController,
                      decoration: InputDecoration(
                        labelText: 'Brand',
                        labelStyle: TextStyle(color: Colors.white.withAlpha(125)),
                        floatingLabelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Food Category Dropdown
                    DropdownButtonFormField<String>(
                      value: _selectedFoodCategory,
                      items: _foodCategories
                          .map((category) => DropdownMenuItem<String>(
                                value: category,
                                child: Text(
                                  category,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ))
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedFoodCategory = newValue;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Food Category',
                        labelStyle: TextStyle(color: Colors.white.withAlpha(125)),
                        floatingLabelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.primaryContainer,
                      ),
                      dropdownColor: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    SizedBox(height: 20),
                    MultiSelectDialogField<String>(
                      dialogHeight: 530,
                      items: _ingredients
                          .map((ingredient) => MultiSelectItem<String>(ingredient, ingredient))
                          .toList(),
                      title: Text("Select Ingredients"),
                      selectedColor: Theme.of(context).colorScheme.primary,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        border: Border.all(
                          color: Colors.white,
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
                        });
                      },
                      chipDisplay: MultiSelectChipDisplay(
                        chipColor: Theme.of(context).colorScheme.primary,
                        textStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 80), // Add spacing so content isn't hidden behind the button
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
          onPressed: () {
            if (_addProductFormKey.currentState!.validate()) {
              // Process the form data
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
