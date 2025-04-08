//
//  TJScaleTipper.h
//  Close-up
//
//  Created by Tim Johnsen on 8/8/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_CLOSED_ENUM(NSInteger, TJScaleTipperLifecycleStage) {
    TJScaleTipperLifecycleStageNone,
    TJScaleTipperLifecycleStageRegisterToVote,
    TJScaleTipperLifecycleStageVote,
};

/// Recommended URL to direct people to encourage voting.
extern NSString *const kTJVoterRegistrationURLString;

@interface TJScaleTipper : NSObject

+ (instancetype)shared;

@property (nonatomic, readonly) TJScaleTipperLifecycleStage lifecycleStage;

/// @c isGoodCandidateToEncourageVoting will always return @c NO after this time
@property (nonatomic, readonly) NSDate *endOfElectionDay;

/// Recommended as a date after which to remind people to vote
@property (nonatomic, readonly) NSDate *oneWeekBeforeElectionDay;

/// Recommended as a date before which to remind people to register to vote
@property (nonatomic, readonly) NSDate *oneMonthBeforeElectionDay;

/// Recommended as a date after which to remind people to register to vote
@property (nonatomic, readonly) NSDate *threeMonthsBeforeElectionDay;

/// Returns @c YES if the current user is a good candidate to encourage voting
@property (nonatomic, readonly) BOOL isGoodCandidateToEncourageVoting;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
