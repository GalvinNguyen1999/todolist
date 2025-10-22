import 'package:flutter/material.dart';

/// Information card about the app
class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(
              Icons.info_outline,
              size: 48,
              color: Colors.blue[700],
            ),
            const SizedBox(height: 16),
            const Text(
              'Về ứng dụng',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Đây là ứng dụng Todo List đơn giản '
              'được xây dựng bằng Flutter.\n\n'
              'Bạn có thể thêm, sửa, xóa và đánh dấu '
              'hoàn thành các công việc của mình.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                height: 1.5,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

