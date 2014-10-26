//
//  SSAddTaskViewController.h
//  Overdue Task List Assignment
//
//  Created by Sawant Shah on 23/10/2014.
//  Copyright (c) 2014 Sawant Shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSTaskModel.h"

@protocol SSAddTaskViewContainerDelegate <NSObject>

-(void)addTaskObject:(SSTaskModel *)task;
-(void)didCancel;

@end

@interface SSAddTaskViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) id <SSAddTaskViewContainerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) SSTaskModel *task;
@property (strong, nonatomic) IBOutlet UIButton *addButton;

- (IBAction)addButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;
@end
