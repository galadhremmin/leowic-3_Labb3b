//
//  AldOpportunityCategorySelectionViewController.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 26/10/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldOpportunityCategorySelectionViewController.h"
#import "AldDataModelConstants.h"
#import "AldOpportunitySelectionViewController.h"

@implementation AldOpportunityCategorySelectionViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:self.city.name];
}

-(NSString *) dataModelSignalIdentifier
{
    return kAldDataModelSignalOpportunityCategories;
}

-(NSArray *) entitiesFromModel
{
    return self.model.opportunityCategories.data;
}

-(NSString *) titleForEntity: (id)entity
{
    return [entity name];
}

-(void) requestDataFromModel: (AldDataModel *)model
{
    [model requestOpportunityCategories];
}

-(void) initCell: (UITableViewCell *)cell withData: (id)entity
{
    AldAFInfoContainer *category = (AldAFInfoContainer *)entity;
    cell.textLabel.text = category.name;
}

#pragma mark - Search selectors

-(void) performSearchWithString: (NSString *)searchQuery
{
    [self.model requestOpportunityCategoriesForString:searchQuery];
}

#pragma mark - Segue selectors

-(void) prepareForSegue: (UIStoryboardSegue *)segue sender: (id)sender
{
    if ([[segue identifier] isEqualToString:@"opportunity"]) {
        AldOpportunitySelectionViewController *nextController = (AldOpportunitySelectionViewController *)segue.destinationViewController;
        [nextController setCity:_city];
        [nextController setOpportunityCategory:[self selectedData]];
    }
}

@end
