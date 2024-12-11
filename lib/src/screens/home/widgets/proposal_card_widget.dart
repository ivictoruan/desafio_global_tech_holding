

import 'package:flutter/material.dart';

class ProposalCardWidget extends StatelessWidget {
  const ProposalCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Última proposta",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.visibility, size: 16),
                ],
              ),
              SizedBox(height: 8),
              Text("Home Equity",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 8),
              Text("Valor: R\$ ****"),
              Text("Data: 10/04/2024"),
            ],
          ),
          Column(
            children: [
              Chip(
                label: const Text(
                  "Estado jornada",
                  style: TextStyle(fontSize: 12),
                ),
                backgroundColor: Colors.grey[300],
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  elevation: 0,
                  shape: const LinearBorder(),
                ),
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Colors.black,
                ),
                onPressed: () {},
                label: const Text(
                  "Mais detalhes",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}