import 'package:fancy_android/model/theme_color_model.dart';
import 'package:fancy_android/util/constant_util.dart';
import 'package:fancy_android/util/sharedPreferences_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String _colorKey;

  @override
  void initState() {
    super.initState();
    getColorKey();
  }

  void getColorKey() async {
    setState(() {
      _colorKey = SharedPreferencesUtil.getString(
          SharedPreferencesUtil.SHARE_THEME_COLOR,
          defValue: 'blue');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
        centerTitle: true,
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: 12),
              child: Text(
                '切换主题',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ConstantUtil.themeColorMap.keys.map((key) {
                Color value = ConstantUtil.themeColorMap[key];
                return InkWell(
                  onTap: () {
                    setState(() {
                      _colorKey = key;
                    });
                    SharedPreferencesUtil.put(
                        SharedPreferencesUtil.SHARE_THEME_COLOR, key);
                    Provider.of<ThemeColorModel>(context).changeThemeColor(key);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    color: value,
                    child: _colorKey == key
                        ? Icon(
                            Icons.done,
                            color: Colors.white,
                          )
                        : null,
                  ),
                );
              }).toList(),
            ),
          ],
        ));
  }
}
