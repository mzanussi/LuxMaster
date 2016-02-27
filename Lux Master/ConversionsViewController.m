//
//  ConversionsViewController.m
//  Lux Master
//
//  Created by Michael Zanussi on 9/10/13.
//  Copyright (c) 2013 Fat Chile. All rights reserved.
//

#import "ConversionsViewController.h"
#import "DataValidation.h"

@interface ConversionsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *footcandlesTextField;
@property (weak, nonatomic) IBOutlet UITextField *luxTextField;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@end

@implementation ConversionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self defaultViewState];
}

- (void)defaultViewState
{
    self.resultLabel.text = @"--";
    self.infoLabel.text = @"Specify any value.";
}

- (IBAction)footcandlesTextFieldDidChange:(UITextField *)sender
{
    // If lux has text, wipe it out.
    if (self.luxTextField.text.length > 0) {
        self.luxTextField.text = @"";
    }
    if ([DataValidation isValidDecimal:self.footcandlesTextField.text]) {
        double fc = self.footcandlesTextField.text.doubleValue;
        double result = fc * 10.764;
        self.infoLabel.text = @"Solving for lux, or lumens/m²:";
        self.resultLabel.text = [NSString stringWithFormat:@"%.2f lx", result];
    } else {
        [self defaultViewState];
    }
}

- (IBAction)luxTextFieldDidChange:(UITextField *)sender
{
    // If footcandles has text, wipe it out.
    if (self.footcandlesTextField.text.length > 0) {
        self.footcandlesTextField.text = @"";
    }
    if ([DataValidation isValidDecimal:self.luxTextField.text]) {
        double lx = self.luxTextField.text.doubleValue;
        double result = lx * 0.0929;
        self.infoLabel.text = @"Solving for footcandles, or lumens/ft²:";
        self.resultLabel.text = [NSString stringWithFormat:@"%.2f fc", result];
    } else {
        [self defaultViewState];
    }
}

@end
