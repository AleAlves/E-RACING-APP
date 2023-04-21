import 'package:e_racing_app/core/data/store_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/service/api_exception.dart';

class DeleteUserUseCase<T> extends BaseUseCase<T> {
  @override
  Future<void> invoke(
      {required Function(T) success, required Function error}) async {
    var response = await super.local(StoreRequest("user", Operation.erase));
    if (response.isSuccessfully) {
      success.call(response.data as T);
    } else {
      error.call(ApiException(
          message: "error trying to retrive local data",
          isBusinessError: false));
    }
  }
}
