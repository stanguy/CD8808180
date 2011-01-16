#import "_StopTime.h"

@interface StopTime : _StopTime {}
// Custom logic goes here.
+ (NSArray*) findAllTimesInContext:(NSManagedObjectContext*)context atLine:(Line*)line atStop:(Stop*)stop between:(NSNumber*)x and: (NSNumber*)y ;
@end
