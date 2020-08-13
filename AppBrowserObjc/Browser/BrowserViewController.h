//
//  ViewController.h
//  AppBrowserObjc
//
//  Created by Fabio Lindemberg on 08/08/20.
//  Copyright © 2020 Fabio Lindemberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface BrowserViewController : UIViewController

@property (weak, nonatomic) IBOutlet WKWebView *browser;
@property (weak, nonatomic) IBOutlet UIButton *btnFavorite;
@property (weak, nonatomic) IBOutlet UIButton *btnFavoriteList;
@property (weak, nonatomic) IBOutlet UITextField *tfAddress;
@end

