[//]: # (redundant)
![image](https://www.mogua.io/images/mogua_logo_en.png)

## Mogua Flutter Plugin

[//]: # (redundant)
[![Pub Package](https://img.shields.io/pub/v/mogua.svg)](https://pub.dev/packages/mogua)

[//]: # (redundant)
Mogua is a web to app parameter passing solution. It allows you to track your app's installations from landing page with a lightweight deferred deep linking SDK.

[//]: # (redundant)
Try our [live demo](https://www.mogua.io) in 10 seconds!

[//]: # (redundant)
---

[//]: # (redundant)
### Features

[//]: # (redundant)
✅ Track your apps’ installation (Deferred Deep Linking)

[//]: # (redundant)
✅ Track your apps’ opening events (e.g., from URL Scheme, Universal Link, App Links)

[//]: # (redundant)
✅ Pass parameters via deep links

[//]: # (redundant)
✅ Parameter analytics

[//]: # (redundant)
✅ App trending analytics

---

### Install the plugin

Through the command line:

[//]: # (target="Command Line")
```sh
dart pub add mogua
```
&nbsp;  

Alternatively, in the `dependencies:` section of your `pubspec.yaml`, add:

[//]: # (language="Yaml", target="pubspec.yaml")
```yaml
dependencies:
  # ...
  mogua: ^0.8.0

```
&nbsp;  

---

### Initialize the plugin

You need to initialize the plugin before any usage.

The `init` method returns a `Future` to indicate whether the initialization is complete.

[//]: # (language="Dart", target="Example")
```dart
import 'package:mogua/mogua.dart';

// appKey: The App Key associated with this application, you can find it on the mogua.io dashboard.
// allowPasteboardAccess: Whether to allow access to the clipboard. Enabling this feature can enhance accuracy, but may trigger permission warnings on certain systems.

Mogua.init(appKey: '${appKey}', allowClipboardAccess: true).then((_) {
  // You can retrieve data such as channel, referrals, etc.
});
```
&nbsp;  

---

### Retrieve the params

 Before retrieving the params, refer to the **[How to collect params on website](https://www.mogua.io/docs/integration/params-collect)**.

#### Get params during app installation (Deferred Deep Linking)

After initialization, you can asynchronously retrieve the parameters passed during installation (eg. submissions from landing pages):

[//]: # (language="Dart", target="Example")
```dart
Mogua.getInstallData().then((data) {
  // data: Parameters passed from the web to the app.
  // Returns an empty Map if no parameters are provided.
  // Parameters are cached and will remain the same unless the app is reinstalled.
}).onError((error, stackTrace) {
  // Handle any exceptions that occurred.
});
```
&nbsp;  

#### Get params during app opening (Direct Deep Linking)

When the app is already installed on the device, there is no need to download and launch the app again. Instead, we simply open the app and pass the parameters collected.

[//]: # (language="Dart", target="Example")
```dart
Mogua.getOpenData(
  onData: (data) {
    // Handle the retrieved data.
  },
  onError: (error) {
    // Handle the exception.
  },
)
```
&nbsp;  

---

#### Remember to configure the URL Scheme in your application.

[//]: # (redundant)
A detailed guide is available on the <a href="https://www.mogua.io" target="_blank">**mogua.io**</a> dashboard.


