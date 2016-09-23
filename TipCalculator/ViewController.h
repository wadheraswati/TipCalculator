//
//  ViewController.h
//  TipCalculator
//
//  Created by Swati Wadhera on 9/23/16.
//  Copyright © 2016 Swati Wadhera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    IBOutlet UILabel *tipLbl;
    IBOutlet UILabel *totalLbl;
    
    IBOutlet UITextField *billTF;
    IBOutlet UISegmentedControl *tipControl;
    
}

- (IBAction)onTap;
- (IBAction)segmentClicked:(UISegmentedControl *)control;


@end

