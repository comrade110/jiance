//
//  SOAPXMlParse.m
//  jiance
//
//  Created by user on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SOAPXMlParse.h"

@implementation SOAPXMlParse

- (NSArray *) parseDire:(CXMLDocument *) document nodeName:(NSString*) nodePathName
{
    NSMutableArray *ar=[[NSMutableArray alloc] init];
    
    NSArray *nodes=nil;
    nodes=[document nodesForXPath:nodePathName error:nil];
    
    NSString *strValue;
    NSString *strName;
    
    for (CXMLElement *node in nodes) {
        NSMutableDictionary *object=[[NSMutableDictionary alloc] init];
        
        // process to set attributes of object ----------------------------------------
        NSMutableDictionary *objectAttributes=[[NSMutableDictionary alloc] init];
        NSArray *arAttr=[node attributes];
        NSUInteger i, countAttr = [arAttr count];
        for (i = 0; i < countAttr; i++) {
            strValue=[[arAttr objectAtIndex:i] stringValue];
            strName=[[arAttr objectAtIndex:i] name];
            if(strValue && strName){
                [objectAttributes setValue:strValue forKey:strName];
            }
        }
        [object setValue:objectAttributes forKey:[node name]];
        // --------------------------------------------------------------------------------

        // process to read elements of object ----------------------------------------
        NSUInteger j, countElements = [node childCount];
        
        CXMLNode *element;
        NSMutableDictionary *elementDictionary=nil;
        for (j=0; j<countElements; j++)
        {
            element=[node childAtIndex:j];
            elementDictionary=[[NSMutableDictionary alloc] init];
            
            // process to read element attributes ----------------------------------
            if([element isMemberOfClass:[CXMLElement class]]){
                CXMLElement *element2=(CXMLElement*)element;
                arAttr=[element2 attributes];
                countAttr=[arAttr count];
                for (i=0; i<countAttr; i++) {
                    strName=[[arAttr objectAtIndex:i] name];
                    strValue=[[arAttr objectAtIndex:i] stringValue];
                    if(strName && strValue){
                        [elementDictionary setValue:strValue forKey:strName];
                    }
                }
            }
            // --------------------------------------------------------------------
            
            // element value if available
            strValue=[element stringValue];
//            if(strValue){
//                [elementDictionary setValue:strValue forKey:@"value"];
//            }
            // ---------------------------------------------------------------------
            
            // check if object/dictionary exists for this key "name"
            strName=[element name];
            if([object valueForKey:strName]){
                if([[object valueForKey:strName] isKindOfClass:[NSMutableDictionary class]]){
                    NSMutableDictionary *d2=[[NSMutableDictionary alloc] initWithDictionary:[object valueForKey:strName]];
                    NSMutableArray *arOFSameElementName=[[NSMutableArray alloc] initWithObjects:d2,elementDictionary,nil];
                    [object setValue:arOFSameElementName forKey:strName];

                } else {
                    NSMutableArray *arOFSameElementName=[object valueForKey:strName];
                    [arOFSameElementName addObject:elementDictionary];
                }
            } else {
                [object setValue:elementDictionary forKey:strName];
            }
            
            
            

            
            NSUInteger k, countElements2 = [element childCount];
            CXMLNode *elementTWO;
            NSMutableDictionary *elementDictionary2=nil;
            for (k=0; k<countElements2; k++)
            {
                elementTWO=[element childAtIndex:k];
                
                elementDictionary2=[[NSMutableDictionary alloc] init];
                
                // process to read element attributes ----------------------------------
                if([elementTWO isMemberOfClass:[CXMLElement class]]){
                    CXMLElement *element3=(CXMLElement*)elementTWO;
                    arAttr=[element3 attributes];
                    countAttr=[arAttr count];
                    for (i=0; i<countAttr; i++) {
                        strName=[[arAttr objectAtIndex:i] name];
                        strValue=[[arAttr objectAtIndex:i] stringValue];
                        if(strName && strValue){
                            [elementDictionary2 setValue:strValue forKey:strName];
                            NSUInteger p, countElements3 = [elementTWO childCount];
                            CXMLNode *elementTHREE;
                            NSMutableDictionary *elementDictionary3=nil;
                            for (p=0; p<countElements3; p++)
                            {
                                elementTHREE=[elementTWO childAtIndex:p];
                                
                                elementDictionary3=[[NSMutableDictionary alloc] init];
                                
                                // process to read element attributes ----------------------------------
                                if([elementTHREE isMemberOfClass:[CXMLElement class]]){
                                    CXMLElement *element4=(CXMLElement*)elementTHREE;
                                    arAttr=[element4 attributes];
                                    countAttr=[arAttr count];
                                    for (i=0; i<countAttr; i++) {
                                        strName=[[arAttr objectAtIndex:i] name];
                                        strValue=[[arAttr objectAtIndex:i] stringValue];
                                        if(strName && strValue){
                                            [elementDictionary3 setValue:strValue forKey:strName];
                                        }
                                    }
                                }
                                // --------------------------------------------------------------------
                                
                                // element value if available
                                strValue=[elementTHREE stringValue];
                                //            if(strValue){
                                //                [elementDictionary setValue:strValue forKey:@"value"];
                                //            }
                                // ---------------------------------------------------------------------
                                
                                // check if object/dictionary exists for this key "name"
                                strName=[elementTHREE name];
                                if([object valueForKey:strName]){
                                    if([[object valueForKey:strName] isKindOfClass:[NSMutableDictionary class]]){
                                        NSMutableDictionary *d3=[[NSMutableDictionary alloc] initWithDictionary:[object valueForKey:strName]];
                                        NSMutableArray *arOFSameElementName=[[NSMutableArray alloc] initWithObjects:d3,elementDictionary3,nil];
                                        [object setValue:arOFSameElementName forKey:strName];
                                        
                                    } else {
                                        NSMutableArray *arOFSameElementName=[object valueForKey:strName];
                                        [arOFSameElementName addObject:elementDictionary3];
                                    }
                                } else {
                                    [object setValue:elementDictionary3 forKey:strName];
                                }
                            }

                        }
                    }
                }
                // --------------------------------------------------------------------
                
                // element value if available
                strValue=[elementTWO stringValue];
                //            if(strValue){
                //                [elementDictionary setValue:strValue forKey:@"value"];
                //            }
                // ---------------------------------------------------------------------
                
                // check if object/dictionary exists for this key "name"
                strName=[elementTWO name];
                if([object valueForKey:strName]){
                    if([[object valueForKey:strName] isKindOfClass:[NSMutableDictionary class]]){
                        NSMutableDictionary *d2=[[NSMutableDictionary alloc] initWithDictionary:[object valueForKey:strName]];
                        NSMutableArray *arOFSameElementName=[[NSMutableArray alloc] initWithObjects:d2,elementDictionary2,nil];
                        [object setValue:arOFSameElementName forKey:strName];
                        
                    } else {
                        NSMutableArray *arOFSameElementName=[object valueForKey:strName];
                        [arOFSameElementName addObject:elementDictionary2];
                    }
                } else {
                    [object setValue:elementDictionary2 forKey:strName];
                }
            }
            

            

            // ---------------------------------------------------------------------
        }
        
        [ar addObject:object];
        // --------------------------------------------------------------------------------
    }
//    NSLog(@"~~##%@##~~",[ar description]);
    return ar;
}

