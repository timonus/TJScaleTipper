# TJScaleTipper

This is a small bit of code you can use to determine whether folks are good candidates to encourage to vote. It includes the following.

- `isGoodCandidateToEncourageVoting`, a method you can check to determine if the person using your app is a good candidate to encourage to vote. Checks if (1) locale is US, (2) it’s not past Election Day, (3) user doesn’t have any conservative-biased apps installed*.
- `kTJOneMonthBeforeElectionDayUnixTimestamp`, a date before which I’m recommending people to register to vote.
- `kTJOneWeekBeforeElectionDayUnixTimestamp`, a date after which I’m reminding people to vote.
- `kTJEndOfElectionDayUnixTimestamp`, Election Day itself.
- `kTJVoterRegistrationURLString`, the recommended URL people can use to check their voter registration status.


*Be sure to include the following entries in your app’s `LSApplicationQueriesSchemes`:
- `com.rumble.battles`
- `dailywire`
- `com.cappital.prageru`
- `mindsapp`
- `mewe`
- `adbe.LI0uai0cRquGimk1SKNvDg`
- `rsbn`
- `myapp`
- `second1st`
- `conservativenews`
- `talkradio`
- `foxnews`
