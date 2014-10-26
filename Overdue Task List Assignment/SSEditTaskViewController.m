//
//  SSEditTaskViewController.m
//  Overdue Task List Assignment
//
//  Created by Sawant Shah on 23/10/2014.
//  Copyright (c) 2014 Sawant Shah. All rights reserved.
//

#import "SSEditTaskViewController.h"

@interface SSEditTaskViewController ()

@end

@implementation SSEditTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleTextField.text = self.task.title;
    self.descriptionTextView.text = self.task.description;
    self.dueDatePicker.date = self.task.dueDate;
    [self.taskCompletedStatus setOn:self.task.completion];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Methods

-(BOOL)isSubmissionValid
{
//    Title field must not be empty
    if (self.titleTextField.text.length == 0) {
        return NO;
    }
    
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - IB Actions

- (IBAction)taskCompletedSwitch:(UISwitch *)sender {
}

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender {
    self.task.title = self.titleTextField.text;
    self.task.description = self.descriptionTextView.text;
    self.task.dueDate = self.dueDatePicker.date;
    self.task.completion = [self.taskCompletedStatus isOn];
    
    NSNumber *index = [[NSUserDefaults standardUserDefaults] objectForKey:CHOSEN_TASK_ID];
    NSMutableArray *taskList = [[[NSUserDefaults standardUserDefaults] objectForKey:TASK_LIST_KEY] mutableCopy];
    NSDictionary *taskPropertyList = @{TASK_TITLE: self.task.title,
                                       TASK_DESCRIPTION: self.task.description,
                                       TASK_DUE_DATE: self.task.dueDate,
                                       TASK_DONE: [NSNumber numberWithBool:self.task.completion]};
    
    [taskList setObject:taskPropertyList atIndexedSubscript:index.integerValue];

    [[NSUserDefaults standardUserDefaults] setObject:taskList forKey:TASK_LIST_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.delegate editedTask];
}


@end
