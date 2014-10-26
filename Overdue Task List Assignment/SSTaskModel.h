//
//  SSTaskModel.h
//  Overdue Task List Assignment
//
//  Created by Sawant Shah on 23/10/2014.
//  Copyright (c) 2014 Sawant Shah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSTaskModel : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSDate *dueDate;
@property (nonatomic) BOOL completion;

-(id)initWithData:(NSDictionary *)data;

@end
