//
//  AldAFCity.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/23/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldAFCity.h"

@implementation AldAFCity

-(id) initWithDictionary: (NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setEntityId:               [dict objectForKey:@"id"]];
        [self setName:                   [dict objectForKey:@"namn"]];
        [self setAmountOfAds:           [[dict objectForKey:@"antal_platsannonser"] integerValue]];
        [self setAmountOfOpportunities: [[dict objectForKey:@"antal_ledigajobb"] integerValue]];
    }
    
    return self;
}

@end
