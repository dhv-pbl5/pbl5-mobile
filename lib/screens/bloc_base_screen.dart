import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/shared_customization/data/basic_types.dart';
import '/shared_customization/extensions/list_ext.dart';
import '/generated/translations.g.dart';
import '/public_providers/config/bloc_base_state.dart';
import '/public_providers/config/update_bloc_base_state.dart';
import '/shared_customization/extensions/screen_value_ext.dart';
import '/shared_customization/helpers/dialogs/dialog_helper.dart';

// ignore: must_be_immutable
class BlocBaseScreen<B extends UpdateBlocBaseState<S>, S extends BlocBaseState>
    extends StatelessWidget {
  final BlocWidgetBuilder<S> builder;
  final BlocBuilderCondition<S>? buildWhen;
  final List<BlocListener> listeners;
  final BlocBaseAsycnShowDialog<S>? onShowError;
  final BlocBaseAsycnShowDialog<S>? onShowSuccess;
  final BlocBaseOnShowDialogDone<S>? onShowErrorDone;
  final BlocBaseOnShowDialogDone<S>? onShowSuccessDone;
  final BlocBaseCreateCubit<B>? _createCubit;
  final List<BlocProvider> _providers;

  BlocBaseScreen({
    super.key,
    required this.builder,
    this.buildWhen,
    this.listeners = const [],
    this.onShowError,
    this.onShowSuccess,
    this.onShowErrorDone,
    this.onShowSuccessDone,
    BlocBaseCreateCubit<B>? createCubit,
  })  : _createCubit = createCubit,
        _providers = [];

  const BlocBaseScreen.multiProvider({
    super.key,
    required this.builder,
    this.buildWhen,
    this.listeners = const [],
    this.onShowError,
    this.onShowSuccess,
    this.onShowErrorDone,
    this.onShowSuccessDone,
    required List<BlocProvider> providers,
  })  : _createCubit = null,
        _providers = providers;

  @override
  Widget build(BuildContext context) {
    return _blocProviderBuilder(
      child: Builder(builder: (context) {
        return MultiBlocListener(
          listeners: [
            BlocListener<B, S>(
              listenWhen: (previous, current) =>
                  previous.errorMessage != current.errorMessage &&
                  current.errorMessage != null,
              listener: (context, state) {
                (onShowError?.call(context, state) ??
                        showErrorDialog(context, content: state.errorMessage))
                    .then((_) {
                  context.read<B>().resetErrorMessage();
                  onShowErrorDone?.call(context, state);
                });
              },
            ),
            BlocListener<B, S>(
              listenWhen: (previous, current) =>
                  previous.status != current.status && current.status.isSuccess,
              listener: (context, state) {
                (onShowSuccess?.call(context, state) ??
                        showSuccessDialog(context,
                            content: tr(LocaleKeys
                                .CommonNotiAction_YourActionMakingSuccessfully)))
                    .then((_) {
                  context.read<B>().resetStatus();
                  onShowSuccessDone?.call(context, state);
                });
              },
            ),
            if (listeners.isNotEmptyOrNull) ...listeners
          ],
          child: BlocBuilder<B, S>(
            buildWhen: buildWhen,
            builder: (context, state) => builder(context, state),
          ),
        );
      }),
    );
  }

  Widget _blocProviderBuilder({required Widget child}) {
    if (_createCubit != null) {
      return BlocProvider(create: _createCubit!, child: child);
    }
    if (_providers.isNotEmptyOrNull) {
      return MultiBlocProvider(providers: _providers, child: child);
    }
    return child;
  }
}
