import 'package:flutter/material.dart';

import '../utilities/personalization.dart';

class UpdateShimmer extends StatefulWidget {
  const UpdateShimmer({super.key});

  @override
  State<UpdateShimmer> createState() => _UpdateShimmerState();
}

class _UpdateShimmerState extends State<UpdateShimmer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeApplication.lightTheme.backgroundColor,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 1),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                      color: ThemeApplication.lightTheme.shimmerColor
                          .withOpacity(0.3),
                      borderRadius: BorderRadius.circular(24)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                      color: ThemeApplication.lightTheme.shimmerColor
                          .withOpacity(0.3),
                      borderRadius: BorderRadius.circular(24)),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
