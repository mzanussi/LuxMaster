//
//  VoltageDropViewController.m
//  Lux Master
//
//  Created by Michael Zanussi on 9/10/13.
//  Copyright (c) 2013 Fat Chile. All rights reserved.
//

#import "VoltageDropViewController.h"
#import "DataValidation.h"

@interface VoltageDropViewController ()
@property (weak, nonatomic) IBOutlet UITextField *currentTextField;
@property (weak, nonatomic) IBOutlet UITextField *conductorLengthTextField;
@property (weak, nonatomic) IBOutlet UILabel *awgLabel;
@property (weak, nonatomic) IBOutlet UISlider *awgSlider;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (nonatomic) NSInteger awg;
@end

@implementation VoltageDropViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self defaultViewState];
}

- (void)defaultViewState
{
    self.resultLabel.text = @"--";
    self.infoLabel.text = @"Specify all values.";
    self.awg = [self translateAWG:self.awgSlider.value];
    self.awgLabel.text = [[NSString alloc] initWithFormat:@"AWG: %d", [self awg]];
}

- (NSInteger)translateAWG:(float)value
{
    if (value <= 8.0) {
        return 8;
    } else if (value <= 10.0) {
        return 10;
    } else if (value <= 12.0) {
        return 12;
    } else if (value <= 14.0) {
        return 14;
    } else if (value <= 16.0) {
        return 16;
    } else if (value <= 18.0) {
        return 18;
    }
    return 0;
}

- (IBAction)textFieldDidChange:(UITextField *)sender
{
    if ([DataValidation areTwoFilled:self.currentTextField.text second:self.conductorLengthTextField.text]) {
        [self calculate];
    } else {
        [self defaultViewState];
    }
}

- (IBAction)sliderValueDidChange:(UISlider *)sender
{
    if ([DataValidation areTwoFilled:self.currentTextField.text second:self.conductorLengthTextField.text]) {
        self.awg = [self translateAWG:sender.value];
        self.awgLabel.text = [[NSString alloc] initWithFormat:@"AWG: %d", [self awg]];
        [self calculate];
    } else {
        [self defaultViewState];
    }
}

- (void)calculate
{
    double amps = self.currentTextField.text.doubleValue;
    double len = self.conductorLengthTextField.text.doubleValue;
    double resistance = 0.0;
    if (self.awg == 8) {
        resistance = 0.64;
    } else if (self.awg == 10) {
        resistance = 1.02;
    } else if (self.awg == 12) {
        resistance = 1.62;
    } else if (self.awg == 14) {
        resistance = 2.58;
    } else if (self.awg == 16) {
        resistance = 4.09;
    } else if (self.awg == 18) {
        resistance = 6.51;
    }
    double result = amps * len * (resistance / 1000) * 1.004;
    self.resultLabel.text = [NSString stringWithFormat:@"%.2f VDC", result];
}

@end
