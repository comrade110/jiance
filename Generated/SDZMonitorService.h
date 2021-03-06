/*
	SDZMonitorService.h
	The interface definition of classes and methods for the MonitorService web service.
	Generated by SudzC.com
*/
				
#import "Soap.h"
	
/* Add class references */
				

/* Interface for the service */
				
@interface SDZMonitorService : SoapService
		
	/* Returns NSString*.  */
	- (SoapRequest*) getRooms: (id <SoapDelegate>) handler hotelid: (int) hotelid;
	- (SoapRequest*) getRooms: (id) target action: (SEL) action hotelid: (int) hotelid;

    /* Returns NSString*.  */
    - (SoapRequest*) getLoginCode: (id <SoapDelegate>) handler phone: (NSString*) phone;
    - (SoapRequest*) getLoginCode: (id) target action: (SEL) action phone: (NSString*) phone;

	/* Returns NSString*.  */
	- (SoapRequest*) getMachineMonitor: (id <SoapDelegate>) handler machineid: (long) machineid time: (int) time;
	- (SoapRequest*) getMachineMonitor: (id) target action: (SEL) action machineid: (long) machineid time: (int) time;

	/* Returns NSString*.  */
	- (SoapRequest*) listArea: (id <SoapDelegate>) handler;
	- (SoapRequest*) listArea: (id) target action: (SEL) action;

	/* Returns NSString*.  */
	- (SoapRequest*) getAlertLog: (id <SoapDelegate>) handler hotelid: (int) hotelid start: (int) start limit: (int) limit;
	- (SoapRequest*) getAlertLog: (id) target action: (SEL) action hotelid: (int) hotelid start: (int) start limit: (int) limit;

	/* Returns NSString*.  */
	- (SoapRequest*) getHotelInfo: (id <SoapDelegate>) handler hotelid: (int) hotelid;
	- (SoapRequest*) getHotelInfo: (id) target action: (SEL) action hotelid: (int) hotelid;

	/* Returns NSString*.  */
    - (SoapRequest*) login: (id <SoapDelegate>) handler phone: (NSString*) phone psw: (NSString*) psw type: (int) type;
    - (SoapRequest*) login: (id) target action: (SEL) action phone: (NSString*) phone psw: (NSString*) psw type: (int) type;

	/* Returns NSString*.  */
	- (SoapRequest*) aa: (id <SoapDelegate>) handler a: (NSString*) a;
	- (SoapRequest*) aa: (id) target action: (SEL) action a: (NSString*) a;

	/* Returns NSString*.  */
	- (SoapRequest*) getHistoryRooms: (id <SoapDelegate>) handler hotelid: (int) hotelid mac: (NSString*) mac sbegin: (NSString*) sbegin send: (NSString*) send start: (int) start limit: (int) limit;
	- (SoapRequest*) getHistoryRooms: (id) target action: (SEL) action hotelid: (int) hotelid mac: (NSString*) mac sbegin: (NSString*) sbegin send: (NSString*) send start: (int) start limit: (int) limit;

		
	+ (SDZMonitorService*) service;
	+ (SDZMonitorService*) serviceWithUsername: (NSString*) username andPassword: (NSString*) password;
@end
	