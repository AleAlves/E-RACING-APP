import 'package:e_racing_app/core/data/store_request.dart';
import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/service/api_exception.dart';

class GetTutorialExhibitionUserUseCase<T> extends BaseUseCase<T?> {
  @override
  Future<void> invoke(
      {required Function(T?) success, required Function error}) async {
    var response = await super.local(StoreRequest("tutorial", Operation.fetch));
    if (response.isSuccessfully) {
      var data = response.data ?? false as T;
      success.call(data);
    } else {
      error.call(ApiException(
          message: "error trying to retrive local data",
          isBusinessError: false));
    }
  }
}
