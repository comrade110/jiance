//
//  ClientClass.m
//  jiance
//
//  Created by user on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ClientClass.h"

@implementation ClientClass

static SDZMonitorService *server = nil;
+(SDZMonitorService *)sharedService{
    
    @synchronized(self){
        if (server == nil) {
            server = [SDZMonitorService service];
        }
    }

    return server;
}



@end
