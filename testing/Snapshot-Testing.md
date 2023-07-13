## Snapshot Testing

- Unit tests for views
- Takes a snapshot of the view and when you run the tests against it, you're asserting that the new view that is rendered should match the snapshot that has been recorded before

### Setup for swift-snapshot-testing:
1. Go to project and add a target for Snapshot Tests e.g AppSnapshotTests
2. Go to Build Phases and add an package dependency in the Link Binary with Libraries Section
3. Use this link (https://github.com/pointfreeco/swift-snapshot-testing) to search for the swift-snapshot-testing package. *Make sure you add it to the newly added target*

Resources:
- [Snapshot Testing](https://github.com/pointfreeco/swift-snapshot-testing)
