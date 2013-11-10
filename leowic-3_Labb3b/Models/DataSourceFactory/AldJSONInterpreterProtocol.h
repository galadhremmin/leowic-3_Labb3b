//
//  AldJSONInterpreterProtocol.h
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AldJSONInterpreterProtocol <NSObject>

-(NSString *) interpretationId;
-(NSString *) failureLocalizedDescription;
-(id) interpretJSON: (NSData *)data;

@end
