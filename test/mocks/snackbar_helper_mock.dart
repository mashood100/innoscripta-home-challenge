import 'package:mockito/mockito.dart';
import 'package:innoscripta_home_challenge/presentation/shared/widgets/snackbars/snackbar_helper.dart';

class MockSnackbarHelper extends Mock implements SnackbarHelper {
  static void snackbarWithTextOnly(String message) {}
}