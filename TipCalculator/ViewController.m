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
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    round = [[userDefaults objectForKey:@"Round"] boolValue];
    theme = [[userDefaults objectForKey:@"Theme"] boolValue];
    [tipControl setTitle:[userDefaults objectForKey:@"Tip1"] forSegmentAtIndex:0];
    [tipControl setTitle:[userDefaults objectForKey:@"Tip2"] forSegmentAtIndex:1];
    [tipControl setTitle:[userDefaults objectForKey:@"Tip3"] forSegmentAtIndex:2];

    
    NSDate *oldDate = [userDefaults objectForKey:@"BillDate"];
    NSLog(@"%f",[[NSDate date] timeIntervalSinceDate:oldDate]);
    if([[NSDate date] timeIntervalSinceDate:oldDate] < 10*60)
    {
        [billTF setText:[userDefaults objectForKey:@"Bill"]];
        [self setAllFields];
    }
    [billTF becomeFirstResponder];
    
    if(theme)
    {
        [self.view setBackgroundColor:[UIColor lightGrayColor]];
    }
    else
    {
        [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    }
}

- (void)showSettings
{
    settingObj = [self.storyboard instantiateViewControllerWithIdentifier:@"Settings"];
    [self.navigationController pushViewController:settingObj animated:YES];
}

#pragma mark UITextFieldDelegate Methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setBackgroundColor:[UIColor orangeColor]];
    [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
    [doneBtn addTarget:self.view action:@selector(endEditing:) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneBtn setFrame:CGRectMake(0, self.view.bounds.size.height - 165 - self.navigationController.navigationBar.bounds.size.height - 10 - 40 - 10, self.view.bounds.size.width, 40)];
    [self.view addSubview:doneBtn];
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [[NSUserDefaults standardUserDefaults] setObject:billTF.text forKey:@"Bill"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"BillDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [doneBtn removeFromSuperview];
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
    else if(![string isEqualToString:@""])
    {
        if(![self validateCharacter:string])
        {
            return NO;
        }
    }
    
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
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *tipPer;
    switch(tipControl.selectedSegmentIndex)
    {
        case 0:
            
            tipPer = [userDefaults objectForKey:@"Tip1"];
           break;
        case 1:
            tipPer = [userDefaults objectForKey:@"Tip2"];
            break;
        case 2:
            tipPer = [userDefaults objectForKey:@"Tip3"];
            break;
        default:
            break;
    }

    [tipLbl setText:[NSString stringWithFormat:@"Tip (%@)",tipPer]];
    tipPer = [tipPer stringByReplacingOccurrencesOfString:@"%" withString:@""];
    NSLog(@"%.2f",(float)[tipPer intValue]/100);
    tipAmount = [bill floatValue] * (float)[tipPer intValue]/100;

    if(round)
    {
        [tipAmountLbl setText:[NSString stringWithFormat:@"$%@",[[NSNumber numberWithInt:tipAmount] descriptionWithLocale:[NSLocale currentLocale]]]];
        [totalLbl setText:[NSString stringWithFormat:@"$%@",[[NSNumber numberWithInt:[bill intValue] + tipAmount] descriptionWithLocale:[NSLocale currentLocale]]]];
    }
    else
    {
        [tipAmountLbl setText:[NSString stringWithFormat:@"$%@",[[NSNumber numberWithFloat:tipAmount] descriptionWithLocale:[NSLocale currentLocale]]]];
        [totalLbl setText:[NSString stringWithFormat:@"$%@",[[NSNumber numberWithFloat:[bill intValue] + tipAmount] descriptionWithLocale:[NSLocale currentLocale]]]];
    }
    
    
}

- (IBAction)segmentClicked:(UISegmentedControl *)control
{
    [self setAllFields];
}

- (void)onTap
{
    [self.view endEditing:YES];
}

- (BOOL)validateCharacter:(NSString *)string
{
    NSCharacterSet *validChars = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    return ([string rangeOfCharacterFromSet:validChars].location != NSNotFound);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
