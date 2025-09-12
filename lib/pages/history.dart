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

  @override
  void initState() {
    super.initState();
    dataService = DataService();
  }

  Future<List<ProductDto>> _loadProducts() async {
    final box = Hive.box('HISTORY_BOX');
    return box.values.cast<ProductDto>().toList();
  }

  void deleteProduct(int index) {
    setState(() {
      final box = Hive.box('HISTORY_BOX');
      box.deleteAt(index);
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
                                value: false,
                                onChanged: (bool? flag) {
                                  flag = true; // TODO: Add functionality to select all
                                }
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
                              onPressed: () {
                                // TODO: Add functionality to delete all
                              },
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
                
                FutureBuilder<List<ProductDto>>(
                  future: _loadProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error loading history');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('Haven\'t searched or scanned items yet');
                    } else {
                      final products = snapshot.data!;
                      final last10 = products.reversed.take(10).toList(); // Get last 10 items
                      return Expanded(
                        child: ListView.builder(
                          itemCount: last10.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: HistoryItem(
                                product: last10[index],
                                dataService: dataService,
                                deleteProduct: () => deleteProduct(products.length - 1 - index),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
