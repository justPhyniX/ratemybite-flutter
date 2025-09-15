import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ratemybite/pages/more_pages/credits.dart';
import 'package:ratemybite/pages/more_pages/faq.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'More',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    spacing: 10,
                    children: [
                  
                      // FAQ
                      Material(
                        elevation: 2,
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FaqPage()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    child: Row(
                                      spacing: 10,
                                      children: [
                                        SvgPicture.asset('lib/assets/icons/more/FAQ.svg'),
                                            
                                        const Text(
                                          "FAQ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    )
                                  ),
                                ),
                                      
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: SizedBox(
                                      child: Icon(
                                        Icons.arrow_forward_ios_rounded
                                      )
                                    ),
                                  )
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                  
                      // Credits
                      Material(
                        elevation: 2,
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadiusGeometry.circular(10),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CreditsPage()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    child: Row(
                                      spacing: 10,
                                      children: [
                                        SvgPicture.asset('lib/assets/icons/more/Credits.svg'),
                                            
                                        const Text(
                                          "Credits",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    )
                                  ),
                                ),
                                      
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: SizedBox(
                                      child: Icon(
                                        Icons.arrow_forward_ios_rounded
                                      )
                                    ),
                                  )
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 123.0, vertical: 23.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.center,
                      child: const Text(
                        'v1.0.0',
                        style: TextStyle(
                          color: Color.fromARGB(100, 255, 255, 255),
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
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
