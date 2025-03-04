import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/core/styles/app_images.dart';

class AnalyticsTable extends StatelessWidget {
  final String title;
  final String subtitle;

  const AnalyticsTable({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 24),
          ListView.separated(
            shrinkWrap: true,
            itemCount: 4,
            separatorBuilder: (context, index) => const Divider(height: 32),
            itemBuilder: (context, index) => _buildTableRow(),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(AppImages.dummyUser),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Jesse Thomas',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const Text(
          '23',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
