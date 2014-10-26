//
//  SSTaskListViewController.h
//  Overdue Task List Assignment
//
//  Created by Sawant Shah on 23/10/2014.
//  Copyright (c) 2014 Sawant Shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSTaskModel.h"
#import "SSAddTaskViewController.h"
#import "SSDisplayTaskViewController.h"

@interface SSTaskListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, SSAddTaskViewContainerDelegate, SSDisplayTaskViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *taskList;

- (IBAction)reorderButtonPressed:(UIBarButtonItem *)sender;
-(NSDictionary *)saveAsPropertyList:(SSTaskModel *)task;

@end
