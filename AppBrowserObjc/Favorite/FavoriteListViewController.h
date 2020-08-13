//
//  FavoriteListViewController.h
//  AppBrowserObjc
//
//  Created by Fabio Lindemberg on 13/08/20.
//  Copyright © 2020 Fabio Lindemberg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FavoriteListViewController : UITableViewController

@property NSArray<NSString*> *favoriteList;
@property (strong, nonatomic) IBOutlet UITableView *tbFavorites;
@end

NS_ASSUME_NONNULL_END
