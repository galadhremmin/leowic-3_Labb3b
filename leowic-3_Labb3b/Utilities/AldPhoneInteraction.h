//
//  AldPhoneInteraction.h
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 01/11/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AldPhoneInteraction : NSObject

+(void) displayMapForLocation: (NSString *)address;
+(void) performCall: (NSString *)number;
+(void) composeEmail: (NSString *)email;

@end
