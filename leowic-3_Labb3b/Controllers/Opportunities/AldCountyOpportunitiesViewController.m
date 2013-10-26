//
//  AldCountyOpportunitiesViewController.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/21/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldCountyOpportunitiesViewController.h"
#import "AldCitySelectionViewController.h"
#import "AldDataModelConstants.h"
#import "AldAFInfoContainer.h"

@implementation AldCountyOpportunitiesViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveCountyArray:) name:kAldDataModelSignalCountiesWithOpportunities object:nil];
    
    _model = [AldDataModel defaultModel];
    [_model requestCountiesWithOpportunities];
}

#pragma mark - Notification center

-(void) receiveCountyArray: (NSNotification *)notification
{
    UITableView *view = (UITableView *)self.view;
    [view reloadData];
}

#pragma mark - Table View

-(NSInteger) numberOfSectionsInTableView: (UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger)section
{
    if (_model.counties == nil) {
        return 0;
    }
    
    return [_model.countiesWithOpportunities.data count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    AldAFInfoContainer *object = _model.countiesWithOpportunities.data[indexPath.row];
    cell.textLabel.text = [object name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d annonser. %d lediga jobb.", object.amountOfAds, object.amountOfOpportunities];

    return cell;
}

#pragma mark - Segue events

-(void) prepareForSegue: (UIStoryboardSegue *)segue sender: (id)sender
{
    if ([[segue identifier] isEqualToString:@"citySelection"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        id object = [self.model.counties.data objectAtIndex:indexPath.row];
        
        AldCitySelectionViewController *nextController = (AldCitySelectionViewController *)segue.destinationViewController;
        [nextController setCounty:object];
    }
}

@end
