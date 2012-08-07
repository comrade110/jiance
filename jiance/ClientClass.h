//
//  ClientClass.h
//  jiance
//
//  Created by user on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDZMonitorService.h"



@interface ClientClass : NSObject

+(SDZMonitorService *)sharedService;
@end
