//
//  ViewController.h
//  AppBrowserObjc
//
//  Created by Fabio Lindemberg on 08/08/20.
//  Copyright © 2020 Fabio Lindemberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet WKWebView *browser;
@end

