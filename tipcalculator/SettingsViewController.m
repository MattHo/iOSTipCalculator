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
    NSMutableArray *tipValues = [NSMutableArray arrayWithObjects:@(10.0), @(15.0), @(20.0), nil];
    NSArray *tipSettings = [defaults arrayForKey:@"tips"];
    
    for (int i = 0; i < tipValues.count; i++) {
        if (tipSettings[i] != nil) {
            [tipValues replaceObjectAtIndex:i withObject:tipSettings[i]];
        }
    }

    self.tip1TextField.text = [NSString stringWithFormat:@"%li", [[tipValues objectAtIndex:0] integerValue]];
    self.tip2TextField.text = [NSString stringWithFormat:@"%li", [[tipValues objectAtIndex:1] integerValue]];
    self.tip3TextField.text = [NSString stringWithFormat:@"%li", [[tipValues objectAtIndex:2] integerValue]];
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
    NSMutableArray *tipValues = [NSMutableArray arrayWithObjects:@(10.0), @(15.0), @(20.0), nil];
    float tip1 = [self.tip1TextField.text floatValue];
    float tip2 = [self.tip2TextField.text floatValue];
    float tip3 = [self.tip3TextField.text floatValue];
    
    if (tip1) {
        [tipValues replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:tip1]];
    }
    
    if (tip2) {
        [tipValues replaceObjectAtIndex:1 withObject:[NSNumber numberWithFloat:tip2]];
    }
    
    if (tip3) {
        [tipValues replaceObjectAtIndex:2 withObject:[NSNumber numberWithFloat:tip3]];
    }

    [defaults setObject:tipValues forKey:@"tips"];
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
