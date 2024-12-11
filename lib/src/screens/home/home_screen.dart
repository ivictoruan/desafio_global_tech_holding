import 'package:flutter/material.dart';

import '../question/question_screen.dart';
import 'widgets/proposal_card_widget.dart';
import 'widgets/feature_card_widget.dart';
import 'widgets/banner_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  List<Map<String, Object>> get features => [
        {'icon': Icons.monetization_on, 'label': "Empréstimos"},
        {'icon': Icons.groups, 'label': "Consórcios"},
        {'icon': Icons.credit_card, 'label': "Financiamentos"},
        {'icon': Icons.show_chart, 'label': "Investimentos"},
        {'icon': Icons.health_and_safety_outlined, 'label': "Plano de Saúde"},
        {'icon': Icons.safety_check, 'label': "Seguros"},
        {'icon': Icons.more_horiz, 'label': "Outros"},
        {'icon': Icons.local_offer, 'label': "Promoções"},
      ];

  List<Map<String, Object>> get bottomNavItems => [
        {'icon': Icons.home, 'label': "Início"},
        {'icon': Icons.assignment, 'label': "Propostas"},
        {'icon': Icons.local_offer, 'label': "Promoções"},
        {'icon': Icons.help, 'label': "Ajuda"},
        {'icon': Icons.menu, 'label': "Menu"},
      ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                child: Text("EN"),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    decoration: InputDecoration(
                      constraints: BoxConstraints(
                        maxHeight: 36,
                      ),
                      hintText: 'Buscar',
                      contentPadding: EdgeInsets.only(left: 8),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              // TODO: ajustar tamanho e estilo da notificação
              Icon(Icons.circle_notifications, color: Colors.black),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      6,
                      (_) => const BannerWidget(),
                    ),
                  ),
                ),
                const Divider(),
                const ProposalCardWidget(),
                const Divider(),
                const Text(
                  "Feito para você",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  children: features.map(
                    (Map<String, Object> feature) {
                      final bool isPromotion =
                          (feature['label'] as String) == 'Empréstimos';

                      if (isPromotion) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const QuestionsScreen(
                                  featureName: 'Empréstimos',
                                ),
                              ),
                            );
                          },
                          child: FeatureCardWidget(
                            icon: feature['icon'] as IconData,
                            label: feature['label'] as String,
                          ),
                        );
                      }
                      return FeatureCardWidget(
                        icon: feature['icon'] as IconData,
                        label: feature['label'] as String,
                        backgroundColor:
                            (feature['label'] as String) == 'Promoções'
                                ? Colors.white
                                : null,
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: bottomNavItems
              .map(
                (item) => BottomNavigationBarItem(
                  icon: Icon(item['icon'] as IconData),
                  label: item['label'] as String,
                ),
              )
              .toList(),
        ),
      );
}
