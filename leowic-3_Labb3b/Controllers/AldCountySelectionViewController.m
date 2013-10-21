//
//  AldCountySelectionViewController.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/21/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldCountySelectionViewController.h"
#import "AldAFCounty.h"
#import "AldDataModelConstants.h"

@implementation AldCountySelectionViewController

-(void) awakeFromNib
{
    [super awakeFromNib];
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveCountyArray:) name:kAldDataModelSignalCounties object:nil];
    
    _model = [AldDataModel defaultModel];
    [_model requestCounties];
}

-(void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Notification center

-(void) receiveCountyArray: (NSNotification *)notification
{
    UITableView *view = (UITableView *)self.view;
    [view reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - Table View

-(NSInteger) numberOfSectionsInTableView: (UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger)section
{
    if (_model.counties == nil) {
        return 0;
    }
    
    return [_model.counties.data count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    AldAFCounty *object = _model.counties.data[indexPath.row];
    cell.textLabel.text = [object name];
    return cell;
}

@end
