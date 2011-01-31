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
#import "Direction.h"
#import "Poi.h"
#import "ClosePoi.h"

NSManagedObjectModel *managedObjectModel();
NSManagedObjectContext *managedObjectContext();


int kNbStops = 100;
int kNbLines = 10;
int kNbStopPerLine = 50;
int kNbStopTime = 250;
int kNbBikes = 50;
int kNbPos = 50;
int kNbMetro = 15;
int kNbPoiPerStop = 5;

int runQuery( Line* line, Stop* stop ) {
    NSManagedObjectContext *context = managedObjectContext();

    NSArray* stop_times = [StopTime findAllTimesInContext:context atLine:line atStop:stop between:[NSNumber numberWithInt:50] and:[NSNumber numberWithInt:100]];
    return [stop_times count];
}


void flushContext() {
	NSManagedObjectContext* context = managedObjectContext();
    // Save the managed object context
    NSError *error = nil;    
    if (![context save:&error]) {
        NSLog(@"Error while saving\n%@",
              ([error localizedDescription] != nil) ? [error localizedDescription] : @"Unknown Error");
        if ( [error code] == NSValidationMultipleErrorsError ) {
            NSArray *detailedErrors = [[error userInfo] objectForKey:NSDetailedErrorsKey];
            NSUInteger i, displayErrors = [detailedErrors count];
            for( i = 0; i < displayErrors; ++i ) {
                NSLog(@"%@\n", [[detailedErrors objectAtIndex:i] localizedDescription]);
            }
        }
        exit(1);
    }
    //[context reset];
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
		NSMutableArray* pois = [NSMutableArray arrayWithCapacity:(kNbBikes+kNbPos+kNbMetro)];
		for( int i = 0; i < kNbBikes; ++i ) {
			Poi* poi = [Poi insertInManagedObjectContext:context];
			poi.name = [NSString stringWithFormat:@"Bike #%d", i];
			poi.type = @"bike";
			[pois addObject:poi];
		}
		for( int i = 0; i < kNbPos; ++i ) {
			Poi* poi = [Poi insertInManagedObjectContext:context];
			poi.name = [NSString stringWithFormat:@"Pos #%d", i];
			poi.type = @"pos";
			[pois addObject:poi];
		}
		for( int i = 0; i < kNbBikes; ++i ) {
			Poi* poi = [Poi insertInManagedObjectContext:context];
			poi.name = [NSString stringWithFormat:@"Metro #%d", i];
			poi.type = @"metro";
			[pois addObject:poi];
		}
        for( int i = 0; i < kNbStops; ++i ) {
            Stop* stop = [Stop insertInManagedObjectContext:context];
			stop.name = [NSString stringWithFormat:@"Stop #%d", i];
			stop.src_id = [NSString stringWithFormat:@"%d", i];
			stop.accessibleValue = NO;
			for( int j = 0; j < kNbPoiPerStop; ++j ) {
				srand( time( NULL ) + i * j );
                Poi* poi = [pois objectAtIndex:(rand() % ([pois count] - 1))];
				ClosePoi* cpoi = [ClosePoi insertInManagedObjectContext:context];
				cpoi.poi = poi;
				cpoi.distance = [NSNumber numberWithInt:12];
				[stop incCounter:poi.type];
				[[stop close_poisSet] addObject:cpoi];
			}
            [stops addObject:stop];
        }
        for( int i = 0; i < kNbLines; ++i ) {
            Line* line = [Line insertInManagedObjectContext:context];
            //line.id = [NSNumber numberWithInt:0];
			line.short_name = [NSString stringWithFormat:@"%d", i];
			line.long_name = [NSString stringWithFormat:@"Ligne %d", i];
			line.usage = @"urban";
			line.src_id =  [NSString stringWithFormat:@"%02d", i];
			line.accessibleValue = NO;
            [lines addObject:line];
			
			Direction* dir = [Direction insertInManagedObjectContext:context];
			dir.headsign = @"To Hell!";
			[[line headsignsSet] addObject:dir];
			
            for( int j = 0; j < kNbStopPerLine; ++j ) {
                srand( time( NULL ) + i * j );
                Stop* stop = [stops objectAtIndex:(rand() % (kNbStops - 1))];
                [[line stopsSet] addObject:stop];
                for( int k = 0; k < kNbStopTime; ++k ) {
                    StopTime* st = [StopTime insertInManagedObjectContext:context];
//                    NSLog( @"st.context= %@, line.context= %@", [st managedObjectContext], [line managedObjectContext] );
                    [st setValue:line forKey:@"line"];
                    [st setValue:stop forKey:@"stop"];
                    st.arrival = [NSNumber numberWithInt:k];
                    st.calendar = [NSNumber numberWithInt:0xff];
					st.direction = dir;
					st.trip_bearing = @"NW";
                }
            }
			flushContext();
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
	path = [path stringByDeletingLastPathComponent];
	NSURL *modelURL =[NSURL fileURLWithPath:[path stringByAppendingPathComponent:@"Transit.mom"]];
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
    path = [path stringByDeletingLastPathComponent];
    NSURL *url = [NSURL fileURLWithPath:[path stringByAppendingPathComponent:@"Transit.sqlite"]];
    
    NSError *error;
    NSPersistentStore *newStore = [coordinator addPersistentStoreWithType:STORE_TYPE configuration:nil URL:url options:nil error:&error];
    
    if (newStore == nil) {
        NSLog(@"Store Configuration Failure\n%@",
              ([error localizedDescription] != nil) ?
              [error localizedDescription] : @"Unknown Error");
    }
    
    return context;
}

