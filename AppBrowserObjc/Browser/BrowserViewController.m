//
//  ViewController.m
//  AppBrowserObjc
//
//  Created by Fabio Lindemberg on 08/08/20.
//  Copyright © 2020 Fabio Lindemberg. All rights reserved.
//

#import "BrowserViewController.h"
#import "FavoriteListViewController.h"

@interface BrowserViewController () <UITextFieldDelegate, WKNavigationDelegate>

@end

@implementation BrowserViewController

NSMutableArray<NSString*>* favoriteList;
NSString const *favoriteListKey = @"favoriteList";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    favoriteList = [NSMutableArray<NSString*> new];
    self.tfAddress.delegate = self;
    [self.browser setNavigationDelegate: self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadPageFromNotification:)
                                                 name:@"LOADPAGE"
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self loadFavorites];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    
    self.tfAddress.text = @"https://github.com/fabiolindemberg";
    [self loadPageWithStringUrl: self.tfAddress.text];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear: animated];
}

# pragma mark - Custom Methods

- (void) loadPageWithStringUrl: (NSString*) url {
    
    NSURLRequest *request = [NSURLRequest requestWithURL: [[NSURL alloc] initWithString: url]];

    [self.browser loadRequest: request];
}

- (IBAction)goFoward:(id)sender {
    [self.browser goForward];
}

- (IBAction)goBack:(id)sender {
    [self.browser goBack];
}

- (void) loadPageFromNotification:(NSNotification*)notification {
    
    NSString *favorite = [notification object];
    [self loadPageWithStringUrl: favorite];
}

#pragma mark - Favorite Methods

- (IBAction)showFavoriteList:(id)sender {
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    FavoriteListViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"FavoriteListView"];
    vc.favoriteList = favoriteList;
    
    [self presentViewController: vc animated:YES completion:nil];
}

- (IBAction)favorite:(UIButton *)sender {
    
    if ([self.tfAddress.text isEqualToString: @""]) { return; }
    
    [self searchFavoriteUrl:self.tfAddress.text withCompletion:^(BOOL isFavorite) {
        
        if (isFavorite) {
            
            [favoriteList removeObject: self.tfAddress.text];
            [self toogleFavorite: NO];
        } else {
            
            [favoriteList addObject:self.tfAddress.text];
            [self toogleFavorite: YES];
        }
        
        [self saveFavorites];
        [self loadFavorites];
    }];
}

- (void) searchFavoriteUrl: (NSString *) url withCompletion: (void(^)(BOOL isFavorite)) completion {
    
    for (NSString *favorite in favoriteList) {
        
        if ([favorite isEqualToString: url]) {
            
            completion(YES);
            return;
        }
    }
    completion(NO);
}

- (void) loadFavorites {
    
    NSArray<NSString*>* savedList = [[NSUserDefaults standardUserDefaults] arrayForKey: favoriteListKey];
    
    if (savedList) {
        [favoriteList addObjectsFromArray: savedList];
    }
}

- (void) saveFavorites {
    [[NSUserDefaults standardUserDefaults] setObject: favoriteList forKey: favoriteListKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) toogleFavorite: (BOOL) isFavorite {

    UIImage *image =  isFavorite ? [UIImage systemImageNamed: @"bookmark.fill"] : [UIImage systemImageNamed: @"bookmark"];
    [self.btnFavorite setImage: image forState:normal];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    NSString *url;
    
    if (![textField.text containsString: @"https://"] || [textField.text containsString: @"http://"]) {
        url = [[NSString stringWithFormat:@"https://%@", textField.text] lowercaseString];
    } else {
        url = [textField.text lowercaseString];;
    }
    
    [self loadPageWithStringUrl: url];
    
    return true;
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    self.tfAddress.text = webView.URL.absoluteString;
    
    [self searchFavoriteUrl: self.tfAddress.text withCompletion:^(BOOL isFavorite) {
        [self toogleFavorite: isFavorite];
    }];
}

@end
