//
//  ViewController.m
//  AppBrowserObjc
//
//  Created by Fabio Lindemberg on 08/08/20.
//  Copyright © 2020 Fabio Lindemberg. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    
    NSURLRequest *request = [NSURLRequest requestWithURL: [[NSURL alloc] initWithString:@"https://github.com/fabiolindemberg"]];

    [self.browser loadRequest: request];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear: animated];
}

# pragma mark - Custom Methods

- (IBAction)goFoward:(id)sender {
    [self.browser goForward];
}

- (IBAction)goBack:(id)sender {
    [self.browser goBack];
}



@end
