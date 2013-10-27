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

-(NSString *) dataModelSignalIdentifier
{
    return kAldDataModelSignalCounties;
}

-(NSArray *) entitiesFromModel
{
    return self.model.counties.data;
}

-(NSString *) titleForEntity: (id)entity
{
    return [entity name];
}

-(void) requestDataFromModel: (AldDataModel *)model
{
    [model requestCounties];
}

-(void) initCell: (UITableViewCell *)cell withData: (id)entity
{
    AldAFInfoContainer *city = (AldAFInfoContainer *)entity;
    
    cell.textLabel.text = city.name;
}

#pragma mark Segue selectors

-(void) prepareForSegue: (UIStoryboardSegue *)segue sender: (id)sender
{
    if ([[segue identifier] isEqualToString:@"officeSelection"]) {
        AldOfficeSelectionViewController *nextController = (AldOfficeSelectionViewController *)segue.destinationViewController;
        [nextController setCounty:[self selectedData]];
    }
}

@end
