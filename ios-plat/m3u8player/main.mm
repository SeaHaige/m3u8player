//
//  main.m
//  m3u8player
//
//  Created by PPeasy on 2018/6/13.
//  Copyright © 2018年 PPeasy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
void ppeasy_init_plus();
int main(int argc, char * argv[]) {
    ppeasy_init_plus();
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
