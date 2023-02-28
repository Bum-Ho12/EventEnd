import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';

class HomeTileShimmer extends StatefulWidget {
  const HomeTileShimmer({super.key});

  @override
  State<HomeTileShimmer> createState() => _HomeTileShimmerState();
}

class _HomeTileShimmerState extends State<HomeTileShimmer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeApplication.lightTheme.backgroundColor,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 1),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 100,
              width: 200,
              color: ThemeApplication.lightTheme.shimmerColor.withOpacity(0.3),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
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
          ),
        ],
      ),
    );
  }
}
