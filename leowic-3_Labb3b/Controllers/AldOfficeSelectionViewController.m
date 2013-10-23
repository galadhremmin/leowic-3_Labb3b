//
//  AldOfficeSelectionViewController.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldOfficeSelectionViewController.h"
#import "AldOfficeDetailsViewController.h"
#import "AldDataModel.h"
#import "AldAFOffice.h"
#import "AldDataModelConstants.h"

@interface AldOfficeSelectionViewController ()

@property (nonatomic, weak)   AldDataModel *model;
@property (nonatomic, strong) NSDictionary *data;

@end

@implementation AldOfficeSelectionViewController

-(id) initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveOfficesInCountyArray:) name:kAldDataModelSignalOffices object:nil];
    
    [self setTitle:self.county.name];
    
    _model = [AldDataModel defaultModel];
    [_model requestOfficesInCounty:self.county];
}

-(void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Notification center

-(void) receiveOfficesInCountyArray: (NSNotification *)notification
{
    _data = [NSMutableDictionary dictionary];
    
    NSArray *entities = [_model.officesInCounties.data objectForKey:self.county.entityId];
    for (AldAFOffice *entity in entities) {
        
        // try to find a section associated with the specified entity name
        NSString *section = [NSString stringWithFormat:@"%d", [self sectionIndexForTitle:entity.name]];
        
        // Append or create a new section array?
        NSMutableArray *array = [_data objectForKey:section];
        if (array == nil) {
            array = [NSMutableArray arrayWithObject:entity];
        } else {
            [array addObject:entity];
        }
        
        [_data setValue:array forKey:section];
    }
    
    UITableView *view = (UITableView *)self.view;
    [view reloadData];
}

#pragma mark - Table view data source

-(NSArray *) sectionIndexTitlesForTableView: (UITableView *)tableView {
    return @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"Å",@"Ä",@"Ö",@"-"];
}

-(NSInteger) sectionIndexForTitle: (NSString *)title
{
    unichar c = [[title uppercaseString] characterAtIndex:0];
    switch (c) {
        case L'Å':
            return 26;
        case L'Ä':
            return 27;
        case L'Ö':
            return 28;
        default: {
            int i = c - 'A';
            if (i < 0 || i > 25) {
                return 29;
            }
            
            return i;
        }
    }
}

-(NSInteger) numberOfSectionsInTableView: (UITableView *)tableView
{
    return 30;
}

-(NSString *) tableView: (UITableView *)tableView titleForHeaderInSection: (NSInteger)section
{
    if ([self tableView:(UITableView *)self.view numberOfRowsInSection:section] < 1) {
        return nil;
    }
    
    switch (section) {
        case 26:
            return @"Å";
        case 27:
            return @"Ä";
        case 28:
            return @"Ö";
        case 29:
            return @"-";
        default: {
            unichar c = L'A' + section;
            return [NSString stringWithFormat:@"%C", c];
        }
    }
}

-(NSInteger) tableView: (UITableView *)tableView sectionForSectionIndexTitle: (NSString *)title atIndex: (NSInteger)index
{
    return [self sectionIndexForTitle:title];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger)section
{
    if (_data == nil) {
        return 0;
    }
    
    NSArray *entities = [_data objectForKey:[NSString stringWithFormat:@"%d", section]];
    if (entities == nil) {
        return 0;
    }
    
    return entities.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSArray *offices = [_data objectForKey:[NSString stringWithFormat:@"%d", indexPath.section]];
    if (offices == nil) {
        return nil;
    }
    
    AldAFOffice *object = offices[indexPath.row];
    cell.textLabel.text = [object name];
    return cell;
}

#pragma mark Segue selectors

-(void) prepareForSegue: (UIStoryboardSegue *)segue sender: (id)sender
{
    if ([[segue identifier] isEqualToString:@"officeDetails"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSArray *offices = [_model.officesInCounties.data objectForKey:self.county.entityId];
        id object = offices[indexPath.row];
        
        AldOfficeDetailsViewController *nextController = (AldOfficeDetailsViewController *)segue.destinationViewController;
        [nextController setOffice:object];
    }
}


@end
