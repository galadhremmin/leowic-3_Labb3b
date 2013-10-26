//
//  AldOpportunityCategorySelectionViewController.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 26/10/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldOpportunityCategorySelectionViewController.h"
#import "AldDataModelConstants.h"

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


@end
