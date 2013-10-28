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
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    [self.applicationReferenceLabel setText:details.applicationReference];
    [self.applicationEmailLabel setText:details.applicationEmail];
    [self.applicationDeadlineLabel setText:[formatter stringFromDate:details.applicationDeadline]];
    [self.applicationInformationLabel setText:details.applicationInformation];
    
    [self.employerNameLabel setText:details.employerName];
    [self.employerZipCodeLabel setText:details.employerZipCode];
    [self.employerAddressLabel setText:details.employerAddress];
    [self.employerCityLabel setText:details.employerCity];
    [self.employerCountryLabel setText:details.employerCountry];
    [self.employerVisitorAddressLabel setText:details.employerVisitorAddress];
    [self.employerVisitorCityLabel setText:details.employerVisitorCity];
    [self.employerPhoneNumberLabel setText:details.employerPhoneNumber];
    [self.employerFaxNumberLabel setText:details.employerFaxNumber];
    [self.employerEmailLabel setText:details.employerEmail];
    [self.employerWebsiteLabel setText:details.employerWebsite];
    
    UITableView *view = (UITableView *)self.view;
    [view reloadData];
}

@end
