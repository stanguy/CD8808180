#import "Stop.h"

@implementation Stop

// Custom logic goes here.

-(void)incCounter:(NSString*)type {
	NSString* counterName = [NSString stringWithFormat:@"%@_count", type];
	int count = [[self valueForKey:counterName] intValue] + 1;
	[self setValue:[NSNumber numberWithInt:count] forKey:counterName];
}


@end
