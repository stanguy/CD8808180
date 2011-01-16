// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Line.h instead.

#import <CoreData/CoreData.h>


@class Stop;
@class StopTime;



@interface LineID : NSManagedObjectID {}
@end

@interface _Line : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (LineID*)objectID;



@property (nonatomic, retain) NSNumber *id;

@property int idValue;
- (int)idValue;
- (void)setIdValue:(int)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* stops;
- (NSMutableSet*)stopsSet;



@property (nonatomic, retain) NSSet* stop_times;
- (NSMutableSet*)stop_timesSet;




@end

@interface _Line (CoreDataGeneratedAccessors)

- (void)addStops:(NSSet*)value_;
- (void)removeStops:(NSSet*)value_;
- (void)addStopsObject:(Stop*)value_;
- (void)removeStopsObject:(Stop*)value_;

- (void)addStop_times:(NSSet*)value_;
- (void)removeStop_times:(NSSet*)value_;
- (void)addStop_timesObject:(StopTime*)value_;
- (void)removeStop_timesObject:(StopTime*)value_;

@end

@interface _Line (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int)primitiveIdValue;
- (void)setPrimitiveIdValue:(int)value_;




- (NSMutableSet*)primitiveStops;
- (void)setPrimitiveStops:(NSMutableSet*)value;



- (NSMutableSet*)primitiveStop_times;
- (void)setPrimitiveStop_times:(NSMutableSet*)value;


@end
