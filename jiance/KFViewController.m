//
//  KFViewController.m
//  jiance
//
//  Created by user on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "KFViewController.h"


@implementation KFViewController

@synthesize roomInfo, startBtn, endBtn, searchBtn, resetBtn, startTime,endTime;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    hid = [userDefaults objectForKey:@"hid"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[ClientClass sharedService] getRooms:self action:@selector(getRoomsHandler:) hotelid:[hid intValue]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [UIView beginAnimations:@"comeOut" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    nav.frame = CGRectMake(0, 480, 320, 44);
    dp.frame = CGRectMake(0, 524, 320, 240);
    [UIView setAnimationDelegate:nav];
    [UIView setAnimationDelegate:dp];
    [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
    [UIView commitAnimations];
    startBtn.userInteractionEnabled = YES;
    endBtn.userInteractionEnabled = YES; 
    searchBtn.userInteractionEnabled = YES;
    resetBtn.userInteractionEnabled = YES;  
    

}

-(void)getRoomsHandler:(id)value{
    
    if ([value isKindOfClass:[NSError class]]) {
        NSLog(@"Error: %@", value);
        return;
    }
    if ([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Fault: %@", value);
        return;
    }
    
    NSString *result = (NSString*)value;
    
    CXMLDocument *document = [[CXMLDocument alloc] initWithXMLString:result options:0 error:nil];
    
    SOAPXMlParse *sxp = [[SOAPXMlParse alloc] init];
    
    NSArray* tempArr = [sxp parseDire2:document nodeName:@"//room"];
    
    NSString *allstr = @"";
    
    if ([tempArr count] == 0) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        allstr = @"暂无数据";        
        roomInfo.text = allstr;
        return;
    }
    for (int i = 0; i < [tempArr count]; i++) {
        NSDictionary *tempDic = [[tempArr objectAtIndex:i] objectForKey:@"room"];
        NSString *mac = [[tempDic objectForKey:@"mac"] uppercaseString];
        NSString *roomno = [tempDic objectForKey:@"roomno"];
        NSString *begintime = [tempDic objectForKey:@"begintime"];
        NSString *endtime = [tempDic objectForKey:@"endtime"];
        if (roomno == nil || [roomno isEqualToString:@""]) {
            roomno =@"---";
        }
        if (begintime == nil) {
            begintime =@"00000000000000";
        }
        if (endtime == nil) {
            endtime = @"      使用中";
        }
      
        allstr = [NSString stringWithFormat:@"%@\nMAC:%@  房间号:%@  开机时间:%@  关机时间:%@\n",allstr,mac,roomno,begintime,endtime];
        
//        allstr = [NSString stringWithFormat:@"%@\n%@  %@  %@  %@\n",allstr,mac,roomno,begintime,endtime];
        
    }
   [MBProgressHUD hideHUDForView:self.view animated:YES];    
    roomInfo.text = allstr;
}


-(IBAction)startTimeBtnPress:(id)sender{
    nav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 480, 320, 44)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(getSD)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(outED)];
    UINavigationItem *dsd = [[UINavigationItem alloc] init];
    [dsd setRightBarButtonItem:item animated:YES];
    [dsd setLeftBarButtonItem:item2 animated:YES];
    nav.items = [NSArray arrayWithObject:dsd];
    
    dp = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 524, 320, 240)];
    [UIView beginAnimations:@"comeIn" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    nav.frame = CGRectMake(0, 107, 320, 44);
    dp.frame = CGRectMake(0, 151, 320, 240);
    [UIView commitAnimations];
    [self.view addSubview:dp];
    [self.view addSubview:nav];
    
    startBtn.userInteractionEnabled = NO;
    endBtn.userInteractionEnabled = NO;
    searchBtn.userInteractionEnabled = NO;
    resetBtn.userInteractionEnabled = NO;
    
}
-(IBAction)endTimeBtnPress:(id)sender{
    nav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 480, 320, 44)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(getED)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(outED)];
    UINavigationItem *dsd2 = [[UINavigationItem alloc] init];
    [dsd2 setRightBarButtonItem:item animated:YES];
    [dsd2 setLeftBarButtonItem:item2 animated:YES];
    nav.items = [NSArray arrayWithObject:dsd2];
    
    dp = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 524, 320, 240)];
    [UIView beginAnimations:@"comeOut" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    nav.frame = CGRectMake(0, 107, 320, 44);
    dp.frame = CGRectMake(0, 151, 320, 240);
    [UIView commitAnimations];
    [self.view addSubview:dp];
    [self.view addSubview:nav];
    
    
    startBtn.userInteractionEnabled = NO;
    endBtn.userInteractionEnabled = NO;
    searchBtn.userInteractionEnabled = NO;
    resetBtn.userInteractionEnabled = NO;
    
    
}

