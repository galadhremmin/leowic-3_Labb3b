//
//  AldAFOpportunity.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 26/10/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldAFOpportunity.h"

@implementation AldAFOpportunity

-(id) initWithDictionary: (NSDictionary *)dict
{
    self = [super init];
    if (self) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
        NSDate *publishDate = [formatter dateFromString:[dict objectForKey:@"publiceraddatum"]];
        
        [self setEntityId:               [dict objectForKey:@"annonsid"]];
        [self setName:                   [dict objectForKey:@"annonsrubrik"]];
        [self setRoleName:               [dict objectForKey:@"yrkesbenamning"]];
        [self setCompanyName:            [dict objectForKey:@"arbetsplatsnamn"]];
        [self setNumberOfVacancies:      [[dict objectForKey:@"antalplatser"] integerValue]];
        [self setRelevanceLevel:         [[dict objectForKey:@"relevans"] integerValue]];
        [self setPublishDate:            publishDate];
    }
    
    return self;
}

@end
