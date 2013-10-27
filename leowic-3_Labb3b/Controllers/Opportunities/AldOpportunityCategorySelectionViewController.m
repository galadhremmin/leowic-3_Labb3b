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

#pragma mark - View events

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:self.city.name];
}

#pragma mark - AldAlphabeticSelectionViewController command selectors

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
        
        // A bit of a sloppy implementation due to time constraints -
        // this control can and will display two different forms of
        // entities depending on the selected data source at the time.
        // Unfortunately, it's impossible to distinguish the two entities
        // from one another as they are structurally the same.
        //
        // For this reason, use the search flag to determine the data
        // source while feeding the right field or category to the
        // next controller. 
        id data = [self selectedData];
        if (self.displayingSearchResults) {
            [nextController setOpportunityCategory:nil];
            [nextController setOpportunityField:data];
        } else {
            [nextController setOpportunityCategory:data];
            [nextController setOpportunityField:nil];
        }
    }
}

@end
