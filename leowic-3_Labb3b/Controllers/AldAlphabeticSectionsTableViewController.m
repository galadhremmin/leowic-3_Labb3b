//
//  AldSectionedTableViewController.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/23/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldAlphabeticSectionsTableViewController.h"
#import "AldDataModel.h"
#import "AldDataModelConstants.h"

@interface AldAlphabeticSectionsTableViewController ()

@property (nonatomic, strong) NSDictionary *data;

@end

@implementation AldAlphabeticSectionsTableViewController

#pragma mark - Generate data

-(NSString *) dataModelSignalIdentifier
{
    [NSException raise:@"Not implemented!" format:@"dataModelSignalIdentifier must be implemeted."];
    return nil;
}

-(NSArray *) entitiesFromModel
{
    [NSException raise:@"Not implemented!" format:@"entitiesFromModel must be implemented. "];
    return nil;
}

-(NSString *) titleForEntity: (id)entity
{
    [NSException raise:@"Not implemented!" format:@"titleForEntity: must be implemented. "];
    return nil;
}

-(void) requestDataFromModel: (AldDataModel *)model
{
    [NSException raise:@"Not implemented!" format:@"requestDataFromModel: must be implemented."];
}

-(void) modelDataLoaded: (NSNotification *)notification
{
    id userInfo = [notification.userInfo objectForKey:[self dataModelSignalIdentifier]];
    if (userInfo == nil) {
        [self populateFromModel];
    } else {
        [self populateEntities:userInfo];
    }
}

-(void) modelDataLoadingFailed: (NSNotification *)notification
{
    if (self.view.hidden) {
        return;
    }
    
    NSString *message = [notification.userInfo objectForKey:@"localizedDescription"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oj! Något gick fel!" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
}

-(void) populateFromModel
{
    NSArray *entities = [self entitiesFromModel];
    if (entities == nil) {
        return;
    }
    
    [self populateEntities:entities];
}


-(void) populateEntities:(NSArray *)entities
{
    _data = [NSMutableDictionary dictionary];

    // Sort the array
    NSArray *sortedEntities = [entities sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

    // Build the data source
    for (AldAFOffice *entity in sortedEntities) {
        
        // try to find a section associated with the specified entity name
        NSString *section = [NSString stringWithFormat:@"%d", [self sectionIndexForTitle:[self titleForEntity:entity]]];
        
        // Append or create a new section array?
        NSMutableArray *array = [_data objectForKey:section];
        if (array == nil) {
            array = [NSMutableArray arrayWithObject:entity];
        } else {
            [array addObject:entity];
        }
        
        [_data setValue:array forKey:section];
    }
    
    UITableView *view = (UITableView *)self.view;
    [view reloadData];
}

#pragma mark - View events

-(void) viewDidLoad
{
    _model = [AldDataModel defaultModel];
}

-(void) viewDidAppear: (BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modelDataLoaded:) name:[self dataModelSignalIdentifier] object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modelDataLoadingFailed:) name:kAldDataModelSignalError object:nil];
    
    [self requestDataFromModel:_model];
    _displayingSearchResults = NO;
}

-(void) viewWillDisappear: (BOOL)animated
{
    // Hide the keyboard if it is active.
    [self.searchBar resignFirstResponder];
    _displayingSearchResults = NO;
}

-(void) viewDidDisappear: (BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    if (self.view.hidden) {
        // If the view is hidden, release the data collection.
        _data = nil;
    }
}

#pragma mark - Table view data source

-(NSArray *) sectionIndexTitlesForTableView: (UITableView *)tableView {
    return @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"Å",@"Ä",@"Ö",@"-"];
}

-(NSInteger) sectionIndexForTitle: (NSString *)title
{
    unichar c = [[title uppercaseString] characterAtIndex:0];
    switch (c) {
        case L'Å':
            return 26;
        case L'Ä':
            return 27;
        case L'Ö':
            return 28;
        default: {
            int i = c - 'A';
            if (i < 0 || i > 25) {
                return 29;
            }
            
            return i;
        }
    }
}

-(NSInteger) numberOfSectionsInTableView: (UITableView *)tableView
{
    return 30;
}

-(NSString *) tableView: (UITableView *)tableView titleForHeaderInSection: (NSInteger)section
{
    if ([self tableView:(UITableView *)self.view numberOfRowsInSection:section] < 1) {
        return nil;
    }
    
    switch (section) {
        case 26:
            return @"Å";
        case 27:
            return @"Ä";
        case 28:
            return @"Ö";
        case 29:
            return @"-";
        default: {
            unichar c = L'A' + section;
            return [NSString stringWithFormat:@"%C", c];
        }
    }
}

-(NSInteger) tableView: (UITableView *)tableView sectionForSectionIndexTitle: (NSString *)title atIndex: (NSInteger)index
{
    return [self sectionIndexForTitle:title];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger)section
{
    if (_data == nil) {
        return 0;
    }
    
    NSArray *entities = [_data objectForKey:[NSString stringWithFormat:@"%d", section]];
    if (entities == nil) {
        return 0;
    }
    
    return entities.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSArray *entities = [_data objectForKey:[NSString stringWithFormat:@"%d", indexPath.section]];
    if (entities == nil) {
        return nil;
    }
    
    id entity = [entities objectAtIndex:indexPath.row];
    [self initCell:cell withData:entity];
    
    return cell;
}

-(void) initCell: (UITableViewCell *)cell withData: (id)entity
{
    [NSException raise:@"Not implemented!" format:@"initCell:withData: must be implemented."];
}

#pragma mark - Data selection selectors

-(id) selectedData
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if (indexPath == nil) {
        return nil;
    }
    
    NSArray *entities = [_data objectForKey:[NSString stringWithFormat:@"%d", indexPath.section]];
    if (entities == nil) {
        return nil;
    }
    
    return [entities objectAtIndex:indexPath.row];
}

#pragma mark - Search delegation

-(void) performSearchWithString: (NSString *)searchQuery
{
    [NSException raise:@"Not implemented!" format:@"search:withModel: must be implemented."];
}

// called when keyboard search button pressed
-(void) searchBarSearchButtonClicked: (UISearchBar *)searchBar
{
    _displayingSearchResults = YES;
    [self performSearchWithString:searchBar.text];
}

// called when bookmark button pressed
-(void) searchBarBookmarkButtonClicked: (UISearchBar *)searchBar
{
    
}

// called when cancel button pressed
-(void) searchBarCancelButtonClicked: (UISearchBar *)searchBar
{
    [searchBar setText:@""];
    [searchBar resignFirstResponder];
    [self requestDataFromModel:_model];
    _displayingSearchResults = NO;
}

// called when search results button pressed
-(void) searchBarResultsListButtonClicked: (UISearchBar *)searchBar
{
    
}

@end
