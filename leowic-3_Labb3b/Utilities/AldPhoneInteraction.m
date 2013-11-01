//
//  AldPhoneInteraction.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 01/11/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AldPhoneInteraction.h"

@implementation AldPhoneInteraction

+(void) displayMapForLocation: (NSString *)address
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:address
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

+(void) performCall: (NSString *)number
{
    NSString *cleanedString = [[number componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", cleanedString]];
    
    [[UIApplication sharedApplication] openURL:URL];
    NSLog(@"Phone call URL: %@.", URL);
}

+(void) composeEmail: (NSString *)email
{
    NSString *url = [NSString stringWithFormat:@"mailto:%@", email];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

@end
