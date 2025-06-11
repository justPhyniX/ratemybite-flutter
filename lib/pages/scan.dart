import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ratemybite/assets/elements/barcode_scanner.dart';
import 'package:ratemybite/assets/elements/search_bar.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: SvgPicture.asset(
          'lib/assets/icons/top_bar/logo.svg',
        )
      ),
      body: Column(
        children: [
          MySearchBar(),
          MyBarcodeScanner(),
        ]
      ),
    );
  }
}




// Container(
//   padding: EdgeInsets.all(5),
//   width: double.infinity,
//   child: Text("Ingredienst"),
// ),
// Container(
//   padding: EdgeInsets.symmetric(
//     vertical: 15,
//     horizontal: 20
//   ),
//   width: double.infinity,
//   decoration: ShapeDecoration(
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(7),
//     ),
//     color: Theme.of(context).colorScheme.secondary,
//   ),
//   child: RichText(
//     text: TextSpan(
//       text: "Lorem Ipsum"
//     ),
//   ),
// ),