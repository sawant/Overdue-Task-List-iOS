//
//  SSAddTaskViewController.m
//  Overdue Task List Assignment
//
//  Created by Sawant Shah on 23/10/2014.
//  Copyright (c) 2014 Sawant Shah. All rights reserved.
//

#import "SSAddTaskViewController.h"

@interface SSAddTaskViewController ()

@end

@implementation SSAddTaskViewController

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
    
    self.titleTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Methods

-(BOOL)isFormValid
{
//    Title is required, rest are optional
    if (self.titleTextField.text.length == 0) {
        return NO;
    }

    return YES;
}

#pragma mark - IB Actions

- (IBAction)addButtonPressed:(UIButton *)sender {
    if ([self isFormValid]) {
        self.task = [[SSTaskModel alloc] init];
        self.task.title = self.titleTextField.text;
        self.task.description = self.descriptionTextView.text;
        self.task.dueDate = self.datePicker.date;

        [self.delegate addTaskObject:self.task];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Title field is required." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        
        [alert show];
    }
}

- (IBAction)cancelButtonPressed:(UIButton *)sender {
    [self.delegate didCancel];
}

#pragma mark - UI Text Field Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self addButtonPressed:self.addButton];
    [self.titleTextField resignFirstResponder];
    return YES;
}

@end
