//
//  TipViewController.m
//  tipcalculator
//
//  Created by Matt Ho on 1/19/15.
//  Copyright (c) 2015 Yahoo Inc. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

- (IBAction)onTap:(id)sender;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.title = @"Tip Calculator";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    [self updateValues];
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
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateValues];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateValues {
    float billAmount = [self.billTextField.text floatValue];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    // float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];

    long tip1 = [defaults integerForKey:@"tip1"];
    long tip2 = [defaults integerForKey:@"tip2"];
    long tip3 = [defaults integerForKey:@"tip3"];

    if (tip1) {
        [self.tipControl setTitle:[NSString stringWithFormat:@"%li%%",tip1] forSegmentAtIndex:0];
    } else {
        tip1 = 10;
    }
    
    if (tip2) {
        [self.tipControl setTitle:[NSString stringWithFormat:@"%li%%",tip2] forSegmentAtIndex:1];
    } else {
        tip2 = 15;
    }
    
    if (tip3) {
        [self.tipControl setTitle:[NSString stringWithFormat:@"%li%%",tip3] forSegmentAtIndex:2];
    } else {
        tip3 = 20;
    }
    
    NSArray *tipSettings = @[[NSNumber numberWithFloat:(float)tip1/100],[NSNumber numberWithFloat:(float)tip2/100], [NSNumber numberWithFloat:(float)tip3/100]];
    
    float tipAmount = billAmount * [tipSettings[self.tipControl.selectedSegmentIndex] floatValue];
    
    float totalAmount = billAmount + tipAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

- (void)onSettingsButton{
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

@end
