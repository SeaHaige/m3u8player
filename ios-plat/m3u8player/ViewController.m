//
//  ViewController.m
//  m3u8player
//
//  Created by PPeasy on 2018/6/13.
//  Copyright © 2018年 PPeasy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    //webView.allowsInlineMediaPlayback = YES;
    //[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://101.201.104.27/m3u8/"]]];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlPath]]];
    [self.view addSubview:webView];
    
     }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
