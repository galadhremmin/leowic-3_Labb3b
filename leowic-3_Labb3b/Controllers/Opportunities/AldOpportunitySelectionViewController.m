//
//  AldOpportunitySelectionViewController.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/23/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldOpportunitySelectionViewController.h"
#import "AldDataModelConstants.h"
#import "AldAFOpportunity.h"

@implementation AldOpportunitySelectionViewController

#pragma mark - View events

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:self.opportunityCategory.name];
}

-(void) viewWillDisappear: (BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark - AldAlphabeticSelectionViewController command selectors

-(NSString *) dataModelSignalIdentifier
{
    return kAldDataModelSignalDefault;
}

-(NSArray *) entitiesFromModel
{
    return nil;
}

-(NSString *) titleForEntity: (id)entity
{
    return [entity name];
}

-(void) requestDataFromModel: (AldDataModel *)model
{
    if (_opportunityCategory != nil) {
        [model requestOpportunitiesForCategory:_opportunityCategory inCity:_city searchQuery:nil];
    } else {
        [model requestOpportunitiesForField:_opportunityField inCity:_city searchQuery:nil];
    }
}

-(void) initCell: (UITableViewCell *)cell withData: (id)entity
{
    AldAFOpportunity *opportunity = (AldAFOpportunity *)entity;
    
    cell.textLabel.text = opportunity.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@. %d platser.", opportunity.companyName, opportunity.numberOfVacancies];
    
    /* Acquiring logos - do this asynchronously instead!
    NSString *url =[NSString stringWithFormat:@"http://api.arbetsformedlingen.se/platsannons/%@/logotyp", opportunity.entityId];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    if (data != nil) {
        cell.imageView.image = [UIImage imageWithData:data];
    }
    */
}

#pragma mark - Search selectors

-(void) performSearchWithString: (NSString *)searchQuery
{
    AldDataModel *model = self.model;
    
    if (_opportunityCategory != nil) {
        [model requestOpportunitiesForCategory:_opportunityCategory inCity:_city searchQuery:searchQuery];
    } else {
        [model requestOpportunitiesForField:_opportunityField inCity:_city searchQuery:searchQuery];
    }
}

@end
