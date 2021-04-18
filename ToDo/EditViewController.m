//
//  EditViewController.m
//  ToDo
//
//  Created by Menna Elhelaly on 4/5/21.
//  Copyright © 2021 Menna Elhelaly. All rights reserved.
//

#import "EditViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "Task.h"

@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *doneEditing;
@property (weak, nonatomic) IBOutlet UIButton *lowBtn;
@property (weak, nonatomic) IBOutlet UIButton *medBtn;
@property (weak, nonatomic) IBOutlet UIButton *highBtn;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UIButton *InProgressBtn;
@property (weak, nonatomic) IBOutlet UITextField *nameView;
@property (weak, nonatomic) IBOutlet UITextField *desView;
@property (weak, nonatomic) IBOutlet UITextField *priorityView;
@property (weak, nonatomic) IBOutlet UILabel *dateCreationView;
@property (weak, nonatomic) IBOutlet UITextField *inProgressView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;


@end

@implementation EditViewController{
    NSMutableArray *tasks;
    NSMutableArray *tasksAfterEdit;
    NSMutableArray *empty;

    

       NSUserDefaults *userDefaults;
       NSDate *data;
       NSDate *dataDone;

    Task *newTask;
}


- (void)viewDidLoad {
      [super viewDidLoad];
    newTask =[Task new];
    tasks =[NSMutableArray new];
    tasksAfterEdit=[NSMutableArray new];
    empty=[NSMutableArray new];

    
    userDefaults = [NSUserDefaults standardUserDefaults];
   
    if(_idView ==1)
    {
        data=[userDefaults objectForKey:@"data"];
    }
    else if(_idView == 2)
    {
        data=[userDefaults objectForKey:@"progress"];
    }
    else{
        [self editBtn].enabled = NO;
        [self doneEditing].enabled = NO;
    }
    dataDone=[userDefaults objectForKey:@"Done"];
    tasks = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    
    _nameView.text=_details.name;
    _desView.text=_details.desc;
    _priorityView.text=_details.priorityValue;
    _dateCreationView.text=_details.dateCreation;
    _inProgressView.text=_details.statues;
    //_datePicker.date=_details.reminderDate;
    
}
- (IBAction)editBtn:(id)sender {
    [self nameView].enabled = YES;
    [self desView].enabled = YES;
    [self InProgressBtn].enabled = YES;
    [self datePicker].enabled = YES;
    [self doneEditing].enabled=YES;
    [self doneBtn].enabled = YES;
    [self highBtn].enabled = YES;
    [self medBtn].enabled = YES;
    [self lowBtn].enabled = YES;



}
- (IBAction)doneBtn:(id)sender {
    [tasks removeObjectAtIndex:_indexOfItem];
    NSDate *afterDelete=[NSKeyedArchiver archivedDataWithRootObject:tasks];
    
      if(_idView ==1 )
      {
          [userDefaults setObject:afterDelete forKey:@"data"];
      }
      else
      {
          [userDefaults setObject:afterDelete forKey:@"progress"];
      }
    
      NSDateFormatter* dateFormatter = [NSDateFormatter new];
      [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
      NSString *dateReminder = [dateFormatter stringFromDate:_datePicker.date];
      
       newTask.name=[_nameView text] ;
       newTask.desc=[_desView text] ;
       newTask.dateCreation=_details.dateCreation;
       newTask.priorityValue=[_priorityView text];
       newTask.reminderDate=dateReminder;
       newTask.statues =[_inProgressView text];
    
     //   [tasks addObject:newTask];
    
    NSDate *dataObject=[NSDate new];//=[NSKeyedArchiver archivedDataWithRootObject:tasks];
    
        if(_idView ==1  )
           {
               if([newTask.statues isEqual:@"toDo" ]){
                   data=[userDefaults objectForKey:@"data"];
                   empty=[NSKeyedUnarchiver unarchiveObjectWithData:data];
                   if([empty count]!=0){
                       tasks = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                   }
                   else{
                       tasks=[NSMutableArray new];
                   }
                   [tasks addObject:newTask];
                   dataObject=[NSKeyedArchiver archivedDataWithRootObject:tasks];

                   [userDefaults setObject:dataObject forKey:@"data"];

               }
               else if([newTask.statues isEqual:@"InProgress"]){
                   data=[userDefaults objectForKey:@"progress"];
                   empty=[NSKeyedUnarchiver unarchiveObjectWithData:data];
                         if([empty count]!=0){
                             tasks = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                         }
                         else{
                             tasks=[NSMutableArray new];
                         }
                   [tasks addObject:newTask];
                   dataObject=[NSKeyedArchiver archivedDataWithRootObject:tasks];
                   [userDefaults setObject:dataObject forKey:@"progress"];

               }else{
                   data=[userDefaults objectForKey:@"Done"];
                    empty=[NSKeyedUnarchiver unarchiveObjectWithData:data];
                       if([empty count]!=0){
                           tasks = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                       }
                       else{
                           tasks=[NSMutableArray new];
                       }
                   
                     [tasks addObject:newTask];
                   dataObject=[NSKeyedArchiver archivedDataWithRootObject:tasks];

                   [userDefaults setObject:dataObject forKey:@"Done"];

               }

           }
        else if(_idView ==2  ){
               if([newTask.statues isEqual:@"InProgress"]){
                   empty=[NSKeyedUnarchiver unarchiveObjectWithData:data];
                         if([empty count]!=0){
                             tasks = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                         }
                         else{
                             tasks=[NSMutableArray new];
                         }
                     
                       [tasks addObject:newTask];
                     dataObject=[NSKeyedArchiver archivedDataWithRootObject:tasks];
              
                   [userDefaults setObject:dataObject forKey:@"progress"];
                 
                 }else{
                      data=[userDefaults objectForKey:@"Done"];
                      empty=[NSKeyedUnarchiver unarchiveObjectWithData:data];
                       if([empty count]!=0){
                           tasks = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                       }
                       else{
                           tasks=[NSMutableArray new];
                       }
                   
                      [tasks addObject:newTask];
                       dataObject=[NSKeyedArchiver archivedDataWithRootObject:tasks];

                       [userDefaults setObject:dataObject forKey:@"Done"];
                 }
        }
    [self showNotification];
    [userDefaults synchronize];
    
    [_pro1 refresh];
    [_pro2 refresh];
    [_pro3 refresh];

    [self.navigationController popViewControllerAnimated:YES];
    

}
-(void) showNotification{
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
        NSDateComponents *triggerDate = [[NSCalendar currentCalendar]
                                         components:NSCalendarUnitYear +
                                         NSCalendarUnitMonth + NSCalendarUnitDay +
                                         NSCalendarUnitHour + NSCalendarUnitMinute +
                                         NSCalendarUnitSecond fromDate:[_datePicker date]];
        content.title = @"Reminder for task";
        content.subtitle = _nameView.text;
        content.body = _desView.text;
        content.badge = [NSNumber numberWithInteger:([UIApplication sharedApplication].applicationIconBadgeNumber + 1)];
        
        content.sound = [UNNotificationSound defaultSound];
        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDate repeats:NO];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:_nameView.text content:content trigger:trigger];
        [center addNotificationRequest:request withCompletionHandler:nil];
}
- (IBAction)high:(id)sender {

    _priorityView.text=@"High";

}
- (IBAction)low:(id)sender {
    _priorityView.text=@"Low";

}
- (IBAction)medium:(id)sender {
    _priorityView.text=@"Meduim";

}

- (IBAction)inprogressBtn:(id)sender {
    _inProgressView.text=@"InProgress";
}
- (IBAction)isDoneBtn:(id)sender {
    _inProgressView.text=@"Done";

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
