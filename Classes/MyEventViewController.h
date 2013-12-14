//
//  MyEventViewController.h
//  Event Mockup
//
//  Created by Hai Nguyen on 12/8/13.
//  Copyright (c) 2013 Hai Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MyEventViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UIFont *titleFont;
    UIFont *timeFont;
    UIFont *venueFont;
    NSInteger switcher;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) UISegmentedControl *segmentedControl;



@end
