// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to StopTime.m instead.

#import "_StopTime.h"

@implementation StopTimeID
@end

@implementation _StopTime

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"StopTime" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"StopTime";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"StopTime" inManagedObjectContext:moc_];
}

- (StopTimeID*)objectID {
	return (StopTimeID*)[super objectID];
}




@dynamic payload1;



- (int)payload1Value {
	NSNumber *result = [self payload1];
	return [result intValue];
}

- (void)setPayload1Value:(int)value_ {
	[self setPayload1:[NSNumber numberWithInt:value_]];
}

- (int)primitivePayload1Value {
	NSNumber *result = [self primitivePayload1];
	return [result intValue];
}

- (void)setPrimitivePayload1Value:(int)value_ {
	[self setPrimitivePayload1:[NSNumber numberWithInt:value_]];
}





@dynamic payload2;



- (int)payload2Value {
	NSNumber *result = [self payload2];
	return [result intValue];
}

- (void)setPayload2Value:(int)value_ {
	[self setPayload2:[NSNumber numberWithInt:value_]];
}

- (int)primitivePayload2Value {
	NSNumber *result = [self primitivePayload2];
	return [result intValue];
}

- (void)setPrimitivePayload2Value:(int)value_ {
	[self setPrimitivePayload2:[NSNumber numberWithInt:value_]];
}





@dynamic line;

	

@dynamic stop;

	





@end
