//
//  ViewController.m
//  jiance
//
//  Created by user on 12-7-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "JCTabBarController.h"
#import "AreaViewController.h"


@implementation ViewController

@synthesize mTableView,hotelArr,hotelDic;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mTableView.delegate = self;
    mTableView.dataSource = self;
    
    self.navigationItem.title = @"云和数据监控中心";
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    if ([hotelArr count] == 0) {
            return 1;
    }else {
       
            
            return [hotelArr count];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [mTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        
    } 
    CGRect screenFrame = [[UIScreen mainScreen]applicationFrame];
    
    if ([hotelArr count] == 0) {
        return cell;
    }
    
    hotelName = [[UILabel alloc] initWithFrame:CGRectMake(screenFrame.size.width*0.05, 6, 220, 20)];
    
    NSDictionary *tempDic =[hotelArr objectAtIndex:indexPath.row];
   
    
    
    hotelName.text = [tempDic objectForKey:@"name"];
    
    hotelName.font = [UIFont systemFontOfSize:14.0f];

//  显示状态的uilabel 警报中/正常/未监控
    
    UILabel *stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenFrame.size.width*0.75, 8, 60, 20)];
    if ([[tempDic objectForKey:@"needalert"] isEqualToString:@"true"]) {
        if ([[tempDic objectForKey:@"alert"] isEqualToString:@"false"]) {
            stateLabel.textColor = [UIColor greenColor];
            stateLabel.text = @"正常";
        }else if ([[tempDic objectForKey:@"alert"] isEqualToString:@"true"]) {
            stateLabel.textColor = [UIColor redColor];
            stateLabel.text = @"警报中";
        }
    }else if ([[tempDic objectForKey:@"needalert"] isEqualToString:@"false"]) {
        stateLabel.textColor = [UIColor grayColor];
        stateLabel.text = @"未监控";
    }
    
    stateLabel.font = [UIFont systemFontOfSize:14.0f];
    
//  online/offline客房数量  
    UILabel *activeroom = [[UILabel alloc] initWithFrame:CGRectMake(screenFrame.size.width*0.05, 29, 220, 14)];
    
    NSString *activeRoomStr = [tempDic objectForKey:@"activeroomnum"];
    
    activeroom.text = [NSString stringWithFormat:@"在线客房数量:%@",activeRoomStr];
    
    if ([tempDic objectForKey:@"activeroomnum"] == nil) {
        activeroom.text = @"在线客房数量:";
    }
    
    activeroom.font = [UIFont systemFontOfSize:9.0f];
    
    activeroom.textColor = [UIColor grayColor];
    
    
    [cell.contentView addSubview:hotelName];
    [cell.contentView addSubview:stateLabel];
    [cell.contentView addSubview:activeroom];
    // Configure the cell...
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{  
    UIStoryboard*  sb;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        sb = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad"
                                                      bundle:nil];
    }else {
        sb =[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                    bundle:nil];
    }
    
     NSString *hidStr;
    
    NSDictionary *tempDic = [hotelArr objectAtIndex:indexPath.row];
    hidStr = [tempDic objectForKey:@"hid"];
    
    
   
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:hidStr forKey:@"hid"];
    
    JCTabBarController *jCTabBarController = [sb instantiateViewControllerWithIdentifier:@"JCTabBarController"];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:jCTabBarController animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return NO;
    } else {
        return YES;
    }
}

@end
