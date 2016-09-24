//
//  Settings.m
//  TipCalculator
//
//  Created by Swati Wadhera on 9/23/16.
//  Copyright © 2016 Swati Wadhera. All rights reserved.
//

#import "Settings.h"

@interface Settings ()

@end

@implementation Settings

- (void)viewDidLoad {
    doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];

    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setupFields];
}

- (IBAction)onTap
{
    [self.view endEditing:YES];
}

#pragma mark UITextFieldDelegate Methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    currentTF = textField;
    [doneBtn setBackgroundColor:[UIColor lightGrayColor]];
    [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
    [doneBtn addTarget:self.view action:@selector(endEditing:) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneBtn setFrame:CGRectMake(0, self.view.bounds.size.height - 160 - self.navigationController.navigationBar.bounds.size.height - 40 - 10, self.view.bounds.size.width, 40)];
    //if([doneBtn superview] != self.view)
        [self.view addSubview:doneBtn];
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField setText:[NSString stringWithFormat:@"%@%%",[textField.text stringByReplacingOccurrencesOfString:@"%" withString:@""]]];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if(textField == tip1TF)
        [userDefaults setObject:tip1TF.text forKey:@"Tip1"];
    else if(textField == tip2TF)
        [userDefaults setObject:tip2TF.text forKey:@"Tip2"];
    else
        [userDefaults setObject:tip3TF.text forKey:@"Tip3"];
    
    [userDefaults synchronize];
    
    if(textField == currentTF)
        [doneBtn removeFromSuperview];
    NSLog(@"textFieldDidEndEditing");
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"])
    {
        [textField resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



#pragma mark UITableViewDelegate Methods

- (IBAction)segmentClicked:(UISegmentedControl *)sender
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if(sender == themeControl)
    {
        [userDefaults setObject:[NSNumber numberWithInteger:sender.selectedSegmentIndex] forKey:@"Theme"];
    }
    else
    {
        [userDefaults setObject:[NSNumber numberWithInteger:sender.selectedSegmentIndex] forKey:@"Round"];
    }
    
    [userDefaults synchronize];
    [self setupFields];
}

- (IBAction)resetClicked
{
    
    [[[UIAlertView alloc] initWithTitle:@"Tip Calculator" message:@"Are you sure you want to reset the settings to default?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil] show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex)
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:@"15%" forKey:@"Tip1"];
        [userDefaults setObject:@"20%" forKey:@"Tip2"];
        [userDefaults setObject:@"25%" forKey:@"Tip3"];
        [userDefaults setObject:[NSNumber numberWithInt:0] forKey:@"Theme"];
        [userDefaults setObject:[NSNumber numberWithInt:0] forKey:@"Round"];
        [userDefaults synchronize];
        [self setupFields];
    }
}

- (void)setupFields
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [themeControl setSelectedSegmentIndex:[[userDefaults objectForKey:@"Theme"] integerValue]];
    [roundControl setSelectedSegmentIndex:[[userDefaults objectForKey:@"Round"] integerValue]];
    [tip1TF setText:[userDefaults objectForKey:@"Tip1"]];
    [tip2TF setText:[userDefaults objectForKey:@"Tip2"]];
    [tip3TF setText:[userDefaults objectForKey:@"Tip3"]];
    if(themeControl.selectedSegmentIndex == 1)
    {
        [self.view setBackgroundColor:[UIColor lightGrayColor]];
    }
    else
    {
        [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
