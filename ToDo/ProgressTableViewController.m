//
//  ProgressTableViewController.m
//  ToDo
//
//  Created by Menna Elhelaly on 4/5/21.
//  Copyright © 2021 Menna Elhelaly. All rights reserved.
//

#import "ProgressTableViewController.h"
#import "Task.h"
#import "EditViewController.h"

@interface ProgressTableViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sortData;

@end

@implementation ProgressTableViewController{
    NSMutableArray *tasks;
    NSMutableArray *highArr;
    NSMutableArray *lowArr;
    NSMutableArray *midArr;
       NSUserDefaults *userDefaults;
       NSDate *data;
    BOOL sort;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    sort=NO;
    [self.tableView reloadData];
    
}
-(void)viewWillAppear:(BOOL)animated{
    tasks =[NSMutableArray new];
    highArr =[NSMutableArray new];
    lowArr =[NSMutableArray new];
    midArr =[NSMutableArray new];
    sort=NO;
    userDefaults = [NSUserDefaults standardUserDefaults];
      data=[userDefaults objectForKey:@"progress"];
      tasks = [NSKeyedUnarchiver unarchiveObjectWithData:data];
   
       NSString *priority =[NSString new];
    
       for(int i=0;i<[tasks count];i++){
                 priority= [[tasks objectAtIndex:i] priorityValue];

               if([priority isEqual:@"High"] ){
                   [highArr addObject:[tasks objectAtIndex:i]];

                }
                else if([priority isEqual:@"Meduim"] ){
                    [midArr addObject:[tasks objectAtIndex:i]];

                }else{
                    [lowArr addObject:[tasks objectAtIndex:i]];

                }
       }
       [self.tableView reloadData];
    
}
- (IBAction)sortSections:(id)sender {
    sort=YES;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger sec=1;
    if(sort==YES)
    {
        sec=3;
    }
    else
    {
        sec=1;
    }
    return sec;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
NSInteger sec=0;
if(sort==YES){
    switch (section) {
           case 0:
               sec=[highArr count];
               break;
           case 1:
               sec=[midArr count];
               break;
            case 2:
                sec=[lowArr count];
            break;
               
           default:
               break;
       }
    
    }else{
        sec=[tasks count];
    }
return sec;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(sort ==YES){
    switch (indexPath.section) {
           case 0:
               cell.textLabel.text=[[highArr objectAtIndex:indexPath.row] name];
            cell.imageView.image=[UIImage imageNamed:@"high"];

               break;
           case 1:
               cell.textLabel.text=[[midArr objectAtIndex:indexPath.row] name];
            cell.imageView.image=[UIImage imageNamed:@"Medium"];

               break;
        case 2:
            cell.textLabel.text=[[lowArr objectAtIndex:indexPath.row] name];
            cell.imageView.image=[UIImage imageNamed:@"low"];

            break;
               
           default:
               break;
       }
    }else{
    // Configure the cell...
    NSString *priority =[NSString new];
       priority= [[tasks objectAtIndex:indexPath.row] priorityValue];
       
       cell.textLabel.text=[[tasks objectAtIndex:indexPath.row] name];

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

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if(sort==NO){
        [tasks removeObjectAtIndex:indexPath.row];
        NSDate *dataObject=[NSKeyedArchiver archivedDataWithRootObject:tasks];
        [userDefaults setObject:dataObject forKey:@"progress"];
        [userDefaults synchronize];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            tasks =[NSMutableArray new];
           highArr =[NSMutableArray new];
           lowArr =[NSMutableArray new];
           midArr =[NSMutableArray new];
           sort=NO;
           userDefaults = [NSUserDefaults standardUserDefaults];
            data=[userDefaults objectForKey:@"progress"];
            tasks = [NSKeyedUnarchiver unarchiveObjectWithData:data];
          
            NSString *priority =[NSString new];
           
            for(int i=0;i<[tasks count];i++){
                  priority= [[tasks objectAtIndex:i] priorityValue];

                  if([priority isEqual:@"High"] ){
                      [highArr addObject:[tasks objectAtIndex:i]];

                   }
                   else if([priority isEqual:@"Meduim"] ){
                       [midArr addObject:[tasks objectAtIndex:i]];

                   }else{
                       [lowArr addObject:[tasks objectAtIndex:i]];

                   }
              }
           [self.tableView reloadData];
            
        }
        else{
            printf("cant delete");
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Alert" message:@"Can not Delete While Sorting Mode" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    EditViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"EditViewController"];
    if(sort ==NO){

    [vc setDetails:[tasks objectAtIndex:indexPath.row]];
    [vc setIndexOfItem:indexPath.row];
    [vc setIdView:2];
    [vc setPro2:self];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        printf("cant edit while sorting");
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Alert" message:@"Can not edit while sorting mode" preferredStyle:UIAlertControllerStyleAlert];
           UIAlertAction *ok =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
           [alert addAction:ok];
           [self presentViewController:alert animated:YES completion:nil];
    }

}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *titleName=@"";
    if(sort==YES){
          switch (section) {
              case 0:
                  titleName =@"High";
                  break;
              case 1:
                  titleName =@"Medium";
                  break;
              case 2:
                  titleName =@"Low";
                  break;
              default:
                  break;
          }
          
    }else{
        titleName=@"All In Progress";
    }
    return titleName;
}
-(void)refresh{
    userDefaults = [NSUserDefaults standardUserDefaults];
        data=[userDefaults objectForKey:@"progress"];
        tasks = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [self.tableView reloadData];

}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
