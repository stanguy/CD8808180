// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to StopTime.h instead.

#import <CoreData/CoreData.h>


@class Line;
@class Stop;




@interface StopTimeID : NSManagedObjectID {}
@end

@interface _StopTime : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (StopTimeID*)objectID;



@property (nonatomic, retain) NSNumber *payload1;

@property int payload1Value;
- (int)payload1Value;
- (void)setPayload1Value:(int)value_;

//- (BOOL)validatePayload1:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *payload2;

@property int payload2Value;
- (int)payload2Value;
- (void)setPayload2Value:(int)value_;

//- (BOOL)validatePayload2:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) Line* line;
//- (BOOL)validateLine:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) Stop* stop;
//- (BOOL)validateStop:(id*)value_ error:(NSError**)error_;




@end

@interface _StopTime (CoreDataGeneratedAccessors)

@end

@interface _StopTime (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitivePayload1;
- (void)setPrimitivePayload1:(NSNumber*)value;

- (int)primitivePayload1Value;
- (void)setPrimitivePayload1Value:(int)value_;


- (NSNumber*)primitivePayload2;
- (void)setPrimitivePayload2:(NSNumber*)value;

- (int)primitivePayload2Value;
- (void)setPrimitivePayload2Value:(int)value_;




- (Line*)primitiveLine;
- (void)setPrimitiveLine:(Line*)value;



- (Stop*)primitiveStop;
- (void)setPrimitiveStop:(Stop*)value;


@end
