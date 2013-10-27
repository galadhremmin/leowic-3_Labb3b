//
//  AldAFOpportunityDetails.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 27/10/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldAFOpportunityDetails.h"

@implementation AldAFOpportunityDetails

-(id) initWithDictionary: (NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        NSDictionary *data = [dict objectForKey:@"annons"];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
        NSDate *publishDate = [formatter dateFromString:[data objectForKey:@"publiceraddatum"]];
        
        [self setEntityId:          [data objectForKey:@"annonsid"]];
        [self setName:              [data objectForKey:@"annonsrubrik"]];
        [self setRoleDescription:   [data objectForKey:@"annonstext"]];
        [self setRoleName:          [data objectForKey:@"yrkesbenamning"]];
        [self setOpportunityFieldId:[data objectForKey:@"yrkesid"]];
        [self setNumberOfVacancies: [[data objectForKey:@"antal_platser"] integerValue]];
        [self setPublishDate:       publishDate];
        
        data = [dict objectForKey:@"villkor"];
        
        [self setDuration:     [data objectForKey:@"varaktighet"]];
        [self setWorkHours:    [data objectForKey:@"arbetstid"]];
        [self setWorkHoursSpan:[data objectForKey:@"arbetstidvaraktighet"]];
        [self setSalaryType:   [data objectForKey:@"lonetyp"]];
        [self setSalaryForm:   [data objectForKey:@"loneform"]];

        data = [dict objectForKey:@"ansokan"];
        
        [self setApplicationReference:  [data objectForKey:@"referens"]];
        [self setApplicationEmail:      [data objectForKey:@"epostadress"]];
        [self setApplicationInformation:[data objectForKey:@"ovrigt_om_ansokan"]];
        
        data = [dict objectForKey:@"arbetsplats"];
        
        [self setEmployerName:          [data objectForKey:@"arbetsplatsnamn"]];
        [self setEmployerZipCode:       [data objectForKey:@"postnummer"]];
        [self setEmployerAddress:       [data objectForKey:@"postadress"]];
        [self setEmployerCity:          [data objectForKey:@"postort"]];
        [self setEmployerCountry:       [data objectForKey:@"postland"]];
        [self setEmployerVisitorAddress:[data objectForKey:@"besoksadress"]];
        [self setEmployerVisitorCity:   [data objectForKey:@"besoksort"]];
        [self setEmployerPhoneNumber:   [data objectForKey:@"telefonnummer"]];
        [self setEmployerFaxNumber:     [data objectForKey:@"faxnummer"]];
        [self setEmployerEmail:         [data objectForKey:@"epostadress"]];
        [self setEmployerWebsite:       [data objectForKey:@"hemsida"]];
    }
    
    return self;
}

-(NSComparisonResult) localizedCaseInsensitiveCompare: (AldAFOpportunityDetails *)other
{
    return [_name localizedCaseInsensitiveCompare:other.name];
}

@end
