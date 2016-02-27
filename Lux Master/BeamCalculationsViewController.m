//
//  BeamCalculationsViewController.m
//  Lux Master
//
//  Created by Michael Zanussi on 9/10/13.
//  Copyright (c) 2013 Fat Chile. All rights reserved.
//

#import "BeamCalculationsViewController.h"
#import "DataValidation.h"

@interface BeamCalculationsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *beamDiameterTextField;
@property (weak, nonatomic) IBOutlet UITextField *beamAngleTextField;
@property (weak, nonatomic) IBOutlet UITextField *throwDistanceTextField;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UITextField *horizontalDistanceTextField;
@property (weak, nonatomic) IBOutlet UITextField *verticalDistanceTextField;
@end

@implementation BeamCalculationsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self defaultViewState];
}

- (void)defaultViewState
{
    self.resultLabel.text = @"--";
    self.infoLabel.text = @"Specify any two values, above or below.";
}

- (IBAction)beamTextFieldDidChange:(UITextField *)sender
{
    // If horizontal distance or vertical distance 
    // currently have text, wipe them out.
    if (self.horizontalDistanceTextField.text.length > 0) {
        self.horizontalDistanceTextField.text = @"";
    }
    if (self.verticalDistanceTextField.text.length > 0) {
        self.verticalDistanceTextField.text = @"";
    }
    if ([DataValidation areAnyTwoFilled:self.beamDiameterTextField.text second:self.beamAngleTextField.text third:self.throwDistanceTextField.text]) {
        [self calculateBeamCalculations];
    } else {
        [self defaultViewState];
    }
}

- (void)calculateBeamCalculations
{
    if (![DataValidation isValidDecimal:self.beamDiameterTextField.text]) {
        double angle = self.beamAngleTextField.text.doubleValue;
        double throw = self.throwDistanceTextField.text.doubleValue;
        double result = (2.0 * (throw * (tan((angle / (180.0 / M_PI)) / 2.0))));
        self.infoLabel.text = @"Solving for beam diameter:";
        self.resultLabel.text = [NSString stringWithFormat:@"%.2f units", result];
    } else if (![DataValidation isValidDecimal:self.beamAngleTextField.text]) {
        double diameter = self.beamDiameterTextField.text.doubleValue;
        double throw = self.throwDistanceTextField.text.doubleValue;
        double result = (2.0 * ((atan2((diameter / 2.0), throw))) * (180.0 / M_PI));
        self.infoLabel.text = @"Solving for beam angle:";
        self.resultLabel.text = [NSString stringWithFormat:@"%.2f°", result];
    } else if (![DataValidation isValidDecimal:self.throwDistanceTextField.text]) {
        double diameter = self.beamDiameterTextField.text.doubleValue;
        double angle = self.beamAngleTextField.text.doubleValue;
        double result = (diameter / 2.0) / (tan((angle / (180.0 / M_PI)) / 2.0));
        self.infoLabel.text = @"Solving for throw distance:";
        self.resultLabel.text = [NSString stringWithFormat:@"%.2f units", result];
    }
}

- (IBAction)distanceTextFieldDidChange:(UITextField *)sender
{
    // If beam diameter, beam angle, or throw distance
    // have text, wipe them out.
    if (self.beamDiameterTextField.text.length > 0) {
        self.beamDiameterTextField.text = @"";
    }
    if (self.beamAngleTextField.text.length > 0) {
        self.beamAngleTextField.text = @"";
    }
    if (self.throwDistanceTextField.text.length > 0) {
        self.throwDistanceTextField.text = @"";
    }
    if ([DataValidation areTwoFilled:self.horizontalDistanceTextField.text second:self.verticalDistanceTextField.text]) {
        [self calculateDistance];
    } else {
        [self defaultViewState];
    }
}

- (void)calculateDistance
{
    if ([DataValidation isValidDecimal:self.horizontalDistanceTextField.text] && [DataValidation isValidDecimal:self.verticalDistanceTextField.text]) {
        double h = self.horizontalDistanceTextField.text.doubleValue;
        double v = self.verticalDistanceTextField.text.doubleValue;
        double result = sqrtf((h * h) + (v * v));
        self.infoLabel.text = @"Solving for distance:";
        self.resultLabel.text = [NSString stringWithFormat:@"%.2f units", result];
    }
}

@end
