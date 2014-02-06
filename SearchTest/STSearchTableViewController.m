//
//  STSearchTableViewController.m
//  SearchTest
//
//  Created by Roman Firmach on 06.02.14.
//  Copyright (c) 2014 Roman Firmach. All rights reserved.
//

#import "STSearchTableViewController.h"

@interface STSearchTableViewController ()

@property (strong, nonatomic) NSArray *strings;
@property (strong, nonatomic) NSArray *searchResults;

@end

@implementation STSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.strings = @[@"abc",@"adv",@"arf",@"bcv",@"tttb"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.tableView])
        return [self.strings count];
    else
        return [self.searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    if ([tableView isEqual:self.tableView]) {
        cell.textLabel.text = self.strings[indexPath.row];
    } else {
        cell.textLabel.text = self.searchResults[indexPath.row];
    }
    
    return cell;
}

#pragma mark - UISearchDisplayDelegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    [self filterContentForSearchText:controller.searchBar.text];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString];
    return YES;
}

- (void)filterContentForSearchText:(NSString*)searchText {
    NSPredicate *predicate =
    [NSPredicate predicateWithFormat:@"(SELF contains[cd] %@)", searchText];
    
    self.searchResults = [self.strings filteredArrayUsingPredicate:predicate];
}

@end
