//
//  AldCitySelectionViewController.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/23/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldCitySelectionViewController.h"
#import "AldOpportunityCategorySelectionViewController.h"
#import "AldDataModelConstants.h"
#import "AldAFInfoContainer.h"

@implementation AldCitySelectionViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:self.county.name];
}

-(NSString *) dataModelSignalIdentifier
{
    return kAldDataModelSignalCity;
}

-(NSArray *) entitiesFromModel
{
    return [self.model.citiesInCounties.data objectForKey:self.county.entityId];
}

-(NSString *) titleForEntity: (id)entity
{
    return [entity name];
}

-(void) requestDataFromModel: (AldDataModel *)model
{
    [model requestCitiesInCounty:self.county];
}

-(void) initCell: (UITableViewCell *)cell withData: (id)entity
{
    AldAFInfoContainer *city = (AldAFInfoContainer *)entity;
    
    cell.textLabel.text = city.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d annonser. %d lediga jobb.", city.amountOfAds, city.amountOfOpportunities];
}

#pragma mark Segue selectors

-(void) prepareForSegue: (UIStoryboardSegue *)segue sender: (id)sender
{
    if ([[segue identifier] isEqualToString:@"opportunityCategory"]) {
        AldOpportunityCategorySelectionViewController *nextController = (AldOpportunityCategorySelectionViewController *)segue.destinationViewController;
        [nextController setCity:[self selectedData]];
    }
}

@end
