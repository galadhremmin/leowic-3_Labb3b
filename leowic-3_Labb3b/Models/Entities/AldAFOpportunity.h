//
//  AldAFOpportunity.h
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 26/10/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AldJSONEntityProtocol.h"

@interface AldAFOpportunity : NSObject<AldJSONEntityProtocol>

@property(nonatomic, copy)   NSString   *entityId;
@property(nonatomic, copy)   NSString   *name;
@property(nonatomic, copy)   NSString   *roleName;
@property(nonatomic, copy)   NSString   *companyName;
@property(nonatomic, strong) NSDate     *publishDate;
@property(nonatomic)         NSInteger   relevanceLevel;
@property(nonatomic)         NSInteger   numberOfVacancies;

@end
