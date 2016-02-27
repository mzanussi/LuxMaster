//
//  PowerFormulaViewController.m
//  Lux Master
//
//  Created by Michael Zanussi on 9/9/13.
//  Copyright (c) 2013 Fat Chile. All rights reserved.
//

#import "PowerFormulaViewController.h"
#import "DataValidation.h"

@interface PowerFormulaViewController ()
@property (weak, nonatomic) IBOutlet UITextField *powerTextField;
@property (weak, nonatomic) IBOutlet UITextField *currentTextField;
@property (weak, nonatomic) IBOutlet UITextField *voltageTextField;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@end

@implementation PowerFormulaViewController

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
    if ([DataValidation areAnyTwoFilled:self.powerTextField.text second:self.currentTextField.text third:self.voltageTextField.text]) {
        [self calculate];
    } else {
        [self defaultViewState];
    }
}

- (void)calculate
{
    if (![DataValidation isValidDecimal:self.powerTextField.text]) {
        double amps = self.currentTextField.text.doubleValue;
        double volts = self.voltageTextField.text.doubleValue;
        double value = amps * volts;
        self.infoLabel.text = @"Solving for P:";
        self.resultLabel.text = [NSString stringWithFormat:@"%.2f W", value];
    } else if (![DataValidation isValidDecimal:self.voltageTextField.text]) {
        double amps = self.currentTextField.text.doubleValue;
        if (amps == 0.0) {
            self.resultLabel.text = [NSString stringWithFormat:@"NaN"];
        } else {
            double watts = self.powerTextField.text.doubleValue;
            double value = watts / amps;
            self.infoLabel.text = @"Solving for E:";
            self.resultLabel.text = [NSString stringWithFormat:@"%.2f V", value];
        }
    } else if (![DataValidation isValidDecimal:self.currentTextField.text]) {
        double volts = self.voltageTextField.text.doubleValue;
        if (volts == 0.0) {
            self.resultLabel.text = [NSString stringWithFormat:@"NaN"];
        } else {
            double watts = self.powerTextField.text.doubleValue;
            double value = watts / volts;
            self.infoLabel.text = @"Solving for I:";
            self.resultLabel.text = [NSString stringWithFormat:@"%.2f A", value];
        }
    }
}

@end
