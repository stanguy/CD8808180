//
//  CDTestCase.m
//  CDTestCase
//
//  Created by Sebastien Tanguy on 01/12/11.
//  Copyright dthg.net 2011 . All rights reserved.
//

#import <objc/objc-auto.h>

#import "Line.h"
#import "Stop.h"
#import "StopTime.h"

NSManagedObjectModel *managedObjectModel();
NSManagedObjectContext *managedObjectContext();


int kNbStops = 400;
int kNbLines = 80;
int kNbStopPerLine = 30;
int kNbStopTime = 250;

int runQuery( Line* line, Stop* stop ) {
    NSManagedObjectContext *context = managedObjectContext();

    NSArray* stop_times = [StopTime findAllTimesInContext:context atLine:line atStop:stop between:[NSNumber numberWithInt:50] and:[NSNumber numberWithInt:100]];
    return [stop_times count];
}

int main (int argc, const char * argv[]) {
	
//    objc_startCollectorThread();
	
	// Create the managed object context
    NSManagedObjectContext *context = managedObjectContext();
    [context setUndoManager:nil];
    [context setRetainsRegisteredObjects:YES];

	// Custom code here...

    if ( argc > 1 && 0 == strcmp( "-c", argv[1] ) ) {
        NSMutableArray* stops = [NSMutableArray arrayWithCapacity:kNbStops];
        NSMutableArray* lines = [NSMutableArray arrayWithCapacity:kNbLines];
        for( int i = 0; i < kNbStops; ++i ) {
            Stop* stop = [Stop insertInManagedObjectContext:context];
            [stops addObject:stop];
        }
        for( int i = 0; i < kNbLines; ++i ) {
            Line* line = [Line insertInManagedObjectContext:context];
            line.id = [NSNumber numberWithInt:0];
            [lines addObject:line];
            for( int j = 0; j < kNbStopPerLine; ++j ) {
                srand( time( NULL ) + i * j );
                Stop* stop = [stops objectAtIndex:(rand() % (kNbStops - 1))];
                [[line stopsSet] addObject:stop];
                for( int k = 0; k < kNbStopTime; ++k ) {
                    StopTime* st = [StopTime insertInManagedObjectContext:context];
//                    NSLog( @"st.context= %@, line.context= %@", [st managedObjectContext], [line managedObjectContext] );
                    [st setValue:line forKey:@"line"];
                    [st setValue:stop forKey:@"stop"];
                    st.payload1 = [NSNumber numberWithInt:k];
                    st.payload2 = [NSNumber numberWithInt:42];
                }
            }
            NSLog( @"done with line %d", i );
        }
    } else {
        NSArray* allLines = [Line findAllInContext:context];
        Line* line = [allLines objectAtIndex:([allLines count] / 2)];
        Stop* stop = [[line.stops allObjects] objectAtIndex:0];
        int sum = 0;
        for ( int i = 0; i < 500; ++i ) {
            sum += runQuery( line, stop );
        }
        NSLog( @"Total: %d", sum );
    }
    
	// Save the managed object context
    NSError *error = nil;    
    if (![context save:&error]) {
        NSLog(@"Error while saving\n%@",
              ([error localizedDescription] != nil) ? [error localizedDescription] : @"Unknown Error");
        exit(1);
    }
    return 0;
}



NSManagedObjectModel *managedObjectModel() {
    
    static NSManagedObjectModel *model = nil;
    
    if (model != nil) {
        return model;
    }
    
	NSString *path = [[[NSProcessInfo processInfo] arguments] objectAtIndex:0];
	path = [path stringByDeletingPathExtension];
	NSURL *modelURL = [NSURL fileURLWithPath:[path stringByAppendingPathExtension:@"mom"]];
    model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return model;
}



NSManagedObjectContext *managedObjectContext() {
	
    static NSManagedObjectContext *context = nil;
    if (context != nil) {
        return context;
    }
    
    context = [[NSManagedObjectContext alloc] init];
    
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: managedObjectModel()];
    [context setPersistentStoreCoordinator: coordinator];
    
    NSString *STORE_TYPE = NSSQLiteStoreType;
	
    NSString *path = [[[NSProcessInfo processInfo] arguments] objectAtIndex:0];
    path = [path stringByDeletingPathExtension];
    NSURL *url = [NSURL fileURLWithPath:[path stringByAppendingPathExtension:@"sqlite"]];
    
    NSError *error;
    NSPersistentStore *newStore = [coordinator addPersistentStoreWithType:STORE_TYPE configuration:nil URL:url options:nil error:&error];
    
    if (newStore == nil) {
        NSLog(@"Store Configuration Failure\n%@",
              ([error localizedDescription] != nil) ?
              [error localizedDescription] : @"Unknown Error");
    }
    
    return context;
}

