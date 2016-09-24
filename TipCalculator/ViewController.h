//
//  ViewController.h
//  TipCalculator
//
//  Created by Swati Wadhera on 9/23/16.
//  Copyright © 2016 Swati Wadhera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings.h"

@interface ViewController : UIViewController
{
    IBOutlet UILabel *tipAmountLbl;
    IBOutlet UILabel *totalLbl;
    IBOutlet UILabel *tipLbl;
    IBOutlet UITextField *billTF;
    IBOutlet UISegmentedControl *tipControl;
    
    UIButton *doneBtn;
    
    Settings *settingObj;
    
    BOOL theme;
    BOOL round;
}

- (IBAction)onTap;
- (IBAction)segmentClicked:(UISegmentedControl *)control;


@end

