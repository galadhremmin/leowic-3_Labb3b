//
//  AldOpportunityDetailsViewController.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 28/10/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldOpportunityDetailsViewController.h"
#import "AldDataModel.h"
#import "AldDataModelConstants.h"
#import "AldAFOpportunityDetails.h"

@interface AldOpportunityDetailsViewController ()

@property(nonatomic, weak) AldDataModel *model;

@end

@implementation AldOpportunityDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveOpportunity:) name:kAldDataModelSignalOpportunityDetails object:nil];
    
    [self setTitle:self.opportunity.name];
    
    _model = [AldDataModel defaultModel];
    [_model requestOpportunityDetails:self.opportunity];
    
}

-(void) receiveOpportunity: (NSNotification *)notification
{
    AldAFOpportunityDetails *details = (AldAFOpportunityDetails *)[notification.userInfo objectForKey:kAldDataModelSignalOpportunityDetails];
    
    NSLog(@"%@", details);
}

@end
