//
//  AldMapViewController.h
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 06/11/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface AldMapViewController : UIViewController

@property(nonatomic, weak) IBOutlet MKMapView *mapView;
@property(nonatomic, copy) NSString *address;

@end
