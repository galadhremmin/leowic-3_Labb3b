//
//  AldOpportunitySelectionViewController.h
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/23/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldAlphabeticSectionsTableViewController.h"
#import "AldAFInfoContainer.h"

@interface AldOpportunitySelectionViewController : AldAlphabeticSectionsTableViewController

@property(nonatomic, weak) AldAFInfoContainer *city;
@property(nonatomic, weak) AldAFInfoContainer *opportunityCategory;
@property(nonatomic, weak) AldAFInfoContainer *opportunityField;

@end
