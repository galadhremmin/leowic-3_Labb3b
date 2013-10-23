//
//  AldMasterViewController.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldCountyOfficeViewController.h"
#import "AldOfficeSelectionViewController.h"

@implementation AldCountyOfficeViewController

-(void) prepareForSegue: (UIStoryboardSegue *)segue sender: (id)sender
{
    if ([[segue identifier] isEqualToString:@"officeSelection"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        id object = self.model.counties.data[indexPath.row];
        
        AldOfficeSelectionViewController *nextController = (AldOfficeSelectionViewController *)segue.destinationViewController;
        [nextController setCounty:object];
    }
}

@end
