//
//  TkFlipsideViewController.m
//  Trakr
//
//  Created by Alex Roth on 2014-04-19.
//  Copyright (c) 2014 MagmaStone. All rights reserved.
//

#import "TkFlipsideViewController.h"

@interface TkFlipsideViewController ()

@end

@implementation TkFlipsideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
