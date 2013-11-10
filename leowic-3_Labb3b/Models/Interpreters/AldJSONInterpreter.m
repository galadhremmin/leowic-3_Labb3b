//
//  AldJSONInterpreter.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldJSONInterpreter.h"
#import "AldDataModelConstants.h"

@interface AldJSONInterpreter ()

@property (nonatomic, copy) NSString *errorDescription;

@end

@implementation AldJSONInterpreter

-(id) init
{
    self = [super init];
    if (self) {
        _errorDescription = @"Din sökning gav tyvärr inga resultat.";
    }
    
    return self;
}

-(NSString *) interpretationId
{
    return kAldDataModelSignalDefault;
}

-(NSString *) failureLocalizedDescription
{
    return _errorDescription;
}

-(id) interpretJSON: (NSData *)data
{
    NSError *error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (error != nil && error.code) {
        return nil;
    }
    
    // The API is unfortunately inconsistent in terms of error management, but it is known to emit, in some cases,
    // an <Error> node when the request is malformed. Handle this, at least.
    NSDictionary *errorNode = [json objectForKey:@"Error"];
    if (errorNode != nil) {
        _errorDescription = [[errorNode objectForKey:@"beskrivning"] stringValue];
        return nil;
    }
    
    return [self interpretJSONDictionary:json];
}

-(id) interpretJSONDictionary: (NSDictionary *)data
{
    [NSException raise:@"Not implemented" format:@"This selector hasn't been implemented."];
    return nil;
}

@end
