//
//  OhmsLawViewController.m
//  Lux Master
//
//  Created by Michael Zanussi on 9/10/13.
//  Copyright (c) 2013 Fat Chile. All rights reserved.
//

#import "OhmsLawViewController.h"
#import "DataValidation.h"

@interface OhmsLawViewController ()
@property (weak, nonatomic) IBOutlet UITextField *voltageTextField;
@property (weak, nonatomic) IBOutlet UITextField *currentTextField;
@property (weak, nonatomic) IBOutlet UITextField *resistanceTextField;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@end

@implementation OhmsLawViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self defaultViewState];
}

- (void)defaultViewState
{
    self.resultLabel.text = @"--";
    self.infoLabel.text = @"Specify any two values.";
}

- (IBAction)textFieldDidChange:(UITextField *)sender
{
    if ([DataValidation areAnyTwoFilled:self.voltageTextField.text second:self.currentTextField.text third:self.resistanceTextField.text]) {
        [self calculate];
    } else {
        [self defaultViewState];
    }
}

- (void)calculate
{
    if (![DataValidation isValidDecimal:self.voltageTextField.text]) {
        double res = self.resistanceTextField.text.doubleValue;
        double current = self.currentTextField.text.doubleValue;
        double value = res * current;
        self.infoLabel.text = @"Solving for E:";
        self.resultLabel.text = [NSString stringWithFormat:@"%.2f V", value];
    } else if (![DataValidation isValidDecimal:self.currentTextField.text]) {
        double res = self.resistanceTextField.text.doubleValue;
        if (res == 0.0) {
            self.resultLabel.text = [NSString stringWithFormat:@"NaN"];
        } else {
            double volts = self.voltageTextField.text.doubleValue;
            double value = volts / res;
            self.infoLabel.text = @"Solving for I:";
            self.resultLabel.text = [NSString stringWithFormat:@"%.2f A", value];
        }
    } else if (![DataValidation isValidDecimal:self.resistanceTextField.text]) {
        double volts = self.voltageTextField.text.doubleValue;
        if (volts == 0.0) {
            self.resultLabel.text = [NSString stringWithFormat:@"NaN"];
        } else {
            double current = self.currentTextField.text.doubleValue;
            double value = current / volts;
            self.infoLabel.text = @"Solving for R:";
            self.resultLabel.text = [NSString stringWithFormat:@"%.2f Ω", value];
        }
    }
}

@end
