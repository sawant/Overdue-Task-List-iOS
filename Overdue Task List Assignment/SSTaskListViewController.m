//
//  SSTaskListViewController.m
//  Overdue Task List Assignment
//
//  Created by Sawant Shah on 23/10/2014.
//  Copyright (c) 2014 Sawant Shah. All rights reserved.
//

#import "SSTaskListViewController.h"
#import "SSDisplayTaskViewController.h"

@interface SSTaskListViewController ()

@end

@implementation SSTaskListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Lazy Instantiation

-(NSMutableArray *)taskList
{
    if (!_taskList) {
        _taskList = [[[NSUserDefaults standardUserDefaults] objectForKey:TASK_LIST_KEY] mutableCopy];
        
        if (!_taskList) {
            self.taskList = [[NSMutableArray alloc] init];
        }
    }
    
    return _taskList;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[SSDisplayTaskViewController class]]) {
        if ([sender isKindOfClass:[UITableViewCell class]]) {
            SSDisplayTaskViewController *nextVC = segue.destinationViewController;
            NSIndexPath *index = [self.tableView indexPathForCell:sender];
            
            [[NSUserDefaults standardUserDefaults] setObject:@(index.row) forKey:CHOSEN_TASK_ID];
            [[NSUserDefaults standardUserDefaults] synchronize];

            nextVC.delegate = self;
            nextVC.task = [self getTaskFromPropertyList:[self.taskList objectAtIndex:index.row]];
        }
    }
    if ([segue.destinationViewController isKindOfClass:[SSAddTaskViewController class]]) {
        SSAddTaskViewController *nextVC = segue.destinationViewController;
        nextVC.delegate = self;
    }
}

#pragma mark - Table View Data Source Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.taskList count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dataCell" forIndexPath:indexPath];
    
    SSTaskModel *task = [self getTaskFromPropertyList:[self.taskList objectAtIndex:indexPath.row]];
    NSString *taskStatus = task.completion ? @"Finished" : @"Pending";
    
    cell.textLabel.text = task.title;
    cell.detailTextLabel.text = taskStatus;
    
    //    Change color based on task completion status or if its overdue
    if ([task.dueDate timeIntervalSinceNow] < 0 && !task.completion)    cell.backgroundColor = [UIColor redColor];
    else if (!task.completion)                                          cell.backgroundColor = [UIColor orangeColor];
    else if (task.completion)                                           cell.backgroundColor = [UIColor greenColor];
    
    cell.showsReorderControl = YES;

    return cell;
}

#pragma mark - Table View Delegate

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.taskList removeObjectAtIndex:indexPath.row];
    
    NSMutableArray *newTaskList = [self.taskList mutableCopy];
    
    [[NSUserDefaults standardUserDefaults] setObject:newTaskList forKey:TASK_LIST_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    Change selection color
    //    Get Task object at current row, and modify its completion status - negate the current status
    SSTaskModel *task = [self getTaskFromPropertyList:[self.taskList objectAtIndex:indexPath.row]];
    task.completion = !task.completion;
    
    //    Add it back to Task List
    [self.taskList setObject:[self saveAsPropertyList:task] atIndexedSubscript:indexPath.row];
    
    [self synchronize];
    [self.tableView reloadData];

    return indexPath;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSDictionary *sourceTask = [self.taskList objectAtIndex:sourceIndexPath.row];
    [self.taskList removeObjectAtIndex:sourceIndexPath.row];
    [self.taskList insertObject:sourceTask atIndex:destinationIndexPath.row];
    
    [self synchronize];
    [self.tableView reloadData];
}

#pragma mark - Add Task VC Delegate

-(void)addTaskObject:(SSTaskModel *)task
{
    [self.taskList addObject:[self saveAsPropertyList:task]];
    
    [self synchronize];
    [self.tableView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Display Task VC Delegate

-(void)didUpdate
{
    NSNumber *row = [[NSUserDefaults standardUserDefaults] objectForKey:CHOSEN_TASK_ID];
    SSTaskModel *task = [self getTaskFromPropertyList:[self.taskList objectAtIndex:row.intValue]];
    NSLog(@"%@", task.title);
    
    self.taskList = [[[NSUserDefaults standardUserDefaults] objectForKey:TASK_LIST_KEY] mutableCopy];

    [self.tableView reloadData];
}

#pragma mark - Helper Methods

-(NSDictionary *)saveAsPropertyList:(SSTaskModel *)task
{
    NSDictionary *dictionary = @{TASK_TITLE: task.title,
                                 TASK_DESCRIPTION: task.description,
                                 TASK_DUE_DATE: task.dueDate,
                                 TASK_DONE: [NSNumber numberWithBool:task.completion]};
    
    return dictionary;
}

-(SSTaskModel *)getTaskFromPropertyList:(NSDictionary *)dictionary
{
    SSTaskModel *task = [[SSTaskModel alloc] initWithData:dictionary];
    
    return task;
}

-(void)synchronize
{
    //    Sync it back with NSUserDefaults
    [[NSUserDefaults standardUserDefaults] setObject:self.taskList forKey:TASK_LIST_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - IB Actions
- (IBAction)reorderButtonPressed:(UIBarButtonItem *)sender {
    if ([sender.title isEqualToString:@"Reorder"]) {
        [self.tableView setEditing:YES];
        sender.title = @"Done";
    }
    else if ([sender.title isEqualToString:@"Done"]) {
        [self.tableView setEditing:NO];
        sender.title = @"Reorder";
    }
}


@end
