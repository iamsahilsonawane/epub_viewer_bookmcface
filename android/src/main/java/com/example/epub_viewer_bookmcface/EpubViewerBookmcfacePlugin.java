package com.example.epub_viewer_bookmcface;

import android.content.Context;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;

import java.util.ArrayList;
import java.util.HashMap;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * EpubViewerBookmcfacePlugin
 */
public class EpubViewerBookmcfacePlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private Context mContext; // Instance variable for context


    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "epub_viewer_bookmcface");
        mContext = flutterPluginBinding.getApplicationContext();
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else if (call.method.equals("openViewer")) {
            String epubFilePath = call.arguments();
            Log.i("openViewer", epubFilePath);
            Intent readBook = new Intent(mContext, ReaderActivity.class);
            readBook.putExtra(ReaderActivity.FILENAME, epubFilePath);
            readBook.putExtra(ReaderActivity.SCREEN_PAGING, true);
            readBook.putExtra(ReaderActivity.DRAG_SCROLL, true);
            readBook.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            readBook.setAction(Intent.ACTION_VIEW);
            mContext.startActivity(readBook);
        } else {
            result.notImplemented();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }
}
