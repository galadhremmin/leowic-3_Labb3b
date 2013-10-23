//
//  AldSectionedTableViewController.h
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/23/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AldDataModel.h"

@interface AldAlphabeticSectionsTableViewController : UITableViewController

@property (nonatomic, weak) AldDataModel *model;

-(NSString *) dataModelSignalIdentifier;
-(NSArray *)  entitiesFromModel;
-(NSString *) titleForEntity: (id)entity;

-(void) populateFromModel;
-(void) requestDataFromModel: (AldDataModel *)model;
-(void) initCell: (UITableViewCell *)cell withData: (id)entity;

@end
