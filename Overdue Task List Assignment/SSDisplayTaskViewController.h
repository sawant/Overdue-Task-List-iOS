//
//  SSDisplayTaskViewController.h
//  Overdue Task List Assignment
//
//  Created by Sawant Shah on 23/10/2014.
//  Copyright (c) 2014 Sawant Shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSTaskModel.h"
#import "SSEditTaskViewController.h"

@protocol SSDisplayTaskViewControllerDelegate <NSObject>

-(void)didUpdate;

@end

@interface SSDisplayTaskViewController : UIViewController <SSEditTaskViewControllerDelegate>

@property (weak, nonatomic) id <SSDisplayTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *dueDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *completedLabel;

@property (strong, nonatomic) SSTaskModel *task;
@end
