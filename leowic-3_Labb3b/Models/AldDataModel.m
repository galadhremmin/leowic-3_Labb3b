//
//  AldDataModel.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <CoreFoundation/CoreFoundation.h>
#import "AldDataModelConstants.h"
#import "AldDataModel.h"
#import "AldJSONInterpreterProtocol.h"
#import "AldAFCountyInterpreter.h"
#import "AldAFOfficesInCountyInterpreter.h"
#import "AldAFCitiesInCountyInterpreter.h"
#import "AldAFOfficeDetailInterpreter.h"
#import "AldRequestState.h"
#import "AldModelledData.h"
#import "AldAFInfoContainer.h"
#import "AldAFOpportunityCategoryInterpreter.h"
#import "AldCountiesWithOpportunitiesInterpreter.h"

static AldDataModel *_defaultModel = nil;

@interface AldDataModel() {
    NSMutableSet *_activeConnections;
    CFMutableDictionaryRef _requests;
}

@end

@implementation AldDataModel

+(AldDataModel *) defaultModel
{
    @synchronized(self) {
        if (_defaultModel == nil) {
            _defaultModel = [[AldDataModel alloc] init];
        }
    }
    
    return _defaultModel;
}

-(id) init
{
    self = [super init];
    if (self) {
        _requests = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, NULL, &kCFTypeDictionaryValueCallBacks);
    }
    
    return self;
}

-(void) dealloc
{
    if (_requests) {
        CFRelease(_requests);
        _requests = NULL;
    }
}

-(BOOL) modelData: (AldModelledData *)data isUpToDateWithKey: (NSString *)dataKey
{
    CFAbsoluteTime now = CFAbsoluteTimeGetCurrent();
    
    if ( data == nil) {
        return NO;
    }
    
    // 10 minutes
    if (now - data.lastUpdate > 10 * 60) {
        return NO;
    }
    
    if (dataKey != nil) {
        if ([data.data respondsToSelector:@selector(objectForKey:)]) {
            if ([data.data objectForKey:dataKey] == nil) {
                return NO;
            }
        } else {
            [NSException raise:@"Unrecognised kind of class." format:@"The class %@ doesn't respond to the selector objectForKey which is required for the dataKey constraint.", NSStringFromClass([data.data class])];
        }
    }
    
    return YES;
}

-(void) requestCounties
{
    id interpreter = [[AldAFCountyInterpreter alloc] init];
    
    if ([self modelData:self.counties isUpToDateWithKey:nil]) {
        [self interpreter:interpreter shouldNotifyNewData:nil dependantOnUserData:nil];
        return;
    }
    
    [self enqueueRequestWithURL:@"http://api.arbetsformedlingen.se/arbetsformedling/soklista/lan" withInterpreter:interpreter andUserData:nil];
}

-(void) requestCountiesWithOpportunities
{
    id interpreter = [[AldCountiesWithOpportunitiesInterpreter alloc] init];
    NSString *urlString = @"http://api.arbetsformedlingen.se/platsannons/soklista/lan";
    [self enqueueRequestWithURL:urlString withInterpreter:interpreter andUserData:nil];
}

-(void) requestOfficesInCounty: (AldAFCounty *)county
{
    if (county == nil) {
        return;
    }

    id interpreter = [[AldAFOfficesInCountyInterpreter alloc] init];
    
    if ([self modelData:self.officesInCounties isUpToDateWithKey:county.entityId]) {
        [self interpreter:interpreter shouldNotifyNewData:nil dependantOnUserData:county.entityId];
        return;
    }
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.arbetsformedlingen.se/arbetsformedling/platser?lanid=%@", county.entityId];
    
    [self enqueueRequestWithURL:urlString withInterpreter:interpreter andUserData:county.entityId];
}

-(void) requestCitiesInCounty: (AldAFCounty *)county
{
    if (county == nil) {
        return;
    }
    
    id interpreter = [[AldAFCitiesInCountyInterpreter alloc] init];
    
    if ([self modelData:self.citiesInCounties isUpToDateWithKey:county.entityId]) {
        [self interpreter:interpreter shouldNotifyNewData:nil dependantOnUserData:county.entityId];
        return;
    }
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.arbetsformedlingen.se/platsannons/soklista/kommuner?lanid=%@", county.entityId];
    
    [self enqueueRequestWithURL:urlString withInterpreter:interpreter andUserData:county.entityId];
}

-(void) requestDetailsForOffice: (AldAFOffice *)office
{
    if (office == nil) {
        return;
    }
    
    id interpreter = [[AldAFOfficeDetailInterpreter alloc] init];
    if ([self modelData:self.offices isUpToDateWithKey:office.entityId]) {
        [self interpreter:interpreter shouldNotifyNewData:nil dependantOnUserData:office.entityId];
        return;
    }
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.arbetsformedlingen.se/arbetsformedling/%@", office.entityId];
    [self enqueueRequestWithURL:urlString withInterpreter:interpreter andUserData:office.entityId];
}

