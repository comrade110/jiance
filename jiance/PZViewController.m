//
//  PZViewController.m
//  jiance
//
//  Created by user on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PZViewController.h"
#import "iToast.h"


@implementation PZViewController


@synthesize label1,label2,label3,label4,label5,label6,label7,label8,label9,label10,label11,label12,label13,label14,label15,label16,label17;
@synthesize view1,sview,textView;

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
    
    sview.pagingEnabled = YES;
    
    sview.contentSize = view1.frame.size;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    hid = [userDefaults objectForKey:@"hid"];
    
    NSLog(@"~~%@~~",hid);
    
    
    [[ClientClass sharedService] getHotelInfo:self action:@selector(getHotelInfoHandler:) hotelid:[hid intValue]];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)getHotelInfoHandler:(id)value{
    
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
    
    NSLog(@"breakpoint1");
    if (result == nil) {
        [[iToast makeText:@"无数据"] show];
        return;
    }
    NSArray* tempArr = [sxp parseDire:document nodeName:@"//hotel"];
    
    NSDictionary *tempDic = [[tempArr objectAtIndex:0] objectForKey:@"hotel"];
    
    NSLog(@"breakpoint2");
    
    label1.text = [tempDic objectForKey:@"hid"];
    label2.text = [tempDic objectForKey:@"name"];
    label3.text = [tempDic objectForKey:@"dengji"];
    label4.text = [tempDic objectForKey:@"province"];
    label5.text = [tempDic objectForKey:@"area"];
    label6.text = [tempDic objectForKey:@"address"];
    label7.text = [tempDic objectForKey:@"phone"];
    label8.text = [tempDic objectForKey:@"fax"];
    label9.text = [tempDic objectForKey:@"homepage"];
    
    NSDictionary *tempDic2 = [[tempArr objectAtIndex:0] objectForKey:@"machine"];
    
    if ([tempDic2 isKindOfClass:[NSArray class]]) {
        NSLog(@"dayu1");
        tempDic2 = [(NSArray*)tempDic2 objectAtIndex:0];
    }
    
    NSLog(@"breakpoint3");
    if (tempDic2 != nil) {
        if ([tempDic2 objectForKey:@"name"] != nil) {
            
            label10.text = [tempDic2 objectForKey:@"name"];
        }
        if ([tempDic2 objectForKey:@"vnc"] != nil) {
            
            
            label11.text = [tempDic2 objectForKey:@"vnc"];
        }
        label12.text = [tempDic2 objectForKey:@"os"];
        if ([[tempDic2 objectForKey:@"os"] intValue] == 1) {
            label12.text = @"Windows";
        }else if ([[tempDic2 objectForKey:@"os"] intValue] == 2) {
            label12.text = @"Linux";
        }
        if ([tempDic2 objectForKey:@"mem"] != nil) {
            
            label13.text = [tempDic2 objectForKey:@"mem"];
        }
        if ([tempDic2 objectForKey:@"mid"] != nil) {
            
            label14.text = [tempDic2 objectForKey:@"mid"];
        }
        if ([tempDic2 objectForKey:@"note"] != nil) {
            
            label15.text = [tempDic2 objectForKey:@"note"];
        }
        if ([tempDic2 objectForKey:@"cpu"] != nil) {
            
            label16.text = [tempDic2 objectForKey:@"cpu"];
        }
        if ([tempDic2 objectForKey:@"mac"] != nil) {
            
            label17.text = [tempDic2 objectForKey:@"mac"];
        }

    }
    
    NSString *clText = @"";
    
    NSLog(@"breakpoint4");
    
    if ([[[tempArr objectAtIndex:0] objectForKey:@"alert"] isKindOfClass:[NSArray class]] ){
    
        
        NSLog(@"breakpoint5");
        NSArray *tempArr3 = [[tempArr objectAtIndex:0] objectForKey:@"alert"];
        for (int i = 0; i<[tempArr3 count]; i++) {
            NSDictionary *tempDic3 = [tempArr3 objectAtIndex:i];
            
            NSString *alertid = [tempDic3 objectForKey:@"alertid"];
            NSString *name = [tempDic3 objectForKey:@"name"];
            NSString *note = [tempDic3 objectForKey:@"note"];
            
            NSString *celue = [NSString stringWithFormat:@"策略%@\n策略名称：%@\n报警描述%@\n\n ------------",alertid,name,note];
            
            clText = [NSString stringWithFormat:@"%@\n%@\n",clText,celue];
            
            
        }
    }else {
        
        NSLog(@"breakpoint6");
        NSDictionary *tempD = [[tempArr objectAtIndex:0] objectForKey:@"alert"];
        NSString *alertid = [tempD objectForKey:@"alertid"];
        NSString *name = [tempD objectForKey:@"name"];
        NSString *note = [tempD objectForKey:@"note"];
        
        NSString *celue = [NSString stringWithFormat:@"策略%@\n策略名称：%@\n报警描述%@\n\n ------------",alertid,name,note];
        
        clText = [NSString stringWithFormat:@"%@\n%@\n",clText,celue];
    }
    

    


    if(clText == nil){
        
        textView.text = @"暂无策略";
    }else {
        
        textView.text = clText;
    }

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:label14.text forKey:@"mid"];


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
