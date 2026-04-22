import 'package:final_project/ui/screens/bike_detail/widgets/info_row.dart';
import 'package:final_project/ui/screens/bike_detail/widgets/pass_selection_view.dart';
import 'package:final_project/ui/screens/bike_detail/view_model/bike_detail_view_model.dart';
import 'package:final_project/ui/state/booking_state.dart';
import 'package:final_project/ui/state/subscription_state.dart';
import 'package:final_project/ui/theme/theme.dart';
import 'package:final_project/ui/utils/asyncvalue.dart';
import 'package:final_project/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BikeDetailContent extends StatelessWidget {
  const BikeDetailContent({super.key, required this.bikeDetailVm});

  final BikeDetailViewModel bikeDetailVm;

  @override
  Widget build(BuildContext context) {
    switch (bikeDetailVm.bikeValue.state) {
      case AsyncValueState.loading:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));

      case AsyncValueState.error:
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            backgroundColor: AppColors.textWhite,
            title: Text(
              'Bike Detail',
              style: AppTextStyles.body.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          body: Center(child: Text('Error: ${bikeDetailVm.bikeValue.error}')),
        );
        
      case AsyncValueState.success:
        final bike = bikeDetailVm.currentBike;
        final hasActivePass = context.watch<SubscriptionState>().hasActivePass;
        final bookingState = context.watch<BookingState>();
        final alreadyBooked = bookingState.bookedBikeId != null;

    return Scaffold(
      backgroundColor: AppColors.textWhite,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.textWhite,
        title: Text(
          'Bike Detail',
          style: AppTextStyles.body.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacings.l),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacings.m),
                    decoration: BoxDecoration(
                      color: AppColors.textWhite,
                      borderRadius: BorderRadius.circular(AppSpacings.radius),
                      border: Border.all(
                        color: AppColors.inactive,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 26,
                              backgroundColor: AppColors.backgroundAccent,
                              child: const Icon(
                                Icons.pedal_bike_rounded,
                                size: 28,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: AppSpacings.s),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bike ID',
                                  style: AppTextStyles.label.copyWith(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  bike.id,
                                  style: AppTextStyles.heading.copyWith(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacings.m),
                        InfoRow(
                          icon: Icons.shield,
                          label: 'Dock Slot',
                          value: bikeDetailVm.dock.id,
                        ),
                        const SizedBox(height: AppSpacings.s),
                        InfoRow(
                          icon: Icons.location_on,
                          label: 'Station',
                          value: bikeDetailVm.station.name,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacings.l),
                  if (!alreadyBooked)
                    PassSelectionView(),
                ],
              ),
            ),
          ),
          SafeArea(
            top: false,
            minimum: const EdgeInsets.fromLTRB(
              AppSpacings.l,
              AppSpacings.s,
              AppSpacings.l,
              AppSpacings.l,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Button(
                text: alreadyBooked ? 'Already Booked a Bike' : 'Book This Bike',
                onPressed: () async {
                  final selectedPlan = bikeDetailVm.selectedPlan;

                  if (!hasActivePass && selectedPlan != null && selectedPlan.period != 'single') {
                    context.read<SubscriptionState>().setActivePass(selectedPlan);
                  }

                  context.read<BookingState>().bookBike(bike.id,bikeDetailVm.station.id,);

                  await showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Success'),
                      content: const Text('Bike booked successfully!'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );

                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                color: AppColors.primary,
                isActive: !alreadyBooked && (hasActivePass || bikeDetailVm.selectedPlanId != null),
                height: 52,
              ),
            ),
          ),
        ],
      ),
    );
    }
  }
}
