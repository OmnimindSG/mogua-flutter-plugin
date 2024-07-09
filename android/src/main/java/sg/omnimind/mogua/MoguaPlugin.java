package sg.omnimind.mogua;

import android.app.Activity;
import android.content.Intent;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.HashMap;

import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.mogua.sdk.Mogua;
import io.mogua.sdk.MoguaCallback;

/** MoguaPlugin */
public class MoguaPlugin implements FlutterPlugin, EventChannel.StreamHandler, MethodCallHandler, ActivityAware, PluginRegistry.NewIntentListener {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel _channel;
  private Activity _activity;
  private EventChannel.EventSink _events;
  private boolean _isSdkInitialized = false;
  private Intent _pendingIntent;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    _channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "mogua_method");
    _channel.setMethodCallHandler(this);
    EventChannel eventChannel = new EventChannel(flutterPluginBinding.getBinaryMessenger(), "mogua_event");
    eventChannel.setStreamHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("init")) {
      final String appKey = call.argument("appKey");
      final boolean allowClipboardAccess = Boolean.TRUE.equals(call.argument("allowClipboardAccess"));
      Mogua.init(_activity, appKey, allowClipboardAccess);
      _isSdkInitialized = true;
      if (_pendingIntent != null && handleOpenAppFromIntent(_pendingIntent)) {
        _pendingIntent = null;
      }
      result.success(null);
    } else if (call.method.equals("getInstallData")) {
      Mogua.getInstallData(new MoguaCallback() {
        @Override
        public void onData(HashMap<String, Object> data) {
          result.success(data);
        }

        @Override
        public void onError(Exception e) {
          result.error("error", e.getLocalizedMessage(), null);
        }
      });
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    _channel.setMethodCallHandler(null);
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    binding.addOnNewIntentListener(this);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    binding.addOnNewIntentListener(this);
    _activity = binding.getActivity();
    Intent intent = _activity.getIntent();
    if (!handleOpenAppFromIntent(intent)) {
      _pendingIntent = intent;
    };
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
  }

  @Override
  public void onDetachedFromActivity() {
  }

  @Override
  public boolean onNewIntent(Intent intent) {
    if (!handleOpenAppFromIntent(intent)) {
      _pendingIntent = intent;
    };
    return false;
  }

  private boolean handleOpenAppFromIntent(@NonNull Intent intent) {
    if (!_isSdkInitialized || _events == null) {
      return false;
    }
    Mogua.getOpenData(intent, new MoguaCallback() {
      @Override
      public void onData(HashMap<String, Object> data) {
        _events.success(data);
      }

      @Override
      public void onError(Exception e) {
        _events.error("error", e.getLocalizedMessage(), null);
      }
    });
    return true;
  }

  @Override
  public void onListen(Object arguments, EventChannel.EventSink events) {
    _events = events;
    if (_pendingIntent != null && handleOpenAppFromIntent(_pendingIntent)) {
      _pendingIntent = null;
    }
  }

  @Override
  public void onCancel(Object arguments) {
    _events = null;
  }

}
