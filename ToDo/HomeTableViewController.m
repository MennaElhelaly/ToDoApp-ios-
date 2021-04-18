//
//  HomeTableViewController.m
//  ToDo
//
//  Created by Menna Elhelaly on 4/5/21.
//  Copyright © 2021 Menna Elhelaly. All rights reserved.
//

#import "HomeTableViewController.h"
#import "ViewController.h"
#import "Task.h"

@interface HomeTableViewController ()


@end

@implementation HomeTableViewController{
    
    NSMutableArray *tasks;
    Task *newTask;
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    tasks =[NSMutableArray new];
    newTask =[Task new];
    newTask.name=@"meeting";
    newTask.priority =@"high";
    [tasks addObject:newTask];
    
  /*  UIBarButtonItem *btnAdd =[[UIBarButtonItem alloc]
       initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(addPressed)];
       
       [self.navigationItem setRightBarButtonItem:btnAdd];*/
    
   
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text=[[tasks objectAtIndex:indexPath.row] name];
    cell.imageView.image=[UIImage imageNamed:@"high"];
    
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *titleName=@"All";
   
    return titleName;
}
-(void)addPressed{
    ViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
         
          
          [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)addTaskBtn:(id)sender {
    ViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
      
       [self.navigationController pushViewController:vc animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tasks removeObjectAtIndex:indexPath.row];

        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
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
