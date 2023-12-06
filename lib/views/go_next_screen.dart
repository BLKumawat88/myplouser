import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/all_in_controller.dart';

class GOTOHome extends StatelessWidget {
  const GOTOHome({super.key});

  @override
  Widget build(BuildContext context) {
    AllInProvider provider = Provider.of<AllInProvider>(context, listen: false);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => provider.getCategoryDetails(context));

    return Scaffold(
      body: Center(child: Text("Please Wait")),
    );
  }
}
