//
//  CalculatorBrain.h
//  Task1
//
//  Created by Taishi Yoshida on 4/1/13.
//  Copyright (c) 2013 Taishi Yoshida. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject
@property NSString *operation;
-(void)pushOperand:(double)operand;
-(double)performOperation:(NSString *)operation;
-(void)removeOperandStack;
-(BOOL)isEmptyStack;
@end
