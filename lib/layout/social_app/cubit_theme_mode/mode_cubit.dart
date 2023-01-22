import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/network/local/cash_helper.dart';
import 'mode_states.dart';

class AppModeCubit extends Cubit<ModeStates>{
  AppModeCubit() : super(InitialModeState()) ;
  static AppModeCubit get(context) => BlocProvider.of(context);


  bool isDark = false;

  void changeAppMode({bool? fromShared}){
    if (fromShared != null)
        { isDark = fromShared; }  
          else
      {isDark = !isDark;}
    CashHelper.putData(key: 'isDark', value:isDark).then((value) {
    emit(ChangeModeState());
    });
  }

}