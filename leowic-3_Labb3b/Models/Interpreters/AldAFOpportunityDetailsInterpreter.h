//
//  AldAFOpportunityDetailsInterpreter.h
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 28/10/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldJSONInterpreter.h"

@interface AldAFOpportunityDetailsInterpreter : AldJSONInterpreter

-(id) interpretJSONDictionary: (NSDictionary *)data;

@end
