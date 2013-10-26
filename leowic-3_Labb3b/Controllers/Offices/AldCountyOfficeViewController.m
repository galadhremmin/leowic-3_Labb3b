//
//  AldMasterViewController.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldCountyOfficeViewController.h"
#import "AldOfficeSelectionViewController.h"
#import "AldDataModelConstants.h"

@implementation AldCountyOfficeViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveCountyArray:) name:kAldDataModelSignalCounties object:nil];
    
    _model = [AldDataModel defaultModel];
    [_model requestCounties];
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
    
    return [_model.counties.data count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    AldAFCounty *object = _model.counties.data[indexPath.row];
    cell.textLabel.text = [object name];
    return cell;
}

#pragma mark - Segue events

-(void) prepareForSegue: (UIStoryboardSegue *)segue sender: (id)sender
{
    if ([[segue identifier] isEqualToString:@"officeSelection"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        id object = self.model.counties.data[indexPath.row];
        
        AldOfficeSelectionViewController *nextController = (AldOfficeSelectionViewController *)segue.destinationViewController;
        [nextController setCounty:object];
    }
}

@end
