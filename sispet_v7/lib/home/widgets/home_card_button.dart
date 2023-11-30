import 'package:flutter/material.dart';

class HomeCardButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  const HomeCardButton({super.key, required this.title, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 50,
            color: Colors.grey,
          ),
          const SizedBox(height: 13,),
          Text(title)
        ],
      ),
    );
  }
}
