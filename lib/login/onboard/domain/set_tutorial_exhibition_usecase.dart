import 'package:e_racing_app/core/data/store_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/service/api_exception.dart';

class SetTutorialExhibitionUserUseCase<T> extends BaseUseCase<T?> {
  @override
  Future<void> invoke(
      {required Function(T?) success, required Function error}) async {
    var response =
        await super.local(StoreRequest("tutorial", Operation.save, data: true));
    if (response.isSuccessfully) {
      var data = response.data as T;
      success.call(data);
    } else {
      error.call(ApiException(
          message: "error trying to retrive local data",
          isBusinessError: false));
    }
  }
}
