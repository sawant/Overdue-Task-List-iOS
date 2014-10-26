//
//  SSTaskModel.m
//  Overdue Task List Assignment
//
//  Created by Sawant Shah on 23/10/2014.
//  Copyright (c) 2014 Sawant Shah. All rights reserved.
//

#import "SSTaskModel.h"

@implementation SSTaskModel

-(id)init
{
    self = [self initWithData:nil];

    return self;
}

-(id)initWithData:(NSDictionary *)data
{
    self = [super init];

    self.title = data[TASK_TITLE];
    self.description = data[TASK_DESCRIPTION];
    self.dueDate = data[TASK_DUE_DATE];
    self.completion = [data[TASK_DONE] boolValue];

    return self;
}

@end
