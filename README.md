[//]: # (redundant)
![image](https://www.mogua.io/images/mogua_logo_en.png)

[//]: # (redundant)
# Mogua Flutter

[![Pub Package](https://img.shields.io/pub/v/mogua.svg)](https://pub.dev/packages/mogua)

Mogua is a web to app parameter passing solution. It allows you to track your app's installations from landing page with a lightweight deferred deep linking SDK.

Try our [live demo](https://www.mogua.io/live-demo) in 10 seconds!

## Features

- SDK to track your apps’ installation
- Create unlimited custom parameters
- Parameter analytics
- App trending analytics


## Installation

Through the command line:

[//]: # (target="Command Line")
```sh
dart pub add mogua
```

Alternatively, in the `dependencies:` section of your `pubspec.yaml`, add:

[//]: # (language="Yaml", target="pubspec.yaml")
```yaml
dependencies:
  # ...
  mogua: 0.4.2

```

## Initialize the SDK

You need to initialize the SDK before any usage.

[//]: # (language="Dart", target="Example")
```dart
// appKey: You can find it on the mogua.io dashboard.
// allowPasteboardAccess: Whether to allow access to the clipboard. Enabling this feature can enhance accuracy, but may trigger permission warnings.

Mogua.init(appKey: '${appKey}', allowClipboardAccess: true);
```

## Retrieve the parameters

After initialization, you can asynchronously retrieve the parameters carried during installation (eg. Submit from landing pages).

[//]: # (language="Dart", target="Example")
```dart
// Retrieves data from the Mogua platform.
// This data is cached, ensuring identical return values for subsequent calls to [getData].

final data = await Mogua.getData();
final channel = data['channel'];
final referrer = data['referrer'];
```

[//]: # (redundant)
## Learn More

[//]: # (redundant)
Visit [mogua.io](https://www.mogua.io) to see the details.