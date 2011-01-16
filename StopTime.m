#import "StopTime.h"

@implementation StopTime

// Custom logic goes here.

+ (NSArray*) findAllTimesInContext:(NSManagedObjectContext*)context atLine:(Line*)line atStop:(Stop*)stop between:(NSNumber*)x and: (NSNumber*)y {
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [StopTime entityInManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"line = %@ AND stop = %@ AND payload1 > %@ AND payload1 < %@", 
                              line, stop, x, y ];
    [fetchRequest setPredicate:predicate];
    
    // Edit the sort key as appropriate.    
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"payload1" ascending:YES];    
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor1, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    [fetchRequest release];
    [sortDescriptor1 release];
    [sortDescriptors release];
    
    NSError *error = nil;
    NSArray* result = [context executeFetchRequest:fetchRequest error:&error];
    if ( nil == result ) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        return nil;
    }
    return result;
}
@end
