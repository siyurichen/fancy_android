import 'package:fancy_android/model/latest_article_model.dart' as articleModel;
import 'package:fancy_android/model/theme_color_model.dart';
import 'package:fancy_android/model/user_model.dart';
import 'package:provider/provider.dart';

class ProviderUtil {
  static init({context, child}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => UserModel(null, -1, '')),
        ChangeNotifierProvider(
          builder: (_) => articleModel.Datas.origin(),
        ),
        ChangeNotifierProvider(
          builder: (_) => ThemeColorModel(),
        ),
      ],
      child: child,
    );
  }

  static T value<T>(context) {
    return Provider.of<T>(context);
  }

  static Consumer consumer<T>({builder, child}) {
    return Consumer<T>(
      builder: builder,
      child: child,
    );
  }
}
