//
//  AldModelledData.h
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/21/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AldModelledData : NSObject

@property (nonatomic) CFAbsoluteTime lastUpdate;
@property (nonatomic, strong) id data;

-(id) initWithData: (id)data;
-(id) initWithData: (id)data forKey: (NSString *)dataKey;
-(id) searchForEntityWithId: (NSString *)entityId;

@end
