//
//  AldAFOpportunityGroupInterpreter.h
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 26/10/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AldJSONInterpreter.h"

@interface AldAFInfoContainerInterpreter : AldJSONInterpreter

-(id) interpretJSONDictionary: (NSDictionary *)data;

@end
