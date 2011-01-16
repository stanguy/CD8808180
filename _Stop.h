// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Stop.h instead.

#import <CoreData/CoreData.h>


@class StopTime;
@class Line;


@interface StopID : NSManagedObjectID {}
@end

@interface _Stop : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (StopID*)objectID;




@property (nonatomic, retain) NSSet* stop_times;
- (NSMutableSet*)stop_timesSet;



@property (nonatomic, retain) NSSet* lines;
- (NSMutableSet*)linesSet;




@end

@interface _Stop (CoreDataGeneratedAccessors)

- (void)addStop_times:(NSSet*)value_;
- (void)removeStop_times:(NSSet*)value_;
- (void)addStop_timesObject:(StopTime*)value_;
- (void)removeStop_timesObject:(StopTime*)value_;

- (void)addLines:(NSSet*)value_;
- (void)removeLines:(NSSet*)value_;
- (void)addLinesObject:(Line*)value_;
- (void)removeLinesObject:(Line*)value_;

@end

@interface _Stop (CoreDataGeneratedPrimitiveAccessors)



- (NSMutableSet*)primitiveStop_times;
- (void)setPrimitiveStop_times:(NSMutableSet*)value;



- (NSMutableSet*)primitiveLines;
- (void)setPrimitiveLines:(NSMutableSet*)value;


@end
