//
//  JBViewController.m
//  jiance
//
//  Created by user on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "JBViewController.h"


@implementation JBViewController

@synthesize logWV;

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
    [[ClientClass sharedService] getAlertLog:self action:@selector(getAlertLogHandler:) hotelid:[hid intValue] start:0 limit:10];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)getAlertLogHandler:(id)value{
    
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
    
    NSArray* tempArr = [sxp parseDire2:document nodeName:@"//alert"];
    
    if ([tempArr count] == 0) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        allstr = @"<html><body style=\"text-align:center; color:#666\"><br/><br/><br/><b>暂无数据</b></body></html>";        
        [logWV loadHTMLString:allstr baseURL:nil];
        return;
    }
    allstr = @"";
    for (int i = 0; i < [tempArr count]; i++) {
        NSDictionary *tempDic = [[tempArr objectAtIndex:i] objectForKey:@"alert"];
        NSString *begintime = [tempDic objectForKey:@"begintime"];
        NSString *endtime = [tempDic objectForKey:@"endtime"];
        NSString *level = [tempDic objectForKey:@"level"];
        NSString *name = [tempDic objectForKey:@"name"];
        NSString *note = [tempDic objectForKey:@"note"];
        NSString *status = [tempDic objectForKey:@"status"];
        
        if ([status intValue] == 0) {
            status = @"报警中";
            allstr = [NSString stringWithFormat:
                      @"%@<p style=\"color:red; font-size:12px;\">报警策略:%@ 报警内容:%@<br/>报警级别:%@<br/>开始时间:%@<br/>结束时间:%@<br/>状态:%@</p>",
                      allstr,name,note,level,begintime,endtime,status];
        }else {
            status = @"已解除";
            allstr = [NSString stringWithFormat:
                      @"%@<p style=\"font-size:12px;\">报警策略:%@ 报警内容:%@<br/>报警级别:%@<br/>开始时间:%@<br/>结束时间:%@<br/>状态:%@</p>",
                      allstr,name,note,level,begintime,endtime,status];
        }
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [logWV loadHTMLString:allstr baseURL:nil];
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
