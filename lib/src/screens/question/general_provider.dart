import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/repository.dart';
import '../../model/service.dart';

class GeneralProvider extends StatelessWidget {
  final Widget child;

  const GeneralProvider({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider(
            create: (context) => QuestionsService(),
          ),
          Provider(
            create: (context) => QuestionsRepository(
              service: context.read<QuestionsService>(),
            ),
          ),
        ],
        child: child,
      );
}
