

import 'package:cubit_example/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterState>{
  CounterCubit() : super(CounterInit());

  int counter = 0;

  void inc(){
    counter++;
    emit(CounterInit());

  }


}