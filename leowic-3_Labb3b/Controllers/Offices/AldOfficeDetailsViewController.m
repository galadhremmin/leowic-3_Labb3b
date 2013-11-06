//
//  AldOfficeDetailsViewController.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldOfficeDetailsViewController.h"
#import "AldDataModelConstants.h"
#import "AldDataModel.h"
#import "AldAFOfficeDetails.h"
#import "AldPhoneInteraction.h"
#import "AldMapViewController.h"

@interface AldOfficeDetailsViewController ()

@property (nonatomic, weak) AldDataModel *model;

@end

@implementation AldOfficeDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveOffice:) name:kAldDataModelSignalOffice object:nil];
    
    [self setTitle:self.office.name];
    
    _model = [AldDataModel defaultModel];
    [_model requestDetailsForOffice:self.office];
    
}

#pragma mark - UITableViewDelegate

-(NSIndexPath *) tableView: (UITableView *)tableView willSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    UITableView *view = (UITableView *)self.view;
    UITableViewCell *cell = [view cellForRowAtIndexPath:indexPath];
    
    switch (indexPath.section * 10 + indexPath.row) {
        case 21:
        case 31:
            [AldPhoneInteraction performCall:cell.detailTextLabel.text];
            break;
    }
    
    return indexPath;
}

-(void) tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Notification center

-(void) receiveOffice: (NSNotification *)notification
{
    AldAFOfficeDetails *details = [_model.offices.data objectForKey:self.office.entityId];
    
    [_visitorAddressLabel       setText:details.visitorAddress];
    [_visitorCityLabel          setText:details.visitorCity];
    [_selfServiceHoursLabel     setText:details.selfServiceHours];
    [_personalServiceHoursLabel setText:details.personalServiceHours];
    [_postAddressLabel          setText:details.mailAddress];
    [_postZipCodeLabel          setText:details.mailZipcode];
    [_postCityAddress           setText:details.mailCity];
    [_mailAddressLabel          setText:details.email];
    [_phoneLabel                setText:details.publicPhoneNumber];
    [_phoneHoursLabel           setText:details.phoneHours];
    [_managerNameLabel          setText:details.managerName];
    [_employerPhoneLabel        setText:details.employerPhoneNumber];
    [_faxNumberLabel            setText:details.faxNumber];
    
    NSString *extraInformation = details.extraInformation;
    
    if (details.extraInformation == nil || [details.extraInformation isEqualToString:@""]) {
        extraInformation = @"Ingen övrig information.";
    }
    
    NSString *html = [NSString stringWithFormat:@"<!DOCTYPE html>"
                      "<html>"
                      "<head>"
                      "<style>*{font:9pt helvetica, sans-serif;}</style>"
                      "</head>"
                      "<body>%@</body>"
                      "</html>", extraInformation];
    
    [_informationWebView loadHTMLString:html baseURL:nil];

    UITableView *view = (UITableView *)self.view;
    [view reloadData];
}

#pragma mark - Segue nagivation

-(void) prepareForSegue: (UIStoryboardSegue *)segue sender: (id)sender
{
    if ([[segue identifier] isEqualToString:@"map"]) {
        AldAFOfficeDetails *details = [_model.offices.data objectForKey:self.office.entityId];
        NSString *fullAddress = [NSString stringWithFormat:@"%@, %@, Sweden", details.visitorAddress, details.visitorCity];
        
        AldMapViewController *nextController = (AldMapViewController *)segue.destinationViewController;
        [nextController setAddress:fullAddress];
    }
}

@end
