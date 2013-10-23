//
//  AldOfficeSelectionViewController.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldOfficeSelectionViewController.h"
#import "AldOfficeDetailsViewController.h"
#import "AldDataModel.h"
#import "AldAFOffice.h"
#import "AldDataModelConstants.h"

@implementation AldOfficeSelectionViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:self.county.name];
}

-(NSString *) dataModelSignalIdentifier
{
    return kAldDataModelSignalOffices;
}

-(NSArray *) entitiesFromModel
{
    return [self.model.officesInCounties.data objectForKey:self.county.entityId];
}

-(NSString *) titleForEntity: (id)entity
{
    return [entity name];
}

-(void) requestDataFromModel: (AldDataModel *)model
{
    [model requestOfficesInCounty:self.county];
}

-(void) initCell: (UITableViewCell *)cell withData: (id)entity
{
    cell.textLabel.text = [entity name];
}

#pragma mark Segue selectors

-(void) prepareForSegue: (UIStoryboardSegue *)segue sender: (id)sender
{
    if ([[segue identifier] isEqualToString:@"officeDetails"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSArray *offices = [self.model.officesInCounties.data objectForKey:self.county.entityId];
        id object = offices[indexPath.row];
        
        AldOfficeDetailsViewController *nextController = (AldOfficeDetailsViewController *)segue.destinationViewController;
        [nextController setOffice:object];
    }
}


@end
