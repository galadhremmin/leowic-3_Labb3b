//
//  AldMapViewController.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 06/11/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldMapViewController.h"
#import <CoreLocation/CoreLocation.h>

@implementation AldMapViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    if (self.address) {
        __weak MKMapView *view = self.mapView;
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder geocodeAddressString:self.address
                     completionHandler:^(NSArray *placemarks, NSError *error) {
                         
                         // Error checking for a failed geocode
                         if (error) {
                             NSLog(@"Geocode failed with error: %@", error);
                             [self displayError:error];
                             return;
                         }
                         
                         // Convert the CLPlacemark to an MKPlacemark
                         CLPlacemark *geocodedPlacemark = [placemarks objectAtIndex:0];
                         MKPlacemark *placemark = [[MKPlacemark alloc]
                                                   initWithCoordinate:geocodedPlacemark.location.coordinate
                                                   addressDictionary:geocodedPlacemark.addressDictionary];
                         
                         // Establish a region around the center of the found location
                         MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(placemark.location.coordinate, 600, 600); // 600 meter
                         
                         [view setRegion:region animated:NO];
                         [view addAnnotation:placemark];
                     }];
    }
}

-(void) displayError:(NSError *)error
{
    // Make sure to perform the alert view on the main thread
    dispatch_async(dispatch_get_main_queue(),^ {
        NSString *message;
        switch ([error code])
        {
            case kCLErrorGeocodeFoundNoResult:
                message = @"Tyvärr så saknas giltig addressinformation. Ta kontakt med arbetsgivaren.";
                break;
            case kCLErrorGeocodeCanceled:
                message = @"Addressuppslagningen avbröts.";
                break;
            case kCLErrorGeocodeFoundPartialResult:
                message = @"Tyvärr så saknas komplett addressinformation. Ta kontakt med arbetsgivaren.";
                break;
            default:
                message = [error description];
                break;
        }
        
        UIAlertView *alert =  [[UIAlertView alloc] initWithTitle:@"Oj, ett fel har uppstått!"
                                                         message:message
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];;
        [alert show];
    });   
}

@end
