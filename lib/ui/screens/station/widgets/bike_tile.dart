import 'package:final_project/model/dock.dart';
import 'package:flutter/material.dart';

class BikeTile extends StatelessWidget {
  const BikeTile({super.key, required this.dock, required this.onTap});
  final Dock dock;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Color(0xFF555555), width: 1),
      ),
      leading: SizedBox(
        width: 32,
        height: 32,
        child: Stack(
          alignment: const Alignment(0, -0.1),
          children: [
            const Icon(Icons.shield, color: Colors.black, size: 24),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                dock.id,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
      title: const Align(
        alignment: Alignment.centerLeft,
        child: Icon(Icons.pedal_bike_rounded, color: Colors.black, size: 34),
      ),
      trailing: Text(
        dock.bikeId ?? '-',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
