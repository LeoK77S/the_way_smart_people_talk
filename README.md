# 聪明人讲话的方式

> 一眼顶针，鉴定为：加密通话

The-Way-Smart-People-Talk是一款Flutter应用，可以帮助你学习如何像聪明人一样讲话（×）。当你在聊天软件（例如微信）上聊天时，假如涉及到一些不该讨论的话题，你可以使用这款应用来加密你的消息，他人可以使用这款应用来解密消息。这样，超管就无法根据你所发送消息的字面意思来判断你们是否讨论了什么不是十分恰当的话题。

## 使用方法

### 获取应用

应用默认提供了十六进制密码器(简单)、你还要我怎样密码器(简单)、你还要我怎样密码器(普通)三种密码器作为示例，破译难度依次提高，你可以使用这几个默认的密码器，或者自行创建你自己的密码器。假如你需要使用自己的加解密算法，你需要在[lib/cipher.dart](lib/cipher.dart)及[lib/home.dart](lib/home.dart)中分别作出相应的修改，具体修改方式可以参见文末的开发指北。

你可以在Release中下载应用，或者自行编译。理论上，这款应用可以在任何支持Flutter的平台上运行。但是我只有一台Windows PC，所以Release中只有我可以构建的三个平台的应用：Android、Windows和Web。

如果你想在其他平台上使用这款应用，你可以自行编译。需要先安装Flutter，安装方式参见[安装和环境配置-Flutter](https://flutter.cn/docs/get-started/install)，然后运行[flutter_build_wwa.bat](flutter_build_wwa.bat)构建Android、Windows、Web三个平台的应用，或者在添加其他平台支持后，自己输入Flutter指令，来构建此应用，因为我只有构建上述三种平台应用的些许经验，所以其他平台的配置配置及构建方式请自行搜索。

### 使用应用

Android一般选用“app-arm64-v8a-release.apk”并安装；Windows选用“Windows.tar”解压之后运行；Web需要部署到服务器上通过网页来访问，我一般使用Python来部署Web应用，Python命令如下：

```python
# 创建一个screen，这样关闭此次ssh连接之后，Web应用依旧可以在后台运行
screen -S the_way_smart_people_talk

# python -m http.server port
# 其中port选择一个你自己喜欢的端口号即可
python -m http.server 9870
# 假如此指令不可用，可能是python默认对应的是python2，需要自行安装python3，自行搜索安装之后
# python3 -m http.server port
python3 -m http.server 9870
```

Linux桌面应用程序需要在Linux环境下构建；IOS应用程序和MacOS桌面应用程序需要在MacOS环境下构建，且需要Apple开发者账号及证书(我没有试过，请自行搜索)。

## 开发指北

假设新创建密码器-“君日本语本当上手”密码器(普通)，不妨命名为CipherNormalJap，其可以根据情况继承自[lib/cipher_base.dart](lib/cipher_base.dart)中的Cipher、CipherRadix、或CipherExpand基类，然后在[lib/cipher.dart](lib/cipher.dart)中实现此密码器，并在CipherType中添加此密码器，在getCipherTypeDescription中添加相应描述。

```dart
enum CipherType { easy16, easyAbaAba, normalNhywzy,
    // “君日本语本当上手”密码器(普通)
    normalJap }

String getCipherTypeDescription(CipherType cipherType) {
  switch (cipherType) {
    case CipherType.easy16:
      return '十六进制密码器(简单)';
    case CipherType.easyAbaAba:
      return '阿巴阿巴(简单)';
    case CipherType.normalNhywzy:
      return '你还要我怎样(普通)';
    // “君日本语本当上手”密码器(普通)
    case CipherType.normalJap:
      return '君日本语本当上手(普通)';
  }
}

class CipherNormalJap extends Cipher {}
```

随后在[lib/home.dart](lib/home.dart)中的setCipherByType方法中添加相应的密码器实例化代码。

```dart
void setCipherByType(CipherType cipherType) {
    setState(() {
      _cipherType = cipherType;
      switch (cipherType) {
        case CipherType.easy16:
          _cipher = CipherRadix(16);
          break;
        case CipherType.easyAbaAba:
          _cipher = CipherEasyAbaAba();
          break;
        case CipherType.normalNhywzy:
          _cipher = CipherNormalNhywzy();
          break;
        // 新增的“君日本语本当上手”密码器(普通)
        case CipherType.normalJap:
          _cipher = CipherNormalJap();
          break;
      }
    });
  }
```

随后在[lib/home.dart](lib/home.dart)中的Drawer控件中添加相应的密码器按钮，可以在home中搜索“Drawer”或“请选择密码器类型：”定位到相应位置，然后添加一个RadioListTile到列表中。

```dart
请选择密码器类型：
RadioListTile(
    value: CipherType.normalJap,
    title: Text(getCipherTypeDescription(CipherType.normalJap)),
    groupValue: _cipherType,
    onChanged: cipherTypeRadioChanged),
```
