//
//  AldOfficeDetailsViewController.h
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AldAFOffice.h"

@interface AldOfficeDetailsViewController : UITableViewController<UITableViewDelegate>

@property (weak, nonatomic) AldAFOffice *office;
@property (weak, nonatomic) IBOutlet UILabel *visitorAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *visitorCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *selfServiceHoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *personalServiceHoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *postAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *postZipCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *postCityAddress;
@property (weak, nonatomic) IBOutlet UILabel *mailAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneHoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *managerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *employerPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *faxNumberLabel;
@property (weak, nonatomic) IBOutlet UIWebView *informationWebView;

@end
