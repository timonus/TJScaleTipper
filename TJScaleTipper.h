//
//  TJScaleTipper.h
//  Close-up
//
//  Created by Tim Johnsen on 8/8/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// @c isGoodCandidateToEncourageVoting will always return @c NO after this time
extern const NSTimeInterval kTJEndOfElectionDayUnixTimestamp;

/// Recommended as a date after which to remind people to vote
extern const NSTimeInterval kTJOneWeekBeforeElectionDayUnixTimestamp;

/// Recommended as a date before which to remind people to register to vote
extern const NSTimeInterval kTJOneMonthBeforeElectionDayUnixTimestamp;

@interface TJScaleTipper : NSObject

/// Returns @c YES if the current user is a good candidate to encourage voting
+ (BOOL)isGoodCandidateToEncourageVoting;

@end

NS_ASSUME_NONNULL_END
