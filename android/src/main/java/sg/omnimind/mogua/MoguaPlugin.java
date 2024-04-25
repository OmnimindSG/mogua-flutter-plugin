package sg.omnimind.mogua;

import android.app.Activity;

import androidx.annotation.NonNull;

import java.util.HashMap;

import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.mogua.sdk.Mogua;
import io.mogua.sdk.MoguaCallback;

/** MoguaPlugin */
public class MoguaPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Activity _activity;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "mogua");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("init")) {
      final String appKey = call.argument("appKey");
      final boolean allowClipboardAccess = Boolean.TRUE.equals(call.argument("allowClipboardAccess"));
      Mogua.init(_activity, appKey, allowClipboardAccess);
      result.success(null);
    } else if (call.method.equals("getData")) {
      Mogua.getData(new MoguaCallback() {
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
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    _activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
  }

  @Override
  public void onDetachedFromActivity() {
  }
}
