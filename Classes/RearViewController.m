//
//  RearViewController.m
//  Event Mockup
//
//  Created by Hai Nguyen on 12/8/13.
//  Copyright (c) 2013 Hai Nguyen. All rights reserved.
//

#import "RearViewController.h"

#import "SWRevealViewController.h"
#import "MyEventViewController.h"
#import "FriendEventViewController.h"
#import "SettingsViewController.h"

@interface RearViewController ()

@end

@implementation RearViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Event Book";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Data Source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSInteger row = indexPath.row;
    
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    if (row == 0)
    {
        cell.textLabel.text = @"My Events";
    }
    else if (row == 1)
    {
        cell.textLabel.text = @"Friends' Events";
    }
    else if (row == 2)
    {
        cell.textLabel.text = @"Settings";
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Grab a handle to the reveal controller, as if you'd do with a navigation controller via self.navigationController
    SWRevealViewController *revealController = self.revealViewController;
    
    // We know the frontViewController is a NavigationController
    UINavigationController *frontNavigationController = (id)revealController.frontViewController; // <-- we know it is a NavigationController
    NSInteger row = indexPath.row;
    
    if (row == 0)
    {
        // Now let's see if we're not attempting to swap the current frontViewController for a new instance of ITSELF, which'd be highly redundant.
        if ( ![frontNavigationController.topViewController isKindOfClass:[MyEventViewController class]] )
        {
            MyEventViewController *myEventViewController = [[MyEventViewController alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:myEventViewController];
            [revealController setFrontViewController:navigationController animated:YES];
        }
        // Seems the user attempts to 'switch' to exactly the same controller he came from!
        else
        {
            [revealController revealToggle:self];
        }
    }
    // ... and the second row (=1) corresponds the the "FriendEventViewController".
    else if (row == 1)
    {
        // Now let's see if we're not attempting to swap the current frontViewController for a new instance of ITSELF, which'd be highly redundant
        if ( ![frontNavigationController.topViewController isKindOfClass:[FriendEventViewController class]] )
        {
            FriendEventViewController *friendEventViewController = [[FriendEventViewController alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:friendEventViewController];
            [revealController setFrontViewController:navigationController animated:YES];
        }
        // Seems the user attempts to 'switch' to exactly the same controller he came from
        else
        {
            [revealController revealToggle:self];
        }
    }
    else if (row == 2)
    {
        // Now let's see if we're not attempting to swap the current frontViewController for a new instance of ITSELF, which'd be highly redundant
        if ( ![frontNavigationController.topViewController isKindOfClass:[SettingsViewController class]] )
        {
            SettingsViewController *settingsViewController = [[SettingsViewController alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
            [revealController setFrontViewController:navigationController animated:YES];
        }
        // Seems the user attempts to 'switch' to exactly the same controller he came from
        else
        {
            [revealController revealToggle:self];
        }
    }

}

@end
