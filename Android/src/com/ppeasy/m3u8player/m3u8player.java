package com.ppeasy.m3u8player;

import android.app.Activity;
import android.os.Bundle;
import android.app.ProgressDialog;  
//import android.support.v7.app.AppCompatActivity;  
import android.os.Bundle;  
import android.view.KeyEvent;  
import android.webkit.WebChromeClient;  
import android.webkit.WebSettings;  
import android.webkit.WebView;  
import android.webkit.WebViewClient;  
import android.view.View;
import android.view.WindowManager;

import java.io.BufferedReader;  
import java.io.InputStreamReader;  
import android.widget.VideoView; 
import android.webkit.JavascriptInterface;
import android.widget.Toast;
import android.widget.LinearLayout;
 
import android.os.Bundle;    
import android.os.Handler;    
import android.os.Message;    
import android.util.Log;    
import android.media.MediaPlayer.OnErrorListener;
import android.media.MediaPlayer;
import android.content.Context;
import java.util.Timer; 
import java.util.TimerTask;
import android.media.MediaPlayer;
import android.media.MediaPlayer.*;
import android.content.Intent; 

import java.io.*;
import android.webkit.ValueCallback;
 

public class m3u8player extends Activity
{ 
    private WebView webView;  
    private ProgressDialog dialog;  
    private VideoViewEx videoview;    
    private String url=null;
    private int playerrornum=0;
    private int retry=0;
     
    public static Context mContext;
    /** Called when the activity is first created. */
    static {
        System.loadLibrary("ppeasy");
    }
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
		//getWindow().addFlags(WindowManager.LayoutParams.FLAG_HARDWARE_ACCELERATED); 
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
         
		 mContext=this;
        init(); 
         
 
		
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
    }
    boolean playerror=false;
    private void setStatus(){
        
    }
	@Override  
    public void onResume() {  
        super.onResume();  // Always call the superclass method first  
         
        Log.d("ppeasy","resume !!!!!!!!!!!");
    }    
    public void onSop()  
    {  
        super.onStop();  
        //TODO SOMETHING   
    }  
	public static String ReadJs(Context context) {
        InputStream is = null;
        String msg = null;
        try {
            is = context.getResources().getAssets().open("hook.js");
            byte[] bytes = new byte[is.available()];
            is.read(bytes);
            msg = new String(bytes);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                is.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return msg;
    } 
    private void init() {  
        webView = (WebView) findViewById(R.id.webView);   
        webView.setLayerType(View.LAYER_TYPE_HARDWARE, null);
        webView.loadUrl("file:///android_asset/index.html");   
        //webView.addJavascriptInterface(new JsInteration(), "control");
        webView.setWebViewClient(new WebViewClient(){  
            @Override  
            public boolean shouldOverrideUrlLoading(WebView view, String url) {   
                if (!(url.startsWith("http://") || url.startsWith("https://"	)) )
				return true;
							
				view.loadUrl(url);            return true; 
            }  
			
			@Override
			public void onPageFinished(WebView view, String url) {
				super.onPageFinished(view, url);
				Log.i("VideoEnable",url);
				if(true){ 

					String js=ReadJs(mContext);
					 
					view.loadUrl("javascript:" + js);
				}
			} 
        });  
		//webView.setLayerType(View.LAYER_TYPE_HARDWARE, null); 
        WebSettings settings = webView.getSettings();  
        settings.setJavaScriptEnabled(true);  
        settings.setCacheMode(WebSettings.LOAD_NO_CACHE);  
        webView.setWebChromeClient(new WebChromeClient() {  
            @Override  
            public void onShowCustomView(View view, CustomViewCallback callback) {  
                super.onShowCustomView(view, callback);  
            }  
			@SuppressWarnings("unused")
			public boolean onBackPressed()
			{ 
				{
					return false;
				}
			}
        });   
    }  
  
}
