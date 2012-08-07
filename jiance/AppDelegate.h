//
//  AppDelegate.h
//  jiance
//
//  Created by user on 12-7-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Reachability;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{

    
    Reachability* hostReach;
    Reachability* internetReach;
    Reachability* wifiReach;

}

@property (strong, nonatomic) UIWindow *window;

@end
