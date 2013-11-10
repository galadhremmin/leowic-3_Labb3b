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
#import "AldPhoneInteraction.h"
#import "AldMapViewController.h"

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
    
    [self.nameLabel                   setText:details.name];
    [self.roleDescriptionLabel        setText:details.roleDescription];
    [self.roleNameLabel               setText:details.roleName];
    [self.numberOfVacanciesLabel      setText:[NSString stringWithFormat:@"%d", details.numberOfVacancies]];
    [self.publishDateLabel            setText:[formatter stringFromDate:details.publishDate]];
    [self.cityNameLabel               setText:details.cityName];
    
    [self.durationLabel               setText:details.duration];
    [self.workHoursLabel              setText:details.workHours];
    [self.workHoursSpanLabel          setText:details.workHoursSpan];
    [self.workPeriodBeginsLabel       setText:details.workPeriodBegins];
    [self.salaryTypeLabel             setText:details.salaryType];
    [self.salaryFormLabel             setText:details.salaryForm];
    
    [self.applicationReferenceLabel   setText:details.applicationReference];
    [self.applicationEmailLabel       setText:details.applicationEmail];
    [self.applicationDeadlineLabel    setText:[formatter stringFromDate:details.applicationDeadline]];
    [self.applicationInformationLabel setText:details.applicationInformation];
    
    [self.employerNameLabel           setText:details.employerName];
    [self.employerZipCodeLabel        setText:details.employerZipCode];
    [self.employerAddressLabel        setText:details.employerAddress];
    [self.employerCityLabel           setText:details.employerCity];
    [self.employerCountryLabel        setText:details.employerCountry];
    [self.employerVisitorAddressLabel setText:details.employerVisitorAddress];
    [self.employerVisitorCityLabel    setText:details.employerVisitorCity];
    [self.employerPhoneNumberLabel    setText:details.employerPhoneNumber];
    [self.employerFaxNumberLabel      setText:details.employerFaxNumber];
    [self.employerEmailLabel          setText:details.employerEmail];
    [self.employerWebsiteLabel        setText:details.employerWebsite];
    
    UITableView *view = (UITableView *)self.view;
    [view reloadData];
}

#pragma mark - UITableViewDelegate

-(NSIndexPath *) tableView: (UITableView *)tableView willSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    UITableView *view = (UITableView *)self.view;
    UITableViewCell *cell = [view cellForRowAtIndexPath:indexPath];
    
    if ([cell.reuseIdentifier isEqualToString:@"PhoneCell"]) {
        [AldPhoneInteraction performCall:cell.detailTextLabel.text];
    }
    else if ([cell.reuseIdentifier isEqualToString:@"EmailCell"]) {
        [AldPhoneInteraction composeEmail:cell.detailTextLabel.text];
    }
    
    return indexPath;
}

-(void) tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Segue nagivation

-(void) prepareForSegue: (UIStoryboardSegue *)segue sender: (id)sender
{
    if ([[segue identifier] isEqualToString:@"map"]) {
        NSString *address = self.employerAddressLabel.text;
        if ([address isEqualToString:@""]) {
            address = self.employerVisitorAddressLabel.text;
        }
        
        NSString *country = self.employerCountryLabel.text;
        if ([country isEqualToString:@""]) {
            country = @"Sweden";
        }
        
        NSString *fullAddress = [NSString stringWithFormat:@"%@, %@, %@ %@, %@", self.employerNameLabel.text, address, self.employerCityLabel.text, self.employerZipCodeLabel.text, country];
     
        AldMapViewController *nextController = (AldMapViewController *)segue.destinationViewController;
        [nextController setAddress:fullAddress];
    }
}

@end
