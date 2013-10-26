//
//  AldDataModel.h
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AldAFCounty.h"
#import "AldAFOffice.h"
#import "AldModelledData.h"

@interface AldDataModel : NSObject<NSURLConnectionDelegate>

+(AldDataModel *) defaultModel;

@property(atomic, strong) AldModelledData *counties;
@property(atomic, strong) AldModelledData *countiesWithOpportunities;
@property(atomic, strong) AldModelledData *officesInCounties;
@property(atomic, strong) AldModelledData *citiesInCounties;
@property(atomic, strong) AldModelledData *offices;
@property(atomic, strong) AldModelledData *opportunityCategories;

-(void) requestCounties;
-(void) requestCountiesWithOpportunities;
-(void) requestOfficesInCounty: (AldAFCounty *)county;
-(void) requestCitiesInCounty: (AldAFCounty *)county;
-(void) requestDetailsForOffice: (AldAFOffice *)office;
-(void) requestOpportunityCategories;

@end
