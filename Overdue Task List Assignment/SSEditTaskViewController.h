//
//  SSEditTaskViewController.h
//  Overdue Task List Assignment
//
//  Created by Sawant Shah on 23/10/2014.
//  Copyright (c) 2014 Sawant Shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSTaskModel.h"

@protocol SSEditTaskViewControllerDelegate <NSObject>

-(void)editedTask;

@end

@interface SSEditTaskViewController : UIViewController

@property (weak, nonatomic) id <SSEditTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) SSTaskModel *task;
@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *dueDatePicker;
@property (strong, nonatomic) IBOutlet UISwitch *taskCompletedStatus;

- (IBAction)taskCompletedSwitch:(UISwitch *)sender;
- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender;

@end
