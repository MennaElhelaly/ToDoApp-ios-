//
//  HomeViewController.h
//  ToDo
//
//  Created by Menna Elhelaly on 4/5/21.
//  Copyright © 2021 Menna Elhelaly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProtocole.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,MyProtocole>
- (IBAction)addTask:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
