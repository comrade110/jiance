//
//  KFDetailViewController.m
//  jiance
//
//  Created by user on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "KFDetailViewController.h"


@implementation KFDetailViewController


@synthesize kfdic,kfarr,kftabcount,mac,begintime,endtime;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        kfdic = nil;
        kfarr = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.kftabcount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        
    } 
    // Configure the cell...
    NSDictionary *tempDic;
    UILabel *macL = [[UILabel alloc] initWithFrame:CGRectMake(10, 53, cell.frame.size.width*0.6, 20)];
    
    UILabel *begintimeL = [[UILabel alloc] initWithFrame:CGRectMake(10, 85, cell.frame.size.width*0.45, 20)];
        
    UILabel *endtimeL = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width*0.6, 85, cell.frame.size.width*0.45, 20)];
    macL.font = [UIFont systemFontOfSize:10];
    begintimeL.font = [UIFont systemFontOfSize:10];
    begintimeL.textAlignment = UITextAlignmentLeft;
    endtimeL.font = [UIFont systemFontOfSize:10];
    endtimeL.textAlignment = UITextAlignmentLeft;
    if (self.kfarr != nil) {
        tempDic = [self.kfarr objectAtIndex:indexPath.row]; 
    }else {
        tempDic = self.kfdic;
    }
    UIImageView *endtimeV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5,36, 36)];
    int mtype = [[tempDic objectForKey:@"type"] intValue];
    NSString *mstate = [tempDic objectForKey:@"endtime"];
    
    macL.text = [NSString stringWithFormat:@"Mac地址：%@",[tempDic objectForKey:@"mac"]];
    begintimeL.text = [NSString stringWithFormat:@"开机时间：%@",[tempDic objectForKey:@"begintime"]];
    if (mstate != nil) {
        
        endtimeL.text = [NSString stringWithFormat:@"关机时间：%d",mstate];
    }else {
        
        endtimeL.text = @"使用中";
        endtimeL.textColor = [UIColor greenColor];
    }

    
    switch (mtype) {
        case 0:
            if (mstate != nil) {            
                endtimeV.image = [UIImage imageNamed:@"hotelOfflineRoom0.png"];
            }else {
                endtimeV.image = [UIImage imageNamed:@"hotelActiveRoom0.png"];
            }
            break;
        case 1:
            if (mstate != nil) {            
            endtimeV.image = [UIImage imageNamed:@"hotelOfflineRoom1.png"];
        }else {
            endtimeV.image = [UIImage imageNamed:@"hotelActiveRoom1.png"];
        }
            break;
        case 2:
            if (mstate != nil) {            
                endtimeV.image = [UIImage imageNamed:@"hotelOfflineRoom2.png"];
            }else {
                endtimeV.image = [UIImage imageNamed:@"hotelActiveRoom2.png"];
            }
            break;
        case 3:
            if (mstate != nil) {            
                endtimeV.image = [UIImage imageNamed:@"hotelOfflineRoom3.png"];
            }else {
                endtimeV.image = [UIImage imageNamed:@"hotelActiveRoom3.png"];
            }
            break;
        case 4:
            break;
    }
    
    [cell.contentView addSubview:macL];
    [cell.contentView addSubview:begintimeL];
    [cell.contentView addSubview:endtimeL];
    [cell.contentView addSubview:endtimeV];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 110;
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
