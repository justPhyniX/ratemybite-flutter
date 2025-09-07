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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'History',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: FutureBuilder<List<ProductDto>>(
            future: _loadProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error loading history');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('Haven\'t searched or scanned items yet.');
              } else {
                final products = snapshot.data!;
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return HistoryItem(
                      product: products[index],
                      dataService: dataService,
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
