//
//  AldOpportunityDetailsViewController.h
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 28/10/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AldAFOpportunity.h"

@interface AldOpportunityDetailsViewController : UITableViewController

@property(nonatomic, weak) AldAFOpportunity *opportunity;

@end