-(void) requestOpportunityCategories
{
    id interpreter = [[AldAFOpportunityCategoryInterpreter alloc] init];
    NSString *urlString = @"http://api.arbetsformedlingen.se/platsannons/soklista/yrkesomraden";
    [self enqueueRequestWithURL:urlString withInterpreter:interpreter andUserData:nil];
}

-(void) interpreter: (NSObject<AldJSONInterpreterProtocol> *)interpreter shouldNotifyNewData: (id)data dependantOnUserData: (id)dataKey
{
    id userData = [NSMutableDictionary dictionary];
    id iid = interpreter.interpretationId;
 
    if (data != nil) {
        id container = [[AldModelledData alloc] initWithData:data forKey:dataKey];
        
        if ([iid isEqualToString:kAldDataModelSignalDefault]) {
            // default message, assign the result as user data and pass it on, as there is
            // no container for these sort of messages.
            [userData setValue:data forKey:kAldDataModelSignalDefault];
        }
        
        else if ([iid isEqualToString:kAldDataModelSignalCounties]) {
            @synchronized (self.counties) {
                self.counties = container;
            }
        }
        
        else if ([iid isEqualToString:kAldDataModelSignalOffices]) {
            @synchronized (self.officesInCounties) {
                if (self.officesInCounties == nil) {
                    self.officesInCounties = container;
                } else {
                    [self.officesInCounties.data setValue:data forKey:dataKey];
                }
            }
        }
        
        else if ([iid isEqualToString:kAldDataModelSignalOffice]) {
            @synchronized (self.offices) {
                if (self.offices == nil) {
                    self.offices = container;
                } else {
                    [self.offices.data setValue:data forKey:dataKey];
                }
            }
        }
        
        else if ([iid isEqualToString:kAldDataModelSignalCity]) {
            @synchronized (self.citiesInCounties) {
                if (self.citiesInCounties == nil) {
                    self.citiesInCounties = container;
                } else {
                    [self.citiesInCounties.data setValue:data forKey:dataKey];
                }
            }
        }
        
        else if ([iid isEqualToString:kAldDataModelSignalOpportunityCategories]) {
            @synchronized (self.opportunityCategories) {
                self.opportunityCategories = container;
            }
        }
        
        else if ([iid isEqualToString:kAldDataModelSignalCountiesWithOpportunities]) {
            @synchronized (self.countiesWithOpportunities) {
                self.countiesWithOpportunities = container;
            }
        }
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:interpreter.interpretationId object:self userInfo:userData];
}

-(void) enqueueRequestWithURL: (NSString *)urlString withInterpreter: (NSObject<AldJSONInterpreterProtocol> *)interpreter andUserData: (id)data
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    NSURLConnection *conn = [NSURLConnection connectionWithRequest:req delegate:self];
    
    AldRequestState *rq = [[AldRequestState alloc] initWithInterpreter: interpreter];
    rq.userData = data;
    
    // Associate the user data with the connection, and do this by looking at the connection's
    // hash, and using this numeric representation as a key to access the state object.
    CFDictionaryAddValue (_requests, (const void *)conn.hash, (__bridge const void*)rq);
    
    // Make sure that the state object is retained. This might be unnecessary?
    [_activeConnections addObject:rq];
    
    [conn start];
}

-(AldRequestState *) stateForConnection: (NSURLConnection *)connection
{
    return (AldRequestState *)CFDictionaryGetValue(_requests, (const void *)connection.hash);
}

-(void) makeStateObsolete: (NSURLConnection *)connection
{
    id state = [self stateForConnection:connection];
    if (state == nil) {
        return;
    }
    
    CFDictionaryRemoveValue(_requests, (const void *)connection.hash);
    [_activeConnections removeObject:state];
}

-(void) connection: (NSURLConnection *)connection didReceiveResponse: (NSURLResponse *)response
{
    AldRequestState *state = [self stateForConnection:connection];
    if (state == nil) {
        return;
    }
    
    [state setData:[NSMutableData data]];
}

-(void) connection: (NSURLConnection *)connection didReceiveData: (NSData *)data
{
    AldRequestState *state = [self stateForConnection:connection];
    if (state == nil) {
        return;
    }
    
    [state.data appendData:data];
}

-(void) connectionDidFinishLoading: (NSURLConnection *)connection
{
    AldRequestState *state = [self stateForConnection:connection];
    if (state == nil) {
        return;
    }
    
    id data = [state.interpreter interpretJSON:state.data];
    [self interpreter:state.interpreter shouldNotifyNewData:data dependantOnUserData:state.userData];
        
    [self makeStateObsolete:connection];
}

-(void) connection: (NSURLConnection *)connection didFailWithError: (NSError *)error
{
    [self makeStateObsolete:connection];
}

@end
