//
//  AldAFOpportunityGroupInterpreter.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 26/10/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldAFInfoContainerInterpreter.h"
#import "AldDataModelConstants.h"
#import "AldAFInfoContainer.h"

@implementation AldAFInfoContainerInterpreter

-(NSString *) interpretationId
{
    return kAldDataModelSignalDefault;
}

-(id) interpretJSONDictionary: (NSDictionary *)data
{
    NSArray *entities = [[data objectForKey:@"soklista"] objectForKey:@"sokdata"];
    if (entities == nil || [entities count] < 1) {
        return nil;
    }
    
    NSMutableArray *result = [NSMutableArray array];
    
    for (NSDictionary *entityData in entities) {
        AldAFInfoContainer *group = [[AldAFInfoContainer alloc] initWithDictionary:entityData];
        [result addObject:group];
    }
    
    return result;
}

@end
