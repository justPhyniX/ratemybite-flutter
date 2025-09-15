import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:ratemybite/Models/DTOs/ProductDto.dart';
import 'package:ratemybite/assets/elements/history_item.dart';
import 'package:ratemybite/data_service.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late final DataService dataService;
  List<ProductDto> products = [];
  Set<int> selectedIndexes = {};

  @override
  void initState() {
    super.initState();
    dataService = DataService();
    // Load products and reverse to show most recent first, limit to 10
    _loadProducts().then((loaded) {
      setState(() {
        products = loaded.reversed.take(10).toList();
      });
    });
  }

  Future<List<ProductDto>> _loadProducts() async {
    final box = Hive.box('HISTORY_BOX');
    return box.values.cast<ProductDto>().toList();
  }

  // Deletes a single product and updates selection state
  void deleteProduct(int index) {
    final box = Hive.box('HISTORY_BOX');
    final finalIndex = products.length - 1 - index;
    box.deleteAt(finalIndex);
    setState(() {
      products.removeAt(index);
      selectedIndexes.remove(index);
    });
  }

  // Deletes all selected products, clearing selection after
  void deleteSelected() {
    final box = Hive.box('HISTORY_BOX');
    final toDelete = selectedIndexes.toList()..sort((a, b) => b.compareTo(a)); // Sort in descending order to avoid index issues
    for(final index in toDelete) {
      final finalIndex = products.length - 1 - index;
      box.deleteAt(finalIndex);
      products.removeAt(index);
    }

    setState(() {
      selectedIndexes.clear();
    });
  }

  // Selects or deselects all items based on the checkbox value
  void toggleSelectAll(bool? value) {
    setState(() {
      if(value == true) {
        selectedIndexes = Set.from(List.generate(products.length, (i) => i));
      } else {
        selectedIndexes.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            'History',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
      ),
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20), // Whole page padding
            child: Column(
              children: [
                Container(
                
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      
                      Expanded(
                        child: SizedBox(
                          child: Row(
                            children: [
                              Checkbox(
                                shape: CircleBorder(),
                                checkColor: const Color.fromARGB(255, 255, 255, 255),
                                value: selectedIndexes.length == products.length && products.isNotEmpty,
                                onChanged: toggleSelectAll
                              ),
                          
                              Text(
                                'Select All',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                                ),
                            ],
                          ),
                        ),
                      ),
                
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            child: IconButton(
                              onPressed: selectedIndexes.isEmpty ? null : deleteSelected,
                              icon: ImageIcon(
                                size: 20,
                                AssetImage(
                                  'lib/assets/icons/product/delete_icon.png'
                                )
                              ),
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    child: Center(
                      child: products.isEmpty
                        ? Text('Haven\'t searched or scanned items yet')
                        : Expanded(
                          child: ListView.builder(
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10.0),
                                    child: HistoryItem(
                                      product: products[index],
                                      dataService: dataService,
                                      isChecked: selectedIndexes.contains(index), // Pass selection state and call back to each item
                                      onChecked: (checked) {
                                        setState(() {
                                          if (checked) {
                                            selectedIndexes.add(index);
                                          } else {
                                            selectedIndexes.remove(index);
                                          }
                                        });
                                      },
                                      deleteProduct: () => deleteProduct(index),
                                    ),
                                  );
                                },
                              ),
                        ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
