//
//  AreaViewController.m
//  jiance
//
//  Created by user on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AreaViewController.h"
#import "ViewController.h"

@implementation AreaViewController


@synthesize sgArr;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    self.navigationItem.title = @"省份列表";
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[ClientClass sharedService] listArea:self action:@selector(listAreaHandler:)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)listAreaHandler:(id)value{
    
    if ([value isKindOfClass:[NSError class]]) {
        NSLog(@"Error: %@", value);
        return;
    }
    if ([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Fault: %@", value);
        return;
    }
    NSString *result = (NSString*)value;
    
    NSLog(@"haha%@",result);
    
     CXMLDocument *document = [[CXMLDocument alloc] initWithXMLString:result options:0 error:nil];
    
    sxp = [[SOAPXMlParse alloc] init];
    
    pArr =  [sxp parseDire:document nodeName:@"//province"];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.tableView reloadData];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return NO;
    } else {
        return YES;
    }
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
    return [pArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
         cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tb_bg.png"]]; 
        
    } else{ 
        NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews]; 
        for (UIView *subview in subviews) { 
            [subview removeFromSuperview]; 
        } 
    } 
    
    UILabel *provinceL = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, cell.frame.size.width*0.6, cell.frame.size.height*0.6)];
    UILabel *hotelL = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width*0.5, 10, cell.frame.size.width*0.35, cell.frame.size.height*0.6)];
    UILabel *alertL = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width*0.9, 5, 40, cell.frame.size.height*0.8)];
    NSDictionary *tempDic = [pArr objectAtIndex:indexPath.row];
    
    NSDictionary *tempDic2 = [tempDic objectForKey:@"province"];
    
    NSLog(@"%@~~~~",tempDic);
    
    int alertnum = 0;

    if ([[tempDic objectForKey:@"hotel"] isKindOfClass:[NSArray class]] ) {

        NSArray* tempArr = [tempDic objectForKey:@"hotel"];
        
        hotelL.text = [NSString stringWithFormat:@"共有%d家酒店",[tempArr count]];
        for (int i =0; i<[tempArr count]; i++) {
            if ([[[tempArr objectAtIndex:i] objectForKey:@"alert"] boolValue]) {
                alertnum ++;
            }
        }

        
    }else {
        hotelL.text = @"共有1家酒店";
       if ([[[tempDic objectForKey:@"hotel"] objectForKey:@"alert"] boolValue]) {
           alertnum = 1;
       }
    }
    
    
    hotelL.textAlignment = UITextAlignmentRight;
    hotelL.font = [UIFont systemFontOfSize:14];
    
    hotelL.backgroundColor = [UIColor clearColor];
    
    
    
    provinceL.text = [tempDic2 objectForKey:@"name"];
    
    provinceL.backgroundColor = [UIColor clearColor];
    if (alertnum >0) {
        
        UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(cell.frame.size.width*0.92, 15, 16, 16)];
        imgview.image = [UIImage imageNamed:@"jingbao.png"];
        
        alertL.text = [NSString stringWithFormat:@"%d",alertnum];
        alertL.font = [UIFont systemFontOfSize:12];
        alertL.textColor = [UIColor redColor];
        alertL.backgroundColor =  [UIColor clearColor];
        [cell.contentView addSubview:alertL];
        [cell.contentView addSubview:imgview];
    }
    
    [cell.contentView addSubview:provinceL];
    [cell.contentView addSubview:hotelL];
    
    
    
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

        UIStoryboard *sb;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            sb = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad"
                                           bundle:nil];
        }else {
            sb =[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                          bundle:nil];
        }

        NSDictionary *tempDic = [pArr objectAtIndex:indexPath.row];
        NSArray* tempArr = [tempDic objectForKey:@"hotel"];

    
        ViewController *viewController = [sb instantiateViewControllerWithIdentifier:@"ViewController"];
        
        
        if ([[tempDic objectForKey:@"hotel"] isKindOfClass:[NSArray class]] ){
            
            viewController.hotelArr = tempArr;
    
        }else {
            NSMutableArray *ta = [NSMutableArray array];
            [ta addObject:tempArr];
            viewController.hotelArr = ta;
        }
        // ...
        // Pass the selected object to the new view controller.
        [self.navigationController pushViewController:viewController animated:YES];
}



@end
