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


-(NSString *) dataModelSignalIdentifier
{
    return kAldDataModelSignalCountiesWithOpportunities;
}

-(NSArray *) entitiesFromModel
{
    return self.model.countiesWithOpportunities.data;
}

-(NSString *) titleForEntity: (id)entity
{
    return [entity name];
}

-(void) requestDataFromModel: (AldDataModel *)model
{
    [model requestCountiesWithOpportunities];
}

-(void) initCell: (UITableViewCell *)cell withData: (id)entity
{
    AldAFInfoContainer *object = (AldAFInfoContainer *)entity;
    
    cell.textLabel.text = [object name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d annonser. %d lediga jobb.", object.amountOfAds, object.amountOfOpportunities];
}

#pragma mark Segue selectors

-(void) prepareForSegue: (UIStoryboardSegue *)segue sender: (id)sender
{
    if ([[segue identifier] isEqualToString:@"citySelection"]) {
        AldCitySelectionViewController *nextController = (AldCitySelectionViewController *)segue.destinationViewController;
        [nextController setCounty:[self selectedData]];
    }
}

@end
