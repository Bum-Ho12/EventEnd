import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';

class SuggestedCardShimmer extends StatefulWidget {
  const SuggestedCardShimmer({super.key});

  @override
  State<SuggestedCardShimmer> createState() => _SuggestedCardShimmerState();
}

class _SuggestedCardShimmerState extends State<SuggestedCardShimmer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 220,
        width: 180,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: ThemeApplication.lightTheme.shimmerColor.withOpacity(0.3),
          borderRadius: const BorderRadius.all(Radius.circular(2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ClipOval(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: ThemeApplication.lightTheme.shimmerColor
                            .withOpacity(0.5),
                        borderRadius: BorderRadius.circular(360)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 30,
                decoration: BoxDecoration(
                    color: ThemeApplication.lightTheme.shimmerColor
                        .withOpacity(0.5),
                    borderRadius: BorderRadius.circular(24)),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 20,
                decoration: BoxDecoration(
                    color: ThemeApplication.lightTheme.shimmerColor
                        .withOpacity(0.5),
                    borderRadius: BorderRadius.circular(24)),
              ),
              const SizedBox(
                height: 7,
              ),
            ],
          ),
        ));
  }
}
