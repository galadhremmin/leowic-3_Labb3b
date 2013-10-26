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

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:self.opportunityCategory.name];
}

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
    [model requestOpportunitiesForCategory:_opportunityCategory inCity:_city];
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

@end
