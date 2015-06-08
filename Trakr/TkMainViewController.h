//
//  TkMainViewController.h
//  Trakr
//
//  Created by Alex Roth on 2014-04-19.
//  Copyright (c) 2014 MagmaStone. All rights reserved.
//

#import "TkFlipsideViewController.h"

@interface TkMainViewController : UIViewController <TkFlipsideViewControllerDelegate>
- (void)updateLastLabel:(NSString*)value;
@end
