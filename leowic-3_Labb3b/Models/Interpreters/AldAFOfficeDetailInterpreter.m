//
//  AldAFOfficeDetailInterpreter.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldAFOfficeDetailInterpreter.h"
#import "AldAFOfficeDetails.h"
#import "AldDataModelConstants.h"

@implementation AldAFOfficeDetailInterpreter

-(NSString *) interpretationId
{
    return kAldDataModelSignalOffice;
}

-(id) interpretJSONDictionary: (NSDictionary *)data
{
    NSDictionary *officeData = [data objectForKey:@"arbetsformedling"];
    if (officeData == nil) {
        return nil;
    }
    
    return [[AldAFOfficeDetails alloc] initWithDictionary:officeData];
}

@end
