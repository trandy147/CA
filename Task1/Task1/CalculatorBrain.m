//
//  CalculatorBrain.m
//  Task1
//
//  Created by Taishi Yoshida on 4/1/13.
//  Copyright (c) 2013 Taishi Yoshida. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

-(NSMutableArray *)operandStack{
    
    if (!_operandStack) {
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}

-(void)pushOperand:(double)operand{
    
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];
}

-(double)popOperand {
    
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) {
        [self.operandStack removeLastObject];
    }
    return [operandObject doubleValue];
}

-(BOOL)isEmptyStack {
    
    if (self.operandStack) {
        return NO;
    }
    return YES;
}
-(void)removeOperandStack {
    
    if (self.operandStack) {
        [self.operandStack removeAllObjects];
    }
}

-(double)performOperation:(NSString *)operation{
    
    double result = 0;
    
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if ([@"*" isEqualToString:operation]) {
        result = [self popOperand] * [self popOperand];
    } else if ([operation isEqualToString:@"-"]) {
        double subtracter = [self popOperand];
        result = [self popOperand] - subtracter;
    } else if ([operation isEqualToString:@"/"]) {
        double divisor = [self popOperand];
        if (divisor) {
            result = [self popOperand] / divisor;
        }
    } 
    
    [self pushOperand:result];
    
    return result;
}
@end
