//
//  TkFlipsideViewController.h
//  Trakr
//
//  Created by Alex Roth on 2014-04-19.
//  Copyright (c) 2014 MagmaStone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TkFlipsideViewController;

@protocol TkFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(TkFlipsideViewController *)controller;
@end

@interface TkFlipsideViewController : UIViewController

@property (weak, nonatomic) id <TkFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
