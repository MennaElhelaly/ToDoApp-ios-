//
//  Task.h
//  ToDo
//
//  Created by Menna Elhelaly on 4/5/21.
//  Copyright © 2021 Menna Elhelaly. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject<NSCoding>
@property NSString *name;
@property NSString *desc;
@property NSString *priorityValue;
@property NSString *dateCreation;
@property NSDate *reminderDate;
@property NSString *statues;

@end

NS_ASSUME_NONNULL_END
