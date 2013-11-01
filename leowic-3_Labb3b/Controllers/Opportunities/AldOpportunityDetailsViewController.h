//
//  AldOpportunityDetailsViewController.h
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 28/10/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AldAFOpportunity.h"

@interface AldOpportunityDetailsViewController : UITableViewController<UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *roleNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *roleDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfVacanciesLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *publishDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *workHoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *workHoursSpanLabel;
@property (weak, nonatomic) IBOutlet UILabel *salaryTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *salaryFormLabel;
@property (weak, nonatomic) IBOutlet UILabel *workPeriodBeginsLabel;


@property (weak, nonatomic) IBOutlet UILabel *applicationReferenceLabel;
@property (weak, nonatomic) IBOutlet UILabel *applicationEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *applicationDeadlineLabel;
@property (weak, nonatomic) IBOutlet UILabel *applicationInformationLabel;

@property (weak, nonatomic) IBOutlet UILabel *employerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *employerZipCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *employerAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *employerCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *employerCountryLabel;
@property (weak, nonatomic) IBOutlet UILabel *employerVisitorAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *employerVisitorCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *employerPhoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *employerFaxNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *employerEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *employerWebsiteLabel;

@property(nonatomic, weak) AldAFOpportunity *opportunity;

@end