// 遍历节点所有节点 返回节点值数组

- (NSArray *) parseDire2:(CXMLDocument *) document nodeName:(NSString*) nodePathName
{
    NSMutableArray *ar=[[NSMutableArray alloc] init];
    
    NSArray *nodes=nil;
    nodes=[document nodesForXPath:nodePathName error:nil];
    
    NSString *strValue;
    NSString *strName;
    
    for (CXMLElement *node in nodes) {
        NSMutableDictionary *object=[[NSMutableDictionary alloc] init];
        
        // process to set attributes of object ----------------------------------------
        NSMutableDictionary *objectAttributes=[[NSMutableDictionary alloc] init];
        NSArray *arAttr=[node attributes];
        NSUInteger i, countAttr = [arAttr count];
        for (i = 0; i < countAttr; i++) {
            strValue=[[arAttr objectAtIndex:i] stringValue];
            strName=[[arAttr objectAtIndex:i] name];
            if(strValue && strName){
                [objectAttributes setValue:strValue forKey:strName];
            }
        }
        [object setValue:objectAttributes forKey:[node name]];
        // --------------------------------------------------------------------------------
        
        [ar addObject:object];
        // --------------------------------------------------------------------------------
    }
//    NSLog(@"~~%@~~~",[ar description]);
    return ar;
}
@end
