//
//  RearViewController.h
//  Event Mockup
//
//  Created by Hai Nguyen on 12/8/13.
//  Copyright (c) 2013 Hai Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RearViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end
