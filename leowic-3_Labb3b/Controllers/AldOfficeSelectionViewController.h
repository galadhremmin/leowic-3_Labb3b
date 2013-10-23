//
//  AldOfficeSelectionViewController.h
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AldAFCounty.h"
#import "AldAlphabeticSectionsTableViewController.h"

@interface AldOfficeSelectionViewController : AldAlphabeticSectionsTableViewController

@property(nonatomic, weak) AldAFCounty *county;

@end
