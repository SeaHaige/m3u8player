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
    private VideoView videoview2;  
    private String url=null;
    private int playerrornum=0;
    private int retry=0;
     
    /** Called when the activity is first created. */
    static {
    }
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
		//getWindow().addFlags(WindowManager.LayoutParams.FLAG_HARDWARE_ACCELERATED); 
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        videoview = (VideoViewEx) findViewById(R.id.videoView); 

        int width = videoview.getContext().getResources().getDisplayMetrics().widthPixels; 

        LinearLayout.LayoutParams linearParams = (LinearLayout.LayoutParams) videoview.getLayoutParams();  
        linearParams.height = width*9/16;  
        videoview.setLayoutParams(linearParams); 
        //videoview.setVideoSize(width, linearParams.height);
        //videoview2 = (VideoView) findViewById(R.id.videoView2); 
                    
        videoview.setOnPreparedListener(new OnPreparedListener() {

            @Override
            public void onPrepared(MediaPlayer mp) {
                checkvideoprepare=0;
                Log.d("ppeasy","info prepare...");
                //webView.loadUrl("javascript:hideLoader();");   
            }
        });
        videoview.setOnErrorListener(new OnErrorListener() { 
                @Override
                public boolean onError(MediaPlayer mp, int what, int extra) { 
                    Log.d("ppeasy","on error:"+what);
                    //if(0!=checkvideoprepare)                        
                    playerror=true;
                    playerrornum++;
                    setStatus();
                    return true; 
                }
            });
        init(); 
         

        Timer timer = new Timer();
        TimerTask task = new TimerTask() {
            @Override
            public void run() {                                 
                if( checkvideoprepare!=0 && System.currentTimeMillis()-checkvideoprepare>6000 || playerror){
                    playerror=false; 
                    checkvideoprepare=0; 
                    { 
                        Message msg = new Message();
                        msg.what=0;
                        msg.obj = url;//可以是基本类型，可以是对象，可以是List、map等；
                        mHandler.sendMessage(msg);
                    } 
                }
            }
        };
        timer.schedule(task,0,1000); 
        System.loadLibrary("ppeasy");
		
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
    }
    boolean playerror=false;
    private void setStatus(){
        
    }
	@Override  
    public void onResume() {  
        super.onResume();  // Always call the superclass method first  
        if(url!=null)
        {
            playerrornum++;
            setStatus();
            Message msg = new Message();
            msg.what=0;
            msg.obj = url;//可以是基本类型，可以是对象，可以是List、map等；
            mHandler.sendMessage(msg);
        }
        Log.d("ppeasy","resume !!!!!!!!!!!");
    }  
    private String channelname="";
    private long checkvideoprepare=0;
    public Handler mHandler=new Handler(){    
        public void handleMessage(Message msg) { 
			if(msg.what==0){
                String str =(String)msg.obj;  
                String playurl=str; 
                setTitle("m3u8player - "+channelname); 
                Log.d("ppeasy","info open url...");
                checkvideoprepare=System.currentTimeMillis();
                if(url!=null)
                videoview.stopPlayback(); 
				videoview.setVideoPath(playurl);  
                videoview.start();   
                url=playurl;	
            } 
            if(msg.what==1){
                if(msg.arg1==0)
				videoview.setVisibility(View.GONE); 
                if(msg.arg1==1)
				videoview.setVisibility(View.VISIBLE); 
			}
			
			 
                            
        }        
    };    
     
    static String fileName="ppeasy.cfg";
    private String ReadFile() {
        FileInputStream inputStream;
        byte[] buffer = null;
        try {
            inputStream = this.openFileInput(fileName);
            try { 
                int fileLen = inputStream.available(); 
                buffer = new byte[fileLen];
                inputStream.read(buffer);
            } catch (IOException e) {
                e.printStackTrace();
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } 
        if (buffer != null)
            return new String(buffer);//EncodingUtils.getString(buffer, "utf-8");
        else
            return "";

    } 
    private void WriteFile(String message) {
        try { 
            FileOutputStream outStream = this.openFileOutput(fileName,
                    MODE_PRIVATE); 
            byte[] data = message.getBytes();
            try { 
                outStream.write(data);
                outStream.flush();
                outStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }
	public class JsInteration {
 
		@JavascriptInterface
        public void save(String value){
            WriteFile(value);
        }
		@JavascriptInterface
        public String load(){
            return ReadFile();  
        } 
		@JavascriptInterface
		public void showVideo() { 
            Message msg = new Message();
            msg.what=1; 
            msg.arg1=1;
            mHandler.sendMessage(msg); 
		}
		@JavascriptInterface
		public void hideVideo() { 
            Message msg = new Message();
            msg.what=1; 
            msg.arg1=0;
            mHandler.sendMessage(msg); 
		}
		@JavascriptInterface
		public void PlayPath(String playurl,String name) { 
            Log.d("ppeasy","info playpath...");
            retry=0; 
            channelname=name;
            {
                Message msg = new Message();
                msg.what=0;
                msg.obj =playurl; 
                mHandler.sendMessage(msg);
            } 
		} 
	} 
    public void onSop()  
    {  
        super.onStop();  
        //TODO SOMETHING   
    }  
    private void init() {  
        webView = (WebView) findViewById(R.id.webView);   
        webView.setLayerType(View.LAYER_TYPE_HARDWARE, null);
        //webView.loadUrl("file:///android_asset/index.html");   
        webView.loadUrl("http://101.201.104.27/m3u8/");  
        webView.addJavascriptInterface(new JsInteration(), "control");
        webView.setWebViewClient(new WebViewClient(){  
            @Override  
            public boolean shouldOverrideUrlLoading(WebView view, String url) {   
                view.loadUrl(url);  
                return true;  
            }  
			
			@Override  
			public void onPageFinished(WebView view, String url) {  
				super.onPageFinished(view, url);    
			}   
        });  
		//webView.setLayerType(View.LAYER_TYPE_HARDWARE, null); 
        WebSettings settings = webView.getSettings();  
        settings.setJavaScriptEnabled(true); 		
        //WebView加载页面优先使用缓存加载  
        settings.setCacheMode(WebSettings.LOAD_NO_CACHE);  
        webView.setWebChromeClient(new WebChromeClient() {  
            @Override  
            public void onShowCustomView(View view, CustomViewCallback callback) {  
                super.onShowCustomView(view, callback);  
            }  
        });   
    }  
  
}
