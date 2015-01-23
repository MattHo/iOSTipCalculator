//
//  SettingsViewController.m
//  tipcalculator
//
//  Created by Matt Ho on 1/22/15.
//  Copyright (c) 2015 Yahoo Inc. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tip1TextField;
@property (weak, nonatomic) IBOutlet UITextField *tip2TextField;
@property (weak, nonatomic) IBOutlet UITextField *tip3TextField;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.title = @"Settings";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    long tip1 = [defaults integerForKey:@"tip1"];
    long tip2 = [defaults integerForKey:@"tip2"];
    long tip3 = [defaults integerForKey:@"tip3"];
    
    if (tip1) {
        self.tip1TextField.text = [NSString stringWithFormat:@"%li", tip1];
    } else {
        self.tip1TextField.text = @"10";
    }

    if (tip2) {
        self.tip2TextField.text = [NSString stringWithFormat:@"%li", tip2];
    } else {
        self.tip2TextField.text = @"15";
    }

    if (tip3) {
        self.tip3TextField.text = [NSString stringWithFormat:@"%li", tip3];
    } else {
        self.tip3TextField.text = @"20";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateSettings];
}

- (void)updateSettings {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    float tip1 = [self.tip1TextField.text floatValue];
    float tip2 = [self.tip2TextField.text floatValue];
    float tip3 = [self.tip3TextField.text floatValue];
    
    if (tip1) {
        [defaults setFloat:tip1 forKey:@"tip1"];
    }
    
    if (tip2) {
        [defaults setFloat:tip2 forKey:@"tip2"];
    }
    
    if (tip3) {
        [defaults setFloat:tip3 forKey:@"tip3"];
    }
    
    [defaults synchronize];
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
