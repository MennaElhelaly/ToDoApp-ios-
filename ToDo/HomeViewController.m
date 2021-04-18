//
//  HomeViewController.m
//  ToDo
//
//  Created by Menna Elhelaly on 4/5/21.
//  Copyright © 2021 Menna Elhelaly. All rights reserved.
//

#import "HomeViewController.h"
#import "ViewController.h"
#import "EditViewController.h"
#import "Task.h"
#import <UserNotifications/UserNotifications.h>


@interface HomeViewController ()

@end

@implementation HomeViewController{
    NSMutableArray *tasks;
    NSUserDefaults *userDefaults;
    BOOL isFiltered;
    NSMutableArray* filteredArr;
    NSDate *data;
    BOOL isGrantedNotificationAccess;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self notificationAuth];
    isFiltered=NO;

  
}
-(void)viewWillAppear:(BOOL)animated{
    tasks =[NSMutableArray new];
    filteredArr=[NSMutableArray new];
    isFiltered=NO;
    userDefaults = [NSUserDefaults standardUserDefaults];
    data=[userDefaults objectForKey:@"data"];
    tasks = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [self.tableView reloadData];
}

-(void)refresh{
    userDefaults = [NSUserDefaults standardUserDefaults];
        data=[userDefaults objectForKey:@"data"];
        tasks = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [self.tableView reloadData];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numRows = 0 ;
      if(isFiltered)
         {
             numRows =  [filteredArr count];
         }
         else
         {
             numRows = [tasks count];
         }
      return  numRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSMutableArray *dataValues =[NSMutableArray new];
    
    if(isFiltered)
    {
        dataValues =  filteredArr;
    }
    else
    {
        dataValues = tasks;
    }
    NSString *priority =[NSString new];
    NSString *statusCheck=[NSString new];
    if([dataValues count]!=0){
    priority= [[dataValues objectAtIndex:indexPath.row] priorityValue];
    statusCheck = [[dataValues objectAtIndex:indexPath.row] statues];
    
    cell.textLabel.text=[[dataValues objectAtIndex:indexPath.row] name];

    if([priority isEqual:@"High"] ){
           cell.imageView.image=[UIImage imageNamed:@"high"];

    }
    else if([priority isEqual:@"Meduim"] ){
       cell.imageView.image=[UIImage imageNamed:@"Medium"];

    }else{
       cell.imageView.image=[UIImage imageNamed:@"low"];

    }
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    EditViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"EditViewController"];
     NSMutableArray *dataValues =[NSMutableArray new];
      
      if(isFiltered)
      {
          dataValues =  filteredArr;
      }
      else
      {
          dataValues = tasks;
      }
    isFiltered =NO;

    [vc setDetails:[dataValues objectAtIndex:indexPath.row]];
    [vc setIndexOfItem:indexPath.row];
    [vc setIdView:1];
    [vc setPro1:self];
    [self.navigationController pushViewController:vc animated:YES];

}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *titleName=@"All";
     if(isFiltered)
        {
            titleName = @"Filtred";
        }
        else
        {
            titleName = @"All To Do";
        }
    return titleName;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tasks removeObjectAtIndex:indexPath.row];
        NSDate *dataObject=[NSKeyedArchiver archivedDataWithRootObject:tasks];
        [userDefaults setObject:dataObject forKey:@"data"];
        [userDefaults synchronize];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
- (IBAction)addTask:(id)sender {
    ViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
     [vc setIsGranted:isGrantedNotificationAccess];
     [vc setPro:self];
     [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - SearchBar Delegate Methods
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    isFiltered = YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    filteredArr = [NSMutableArray new];
    if(searchText.length == 0)
    {
        isFiltered=NO;
    }
    else
    {
        isFiltered=YES;
        for (int i =0 ; i<[tasks count]; i++) {
            NSRange stringRange = [[[tasks objectAtIndex:i]name] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(stringRange.location != NSNotFound)
            {
                [filteredArr addObject:[tasks objectAtIndex:i]];
            }
        }
    }
    [_tableView reloadData];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_tableView resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    isFiltered=NO;
    [_tableView reloadData];
}
-(void) notificationAuth
{
    isGrantedNotificationAccess = NO;
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNAuthorizationOptions options = UNAuthorizationOptionSound+UNAuthorizationOptionAlert;
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        isGrantedNotificationAccess = granted;
    }];
}

@end
