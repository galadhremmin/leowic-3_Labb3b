//
//  AldCountyOpportunitiesViewController.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/21/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldCountyOpportunitiesViewController.h"
#import "AldCitySelectionViewController.h"

@implementation AldCountyOpportunitiesViewController

-(void) prepareForSegue: (UIStoryboardSegue *)segue sender: (id)sender
{
    if ([[segue identifier] isEqualToString:@"citySelection"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        id object = self.model.counties.data[indexPath.row];
        
        AldCitySelectionViewController *nextController = (AldCitySelectionViewController *)segue.destinationViewController;
        [nextController setCounty:object];
    }
}

@end