-(void)getSD{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    stodate = [dateFormatter stringFromDate:[dp date]];
    [dateFormatter setDateFormat:@"Y-MM-dd HH:mm"];
    
    startTime.text = [dateFormatter stringFromDate:[dp date]];
    [self outED];
}

-(void)getED{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    etodate = [dateFormatter stringFromDate:[dp date]];
    [dateFormatter setDateFormat:@"Y-MM-dd HH:mm"];
    
    endTime.text = [dateFormatter stringFromDate:[dp date]];
    [self outED];

}
-(void)outED{
    [UIView beginAnimations:@"comeOut" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    nav.frame = CGRectMake(0, 480, 320, 44);
    dp.frame = CGRectMake(0, 524, 320, 240);
    [UIView setAnimationDelegate:nav];
    [UIView setAnimationDelegate:dp];
    [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
    [UIView commitAnimations];
    startBtn.userInteractionEnabled = YES;
    endBtn.userInteractionEnabled = YES; 
    searchBtn.userInteractionEnabled = YES;
    resetBtn.userInteractionEnabled = YES;  

}

// 重置时间

-(IBAction)resetTime:(id)sender{
    
    startTime.text = nil;
    endTime.text = nil;
}

-(IBAction)searchKFData:(id)sender{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[ClientClass sharedService] getHistoryRooms:self action:@selector(getHistoryRoomsHandler:) hotelid:[hid intValue] mac:nil sbegin:startTime.text send:endTime.text start:0 limit:30];

}

-(void)getHistoryRoomsHandler:(id)value{

    if ([value isKindOfClass:[NSError class]]) {
        NSLog(@"Error: %@", value);
        return;
    }
    if ([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Fault: %@", value);
        return;
    }
    
    NSString *result = (NSString*)value;
    
    CXMLDocument *document = [[CXMLDocument alloc] initWithXMLString:result options:0 error:nil];
    
    SOAPXMlParse *sxp = [[SOAPXMlParse alloc] init];
    
    NSArray* tempArr = [sxp parseDire2:document nodeName:@"//roomlog"];
    
    
    NSString *allstr = @"";
    if ([tempArr count] == 0) {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
        allstr = @"暂无数据";        
        roomInfo.text = allstr;
        return;
    }
    for (int i = 0; i < [tempArr count]; i++) {
        NSDictionary *tempDic = [[tempArr objectAtIndex:i] objectForKey:@"roomlog"];
        NSString *mac = [[tempDic objectForKey:@"mac"] uppercaseString];
        NSString *roomno = [tempDic objectForKey:@"roomno"];
        NSString *begintime = [tempDic objectForKey:@"begintime"];
        NSString *endtime = [tempDic objectForKey:@"endtime"];
        if (roomno == nil || [roomno isEqualToString:@""]) {
            roomno =@"---";
        }
        if (begintime == nil) {
            begintime =@"00000000000000";
        }
        if (endtime == nil) {
            endtime = @"      使用中";
        }
        
        allstr = [NSString stringWithFormat:@"%@\nMAC:%@  房间号:%@  开机时间:%@  关机时间:%@\n",allstr,mac,roomno,begintime,endtime];
        
//        allstr = [NSString stringWithFormat:@"%@\n%@  %@  %@  %@\n",allstr,mac,roomno,begintime,endtime];
        
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    roomInfo.text = allstr;

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
