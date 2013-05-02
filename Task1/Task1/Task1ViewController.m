//
//  Task1ViewController.m
//  Task1
//
//  Created by Taishi Yoshida on 3/28/13.
//  Copyright (c) 2013 Taishi Yoshida. All rights reserved.
//

#import "Task1ViewController.h"
#import "CalculatorBrain.h"

@interface Task1ViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL userIsOperationPressed;
@property (nonatomic) BOOL userIsResultPressed;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation Task1ViewController

@synthesize displayEntered = _displayEntered;
@synthesize display = _display;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize userIsOperationPressed = _userIsOperationPressed;
@synthesize userIsResultPressed = _userIsResultPressed;
@synthesize brain = _brain;

- (CalculatorBrain *)brain {
    
    if (!_brain) {
        _brain = [[CalculatorBrain alloc] init];
    }
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    if (self.userIsResultPressed && !self.userIsOperationPressed && !self.userIsInTheMiddleOfEnteringANumber) {
        self.displayEntered.text = [self.displayEntered.text stringByAppendingString:@" "];
        self.displayEntered.text = [self.displayEntered.text stringByAppendingString:digit];
    } else {
        self.displayEntered.text = [self.displayEntered.text stringByAppendingString:digit];
    }
    if (self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    }else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}
- (IBAction)operationPressed:(id)sender {
    
    if (self.userIsInTheMiddleOfEnteringANumber && !self.userIsOperationPressed) {
        [self.brain pushOperand:[self.display.text doubleValue]];
        NSString *operation = [sender currentTitle];
        self.brain.operation = operation;
        
        self.userIsInTheMiddleOfEnteringANumber = NO;
        self.userIsOperationPressed = YES;
        self.displayEntered.text = [self.displayEntered.text stringByAppendingString:operation];
    } else if (self.userIsOperationPressed && self.userIsInTheMiddleOfEnteringANumber) {
        
        [self.brain pushOperand:[self.display.text doubleValue]];
        double result = [self.brain performOperation:[self.brain operation]];
        [self.brain pushOperand:result];
        NSString *operation = [sender currentTitle];
        self.brain.operation = operation;
        self.displayEntered.text = [self.displayEntered.text stringByAppendingString:operation];
        self.userIsOperationPressed = YES;
        self.userIsInTheMiddleOfEnteringANumber = NO;
    } else if (self.userIsResultPressed) {
        [self.brain pushOperand:[self.display.text doubleValue]];
        self.userIsResultPressed = NO;
        self.userIsOperationPressed = YES;
        self.userIsInTheMiddleOfEnteringANumber = NO;
        
        NSString *operation = [sender currentTitle];
        self.brain.operation = operation;
        
        self.displayEntered.text = [self.displayEntered.text stringByAppendingString:@" "];
        NSString *result = [NSString stringWithFormat:@"%g", [self.display.text doubleValue]];
        self.displayEntered.text = [self.displayEntered.text stringByAppendingString:result];
        self.displayEntered.text = [self.displayEntered.text stringByAppendingString:operation];
    }
}
- (IBAction)resultPressed:(id)sender {
    
    if (self.userIsInTheMiddleOfEnteringANumber && self.userIsOperationPressed) {
        [self.brain pushOperand:[self.display.text doubleValue]];
    
        double result = [self.brain performOperation:[self.brain operation]];
        if (result) {
            self.display.text = [NSString stringWithFormat:@"%g", result];
            NSString *ret = [sender currentTitle];
            self.displayEntered.text = [self.displayEntered.text stringByAppendingString:ret];
            ret = [NSString stringWithFormat:@"%g", result];
            self.displayEntered.text = [self.displayEntered.text stringByAppendingString:ret];
        }
        
        self.userIsResultPressed = YES;
        self.userIsOperationPressed = NO;
        self.userIsInTheMiddleOfEnteringANumber = NO;
    }
}

- (IBAction)clearPressed {
    
    self.display.text = @"0";
    self.displayEntered.text = @"";
    self.userIsOperationPressed = NO;
    [self.brain removeOperandStack];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.userIsOperationPressed = NO;
}
@end
