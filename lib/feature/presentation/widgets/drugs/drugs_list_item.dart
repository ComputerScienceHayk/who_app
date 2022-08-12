import 'package:flutter/material.dart';
import 'package:sdh_task/common/app_colors.dart';
import 'package:sdh_task/feature/presentation/bloc/drug_details_cubit/drug_details_cubit.dart';
import 'package:sdh_task/feature/presentation/pages/drug_details_screen.dart';
import 'package:sdh_task/feature/presentation/widgets/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrugsListItem extends StatelessWidget {
  const DrugsListItem({
    required this.id,
    required this.tradeLabelName,
    required this.manufactureName,
    Key? key,
  }) : super(key: key);

  final int id;
  final String tradeLabelName;
  final String manufactureName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<DrugDetailsCubit>().loadDrugDetails(id);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DetailsScreen(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 10.0,
        ),
        height: 90,
        decoration: BoxDecoration(
          color: AppColors.drugsListItemBg,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: AppColors.drugsListItemShadow,
              offset: Offset(2, 4),
              blurRadius: 2,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(text: tradeLabelName),
            const SizedBox(width: 10),
            CustomText(text: manufactureName),
          ],
        ),
      ),
    );
  }
}
