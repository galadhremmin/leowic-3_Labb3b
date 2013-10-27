//
//  AldAFOpportunityDetails.h
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 27/10/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AldJSONEntityProtocol.h"

@interface AldAFOpportunityDetails : NSObject<AldJSONEntityProtocol>

@property(nonatomic, copy)   NSString   *entityId;
@property(nonatomic, copy)   NSString   *name;
@property(nonatomic, copy)   NSString   *roleDescription;
@property(nonatomic, copy)   NSString   *roleName;
@property(nonatomic, copy)   NSString   *opportunityFieldId;
@property(nonatomic, strong) NSDate     *publishDate;
@property(nonatomic)         NSInteger   numberOfVacancies;

@property(nonatomic, copy)   NSString   *cityName;
@property(nonatomic, copy)   NSString   *duration;
@property(nonatomic, copy)   NSString   *workHours;
@property(nonatomic, copy)   NSString   *workHoursSpan;
@property(nonatomic, copy)   NSString   *salaryType;
@property(nonatomic, copy)   NSString   *salaryForm;

@property(nonatomic, copy)   NSString   *applicationReference;
@property(nonatomic, copy)   NSString   *applicationEmail;
@property(nonatomic, copy)   NSString   *applicationInformation;

@property(nonatomic, copy)   NSString   *employerName;
@property(nonatomic, copy)   NSString   *employerZipCode;
@property(nonatomic, copy)   NSString   *employerAddress;
@property(nonatomic, copy)   NSString   *employerCity;
@property(nonatomic, copy)   NSString   *employerCountry;
@property(nonatomic, copy)   NSString   *employerVisitorAddress;
@property(nonatomic, copy)   NSString   *employerVisitorCity;
@property(nonatomic, copy)   NSString   *employerPhoneNumber;
@property(nonatomic, copy)   NSString   *employerFaxNumber;
@property(nonatomic, copy)   NSString   *employerEmail;
@property(nonatomic, copy)   NSString   *employerWebsite;

-(NSComparisonResult) localizedCaseInsensitiveCompare: (AldAFOpportunityDetails *)other;

@end
