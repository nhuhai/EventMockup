//
//  MyEventViewController.m
//  Event Mockup
//
//  Created by Hai Nguyen on 12/8/13.
//  Copyright (c) 2013 Hai Nguyen. All rights reserved.
//

#define LIST 0
#define MAP 1

#define CELL_TITLE_LABEL_TAG	1
#define	CELL_TIME_LABEL_TAG		2
#define CELL_VENUE_LABEL_TAG	3
#define CELL_FACEBOOKBUTTON_TAG	4
#define CELL_RIGHTBUTTON_TAG	5
#define CELL_IMAGE_TAG			6
#define CELL_LEFTBUTTON_TAG		100


#import "MyEventViewController.h"
#import "SWRevealViewController.h"
#import "EventDetailViewController.h"

@interface MyEventViewController ()

@end

@implementation MyEventViewController

static NSString *CellIdentifier = @"Cell";

NSArray *dicts;

#pragma mark - View lifecycle

- (id) init
{
	self = [super init];
	if(self != nil)
	{
		NSString *path = [[NSBundle mainBundle] pathForResource:@"events"
                                                         ofType:@"plist"];
        dicts = [NSArray arrayWithContentsOfFile:path];
	}
	
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = nil;
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:
                                            [NSArray arrayWithObjects:@"List",@"Map",
                                             nil]];
    self.segmentedControl = segmentedControl;
    [self.segmentedControl addTarget:self action:@selector(switchView:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = self.segmentedControl;
    self.segmentedControl.selectedSegmentIndex = LIST;
    
    SWRevealViewController *revealController = [self revealViewController];
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"] style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    UIBarButtonItem *composeButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:nil action:nil];
    
    self.navigationItem.rightBarButtonItem = composeButtonItem;
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:CellIdentifier];
    
    titleFont = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
	timeFont = [UIFont systemFontOfSize:[UIFont systemFontSize]];
	venueFont = timeFont;

}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [dicts count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSArray *events = [[dicts objectAtIndex:section] objectForKey:@"events"];
    return  [events count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    NSArray *events = [[dicts objectAtIndex:section] objectForKey:@"events"];
    NSDictionary *event = events[row];
    UITableViewCell *cell = nil;
    
    NSString *title = [event objectForKey:@"title"];
    NSString *time = [event objectForKey:@"time"];
    NSString *location = [event objectForKey:@"location"];
    
    UILabel *titleLabel = nil;
    UILabel *timeLabel = nil;
    UILabel *venueLabel = nil;
    UIButton *calendarButton = nil;
    
    UIImage *buttonImage = [UIImage imageNamed:@"images.jpeg"];
    //cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.tag = CELL_TITLE_LABEL_TAG;
        titleLabel.font = titleFont;
        [cell.contentView addSubview:titleLabel];
        
        timeLabel = [UILabel new];
        timeLabel.tag = CELL_TIME_LABEL_TAG;
        timeLabel.font = timeFont;
        [cell.contentView addSubview:timeLabel];
        
        venueLabel = [UILabel new];
        venueLabel.tag = CELL_VENUE_LABEL_TAG;
        venueLabel.font = venueFont;
        [cell.contentView addSubview:venueLabel];
        
        calendarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        calendarButton.tag = CELL_LEFTBUTTON_TAG;
        [cell.contentView addSubview:calendarButton];
    }
    
    NSInteger titleNumLines = 1;
    titleLabel = (UILabel*)[cell viewWithTag:CELL_TITLE_LABEL_TAG];
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:titleFont}];
    if(size.width < 256.0)
    {
        [titleLabel setFrame:CGRectMake(52.0, 6.0, 256.0, 20.0)];
    }
    else
    {
        [titleLabel setFrame:CGRectMake(52.0, 6.0, 256.0, 42.0)];
        titleNumLines = 2;
    }
    
    [titleLabel setNumberOfLines:titleNumLines];
    titleLabel.text = title;
    
    timeLabel = (UILabel*)[cell viewWithTag:CELL_TIME_LABEL_TAG];
    [timeLabel setFrame:CGRectMake(52.0, titleNumLines == 1 ? 28.0 : 50.0, 250.0, 20.0)];
    timeLabel.text = [NSString stringWithFormat:@"Time: %@",time];;
    
    venueLabel = (UILabel*)[cell viewWithTag:CELL_VENUE_LABEL_TAG];
    [venueLabel setFrame:CGRectMake(52.0, titleNumLines == 1 ? 46.0 : 68.0, 250.0, 20.0)];
    venueLabel.text = [NSString stringWithFormat:@"Location: %@",location];;
    
    calendarButton = (UIButton*)[cell viewWithTag:CELL_LEFTBUTTON_TAG];
    [calendarButton setFrame:CGRectMake(8.0, titleNumLines == 1 ? 8.0 : 24.0, 44.0, 44.0)];
    [calendarButton setImage:buttonImage forState:UIControlStateNormal];
    
    return cell;
}

- (NSString*) tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[dicts objectAtIndex:section] objectForKey:@"date"];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
	NSInteger row = [indexPath row];
    
    NSArray *events = [[dicts objectAtIndex:section] objectForKey:@"events"];
    NSDictionary *event = events[row];
    
    NSString *title = [event objectForKey:@"title"];
    NSString *time = [event objectForKey:@"time"];
    NSString *location = [event objectForKey:@"location"];
    
    [self showEventWithTitle:title on:time at:location];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    NSArray *events = [[dicts objectAtIndex:section] objectForKey:@"events"];
    NSDictionary *event = events[row];
    
    NSString *title = [event objectForKey:@"title"];
    
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:titleFont}];
    if(size.width >= 256.0)
    {
        return 90.0;
    }
    else
    {
        return 68.0;
    }
}

#pragma mark - Actions
- (void) showEventWithTitle:(NSString*)schedule on:(NSString *)time at:(NSString *)location
{
	EventDetailViewController *eventDetail = [[EventDetailViewController alloc] init];
	[[self navigationController] pushViewController:eventDetail animated:YES];
}

- (IBAction) switchView:(id)sender
{
    switcher = [sender selectedSegmentIndex];
    switch (switcher)
	{
		case LIST:
			self.tableView.hidden = NO;
            self.mapView.hidden = YES;
			break;
			
		case MAP:
			self.tableView.hidden = YES;
            self.mapView.hidden = NO;
            self.mapView.showsUserLocation = YES;
			break;
			
		default:
			break;
	}
	
	[self.tableView reloadData];
}

@end
