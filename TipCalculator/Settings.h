//
//  Settings.h
//  TipCalculator
//
//  Created by Swati Wadhera on 9/23/16.
//  Copyright © 2016 Swati Wadhera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Settings : UIViewController
{
    IBOutlet UITextField *tip1TF;
    IBOutlet UITextField *tip2TF;
    IBOutlet UITextField *tip3TF;
    
    IBOutlet UISegmentedControl *themeControl;
    IBOutlet UISegmentedControl *roundControl;
    
    UIButton *doneBtn;
    
    UITextField *currentTF;
}

- (IBAction)onTap;
- (IBAction)segmentClicked:(UISegmentedControl *)sender;
- (IBAction)resetClicked;

@end
