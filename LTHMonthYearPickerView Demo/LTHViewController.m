//
//  LTHViewController.m
//  LTHMonthYearPickerView Demo
//
//  Created by Roland Leth on 30/11/13.
//  Copyright (c) 2014 Roland Leth. All rights reserved.
//

#import "LTHViewController.h"


@interface LTHViewController ()

@property (nonatomic, strong) UITextField *dateTextField;
@property (nonatomic, strong) LTHMonthYearPickerView *monthYearPicker;
@end


@implementation LTHViewController


- (void)viewDidLoad {
	[super viewDidLoad];
	
	CGSize winSize = [UIScreen mainScreen].bounds.size;
	_dateTextField = [[UITextField alloc] initWithFrame: CGRectMake(winSize.width * 0.5 - 75.0,
																	winSize.height * 0.5 - 20.0,
																	150.0,
																	40.0)];
	
	NSDateFormatter *dateFormatter = [NSDateFormatter new];
	[dateFormatter setDateFormat:@"MM / yyyy"];
	NSDate *minDate = [dateFormatter dateFromString:[NSString stringWithFormat: @"%i / %i", 3, 2015]];
	NSDate *maxDate = [dateFormatter dateFromString:[NSString stringWithFormat: @"%i / %i", 3, 2115]];
	
	_monthYearPicker = [[LTHMonthYearPickerView alloc] initWithDate: [NSDate date]
																		 shortMonths: NO
																	 numberedMonths: NO
																		  andToolbar: YES
																			  minDate: minDate
																		  andMaxDate: maxDate];
//	_monthYearPicker = [[LTHMonthYearPickerView alloc] initWithDate: [NSDate date]
//																		 shortMonths: NO
//																	 numberedMonths: NO
//																		  andToolbar: YES
//																			  minYear: 2015
//																		  andMaxYear: 2115];
	_monthYearPicker.delegate = self;
	_dateTextField.delegate = self;
	_dateTextField.textAlignment = NSTextAlignmentCenter;
	_dateTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
	_dateTextField.layer.borderWidth = 1.0;
	_dateTextField.textColor = [UIColor purpleColor];
	_dateTextField.tintColor = [UIColor purpleColor];
	_dateTextField.inputView = _monthYearPicker;
	[self.view addSubview: _dateTextField];
	[_dateTextField becomeFirstResponder];
}


#pragma mark - LTHMonthYearPickerView Delegate
- (void)pickerDidPressCancelWithInitialValues:(NSDictionary *)initialValues {
	_dateTextField.text = [NSString stringWithFormat:
						   @"%@ / %@",
						   initialValues[@"month"],
						   initialValues[@"year"]];
    [_dateTextField resignFirstResponder];
}


- (void)pickerDidPressDoneWithMonth:(NSString *)month andYear:(NSString *)year {
    _dateTextField.text = [NSString stringWithFormat: @"%@ / %@", month, year];
	[_dateTextField resignFirstResponder];
}


- (void)pickerDidPressCancel {
	[_dateTextField resignFirstResponder];
}


- (void)pickerDidSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	NSLog(@"row: %zd in component: %zd", row, component);
}


- (void)pickerDidSelectMonth:(NSString *)month {
    NSLog(@"month: %@ ", month);
}


- (void)pickerDidSelectYear:(NSString *)year {
    NSLog(@"year: %@ ", year);
}


- (void)pickerDidSelectMonth:(NSString *)month andYear:(NSString *)year {
    _dateTextField.text = [NSString stringWithFormat: @"%@ / %@", month, year];
}


@end
