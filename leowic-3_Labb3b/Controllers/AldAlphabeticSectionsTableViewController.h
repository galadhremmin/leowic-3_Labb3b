//
//  AldSectionedTableViewController.h
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/23/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AldDataModel.h"

@interface AldAlphabeticSectionsTableViewController : UITableViewController<UISearchBarDelegate>

@property (nonatomic, weak) AldDataModel *model;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property(nonatomic) BOOL displayingSearchResults;

-(NSString *) dataModelSignalIdentifier;
-(NSArray *)  entitiesFromModel;
-(NSString *) titleForEntity: (id)entity;

-(void) populateFromModel;
-(void) populateEntities: (NSArray *)entities;
-(void) requestDataFromModel: (AldDataModel *)model;
-(void) initCell: (UITableViewCell *)cell withData: (id)entity;
-(id)   selectedData;
-(void) performSearchWithString: (NSString *)searchQuery;

@end
