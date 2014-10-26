//
//  SSDisplayTaskViewController.m
//  Overdue Task List Assignment
//
//  Created by Sawant Shah on 23/10/2014.
//  Copyright (c) 2014 Sawant Shah. All rights reserved.
//

#import "SSDisplayTaskViewController.h"
#import "SSEditTaskViewController.h"

@interface SSDisplayTaskViewController ()

@end

@implementation SSDisplayTaskViewController

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
    
    [self updateTask];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[SSEditTaskViewController class]]) {
        SSEditTaskViewController *nextVC = segue.destinationViewController;
        
        nextVC.task = self.task;
        nextVC.delegate = self;
    }
}

#pragma mark - Helper Methods

-(void)updateTask
{
    // Format due date
    NSDate *dueDate = self.task.dueDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    
    // Format Completion as Yes or No
    NSString *completed = self.task.completion ? @"Yes" : @"No";
    
    self.titleLabel.text = self.task.title;
    self.descriptionLabel.text = self.task.description;
    self.dueDateLabel.text = [formatter stringFromDate:dueDate];
    self.completedLabel.text = completed;
}

#pragma mark - Edit Task VC Delegate

-(void)editedTask
{
    [self updateTask];
    
    [self.navigationController popViewControllerAnimated:YES];

    [self.delegate didUpdate];
}
@end
