import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'text_state.dart';

class TextCubit extends Cubit<TextState> {
  TextCubit() : super(TextInitial());
}
