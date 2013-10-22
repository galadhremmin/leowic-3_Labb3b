//
//  AldOfficeDetailsViewController.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AldOfficeDetailsViewController.h"
#import "AldDataModelConstants.h"
#import "AldDataModel.h"
#import "AldAFOfficeDetails.h"

@interface AldOfficeDetailsViewController ()

@property (nonatomic, strong) AldDataModel *model;

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) openMap
{
    AldAFOfficeDetails *details = [_model.offices.data objectForKey:self.office.entityId];
    NSString *locationString = [NSString stringWithFormat:@"%@, %@, Sweden", details.visitorAddress, details.visitorCity];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:locationString
                 completionHandler:^(NSArray *placemarks, NSError *error) {
                     
                     // Convert the CLPlacemark to an MKPlacemark
                     // Note: There's no error checking for a failed geocode
                     CLPlacemark *geocodedPlacemark = [placemarks objectAtIndex:0];
                     MKPlacemark *placemark = [[MKPlacemark alloc]
                                               initWithCoordinate:geocodedPlacemark.location.coordinate
                                               addressDictionary:geocodedPlacemark.addressDictionary];
                     
                     // Create a map item for the geocoded address to pass to Maps app
                     MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
                     [mapItem setName:geocodedPlacemark.name];
                     
                     // Pass the current location and destination map items to the Maps app
                     // Set the direction mode in the launchOptions dictionary
                     [MKMapItem openMapsWithItems:@[mapItem] launchOptions:nil];
                     
                 }];
}

-(void) call: (NSString *)number
{
    NSString *cleanedString = [[number componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", cleanedString]];
    
    [[UIApplication sharedApplication] openURL:URL];
    NSLog(@"Phone call URL: %@.", URL);
}

#pragma mark - UITableViewDelegate

-(NSIndexPath *) tableView: (UITableView *)tableView willSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    UITableView *view = (UITableView *)self.view;
    UITableViewCell *cell = [view cellForRowAtIndexPath:indexPath];
    
    switch (indexPath.section * 10 + indexPath.row) {
        case 4:
            [self openMap];
            break;
        case 21:
        case 31:
            [self call:cell.detailTextLabel.text];
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
    
    [_visitorAddressLabel setText:details.visitorAddress];
    [_visitorCityLabel setText:details.visitorCity];
    [_selfServiceHoursLabel setText:details.selfServiceHours];
    [_personalServiceHoursLabel setText:details.personalServiceHours];
    [_postAddressLabel setText:details.mailAddress];
    [_postZipCodeLabel setText:details.mailZipcode];
    [_postCityAddress setText:details.mailCity];
    [_mailAddressLabel setText:details.email];
    [_phoneLabel setText:details.publicPhoneNumber];
    [_phoneHoursLabel setText:details.phoneHours];
    [_managerNameLabel setText:details.managerName];
    [_employerPhoneLabel setText:details.employerPhoneNumber];
    [_faxNumberLabel setText:details.faxNumber];
    
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

@end
