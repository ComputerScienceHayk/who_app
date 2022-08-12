import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:sdh_task/locator_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdh_task/common/const_texts.dart';
import 'package:sdh_task/locator_service.dart' as di;
import 'package:sdh_task/feature/presentation/pages/drugs_screen.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sdh_task/feature/presentation/bloc/drugs_list_cubit/drugs_list_cubit.dart';
import 'package:sdh_task/feature/presentation/bloc/drug_details_cubit/drug_details_cubit.dart';
import 'package:sdh_task/feature/presentation/bloc/connection_checker_cubit/connection_checker_cubit.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MedicalApp());
}

class MedicalApp extends StatelessWidget {
  const MedicalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectionCheckerCubit>(
            create: (context) => sl<ConnectionCheckerCubit>()..execute(InternetConnectionChecker()),
        ),
        BlocProvider<DrugsListCubit>(
            create: (context) => sl<DrugsListCubit>()..loadDrugsList(1),
        ),
        BlocProvider<DrugDetailsCubit>(
            create: (context) => sl<DrugDetailsCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: BotToastInit(),
        title: ConstTexts.appTitle,
        home: const DrugsScreen(),
      ),
    );
  }
}