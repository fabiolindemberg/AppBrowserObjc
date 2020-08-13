//
//  FavoriteListViewController.m
//  AppBrowserObjc
//
//  Created by Fabio Lindemberg on 13/08/20.
//  Copyright © 2020 Fabio Lindemberg. All rights reserved.
//

#import "FavoriteListViewController.h"

@interface FavoriteListViewController ()

@end

@implementation FavoriteListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self.tbFavorites reloadData];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear: animated];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.favoriteList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.favoriteList[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LOADPAGE" object: self.favoriteList[indexPath.row]];
    }];
}

@end
