//
//  JKViewController.m
//  jiance
//
//  Created by user on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "JKViewController.h"


@implementation JKViewController

@synthesize myTitle,cpu,usemen,disk,nis;

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
    
    mid = [userDefaults objectForKey:@"mid"];
    
    [[ClientClass sharedService] getMachineMonitor:self action:@selector(getMachineMonitorHandler:) machineid:(long)[mid longLongValue] time:1];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


-(void)getMachineMonitorHandler:(id)value{

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
    
    NSArray* tempArr = [sxp parseDire2:document nodeName:@"//status"];
    
    if ([tempArr count]== 0) {
        
        NSLog(@"%@",tempArr);
        
        myTitle.text = @"服务器异常";
        return;
    }
    
    NSDictionary *tempDic = [[tempArr objectAtIndex:0] objectForKey:@"status"];
    
    if ([[tempDic objectForKey:@"error"] boolValue] == NO) {
        NSString *allmen = [NSString stringWithFormat:@"%dMB",[[tempDic objectForKey:@"allmen"] intValue]/1024];
        
        NSString *alldisk = [NSString stringWithFormat:@"%dG",[[tempDic objectForKey:@"alldisk"] intValue]/1048576];
        
        cpu.text = [NSString stringWithFormat:@"%d%%",[[tempDic objectForKey:@"cpu"] floatValue]*100]; 
        
        usemen.text = [NSString stringWithFormat:@"%.1fMB/%@",(float)[[tempDic objectForKey:@"usemen"] intValue]/1024,allmen]; 
        
        disk.text = [NSString stringWithFormat:@"%.1fG/%@",(float)[[tempDic objectForKey:@"usedisk"] intValue]/1048576,alldisk]; 
        
        nis.text = [NSString stringWithFormat:@"%@KB",[tempDic objectForKey:@"nis"]]; 
    }
    NSLog(@"%@",result);
    


}

-(IBAction)reflashData:(id)sender{
    
    [[ClientClass sharedService] getMachineMonitor:self action:@selector(getMachineMonitorHandler:) machineid:(long)[mid longLongValue] time:1];

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
