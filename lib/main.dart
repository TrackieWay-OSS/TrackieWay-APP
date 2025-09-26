import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackie_app/app/view/app.dart';
import 'package:trackie_app/features/devices/presentation/bloc/devices_cubit.dart';
import 'package:trackie_app/features/settings/presentation/bloc/settings_cubit.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SettingsCubit()),
        // Adicione o DevicesCubit aqui
        BlocProvider(create: (_) => DevicesCubit()),
      ],
      child: const App(),
    ),
  );
}

