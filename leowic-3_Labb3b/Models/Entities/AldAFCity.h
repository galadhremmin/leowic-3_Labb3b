//
//  AldAFCity.h
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/23/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AldJSONEntityProtocol.h"

@interface AldAFCity : NSObject<AldJSONEntityProtocol>

@property(nonatomic, copy) NSString   *entityId;
@property(nonatomic, copy) NSString   *name;
@property(nonatomic)       NSInteger   amountOfAds;
@property(nonatomic)       NSInteger   amountOfOpportunities;

@end
