//
//  EditViewController.h
//  ToDo
//
//  Created by Menna Elhelaly on 4/5/21.
//  Copyright © 2021 Menna Elhelaly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "MyProtocole.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditViewController : UIViewController
@property Task *details;
@property int idView;
@property long indexOfItem;
@property id <MyProtocole> pro1;
@property id <MyProtocole> pro2;
@property id <MyProtocole> pro3;



@end

NS_ASSUME_NONNULL_END
