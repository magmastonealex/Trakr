//
//  TkMainViewController.m
//  Trakr
//
//  Created by Alex Roth on 2014-04-19.
//  Copyright (c) 2014 MagmaStone. All rights reserved.
//

#import "TkMainViewController.h"
#import "LocationGrabberBackground.h"
@interface TkMainViewController ()

@property (weak, nonatomic) IBOutlet UIButton *GoButton;
@property (weak, nonatomic) IBOutlet UILabel *LastUpdateLabel;
@property (strong, nonatomic) LocationGrabberBackground *lgb;
@end

@implementation TkMainViewController
int going = 0;
- (void)updateLastLabel:(NSString*)value{
    [_LastUpdateLabel setText:value];
}

- (IBAction)ShareUUID:(id)sender {

        NSArray* sharingItems = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"Track me with Trakr! http://trakr.magmastone.net/?uuid=%@", [[[UIDevice currentDevice] identifierForVendor] UUIDString]], nil];
    
        
        UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
        [self presentViewController:activityController animated:YES completion:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _lgb = [[LocationGrabberBackground alloc] init:self];
	// Do any additional setup after loading the view, typically from a nib. 173
}
- (IBAction)BeginEnd:(id)sender {
    if(going == 0){
        [_GoButton titleLabel].font = [UIFont systemFontOfSize:106.0f];
        [_GoButton setTitle:@"STOP" forState:UIControlStateNormal];
        [_GoButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_GoButton setTintColor:[UIColor blueColor]];
        [[_GoButton titleLabel] setTextColor:[UIColor blueColor]];
        [[_GoButton titleLabel] setTintColor:[UIColor blueColor]];
        [_lgb locationFrequency:10];
        going = 1;
    }else{
        
        [_GoButton setTitle:@"GO" forState:UIControlStateNormal];
        [_GoButton titleLabel].font = [UIFont systemFontOfSize:173.0f];
        [_GoButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [_GoButton setTintColor:[UIColor greenColor]];
        [[_GoButton titleLabel] setTextColor:[UIColor greenColor]];
        [[_GoButton titleLabel] setTintColor:[UIColor greenColor]];
        [_lgb locationFrequency:10000];
        going = 0;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(TkFlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

@end
