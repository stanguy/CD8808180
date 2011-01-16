#import "Line.h"

@implementation Line

// Custom logic goes here.

+(NSArray*) findAllInContext:(NSManagedObjectContext*) context {
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [Line entityInManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.    
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:YES];    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor1, nil];
    
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
