//
//  ViewController.m
//  TipCalculator
//
//  Created by Swati Wadhera on 9/23/16.
//  Copyright © 2016 Swati Wadhera. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    UIButton *settingsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingsBtn setFrame:CGRectMake(0, 0, 30, 30)];
    [settingsBtn setImage:[UIImage imageNamed:@"settings"] forState:UIControlStateNormal];
    [settingsBtn addTarget:self action:@selector(showSettings) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingsBtn];
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [userDefaults objectForKey:@"AppleLanguages"];
    NSString* preferredLanguage = [languages objectAtIndex:0];
    NSLog(@"preferredLanguage: %@", languages);
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [billTF becomeFirstResponder];
}

- (void)showSettings
{

}

#pragma mark UITextFieldDelegate Methods

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self setAllFields];
    NSLog(@"textFieldDidEndEditing");
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"])
    {
        [textField resignFirstResponder];
        return NO;
    }
    
    //
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark UISegmentedControl Method

- (void)setAllFields
{
    float tipAmount = 0;
    NSString *bill = billTF.text;

    switch(tipControl.selectedSegmentIndex)
    {
        case 0:
            tipAmount = [bill integerValue] * .15;
            break;
        case 1:
            tipAmount = [bill integerValue] * .20;
            break;
        case 2:
            tipAmount = [bill integerValue] * .25;
            break;
        default:
            break;
    }

    NSLog(@"tip Amount - %f",tipAmount);
    [tipLbl setText:[NSString stringWithFormat:@"$%@",[[NSNumber numberWithFloat:tipAmount] descriptionWithLocale:[NSLocale currentLocale]]
]];
    [totalLbl setText:[NSString stringWithFormat:@"$%@",[[NSNumber numberWithFloat:[bill intValue] + tipAmount] descriptionWithLocale:[NSLocale currentLocale]]]];

}

- (IBAction)segmentClicked:(UISegmentedControl *)control
{
    [self setAllFields];
}

- (void)onTap
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
