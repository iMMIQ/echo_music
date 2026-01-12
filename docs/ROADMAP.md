# Echo Music - Development Roadmap

## Project Phases

### Phase 1: Foundation (Current)

**Status**: 🚧 In Progress

**Goal**: Set up project structure and basic UI

**Tasks**:
- [x] Create Flutter project structure
- [x] Configure dependencies (Riverpod, Hive, just_audio, etc.)
- [x] Set up theme system
- [x] Create data models (Song, Album, Artist, Playlist)
- [x] Create basic navigation structure
- [ ] Implement Hive initialization
- [ ] Create service interfaces
- [ ] Build home page with tabs

**Completion**: 60%

---

### Phase 2: Core Playback

**Status**: ⏳ Not Started

**Goal**: Implement basic audio playback functionality

**Tasks**:
- [ ] Implement AudioService with just_audio
- [ ] Create playback controls (play, pause, skip, seek)
- [ ] Build mini player widget
- [ ] Build full-screen player page
- [ ] Implement queue management
- [ ] Add playback state providers
- [ ] Implement audio focus handling
- [ ] Add media session integration (background playback)

**Estimated Complexity**: High

---

### Phase 3: Library Management

**Status**: ⏳ Not Started

**Goal**: Enable local music scanning and library management

**Tasks**:
- [ ] Implement file picker integration
- [ ] Create metadata extractor (id3_ffi)
- [ ] Build directory scanner
- [ ] Implement library storage with Hive
- [ ] Create songs list view
- [ ] Create albums grid view
- [ ] Create artists list view
- [ ] Add search functionality
- [ ] Implement favorites system
- [ ] Add recently played tracking

**Estimated Complexity**: High

---

### Phase 4: Enhanced Features

**Status**: ⏳ Not Started

**Goal**: Add advanced features for better user experience

**Tasks**:
- [ ] Implement equalizer with presets
- [ ] Add shuffle and repeat modes
- [ ] Create playlist management (CRUD)
- [ ] Add smart playlists
- [ ] Implement playback history
- [ ] Add song info / metadata editor
- [ ] Create settings pages
- [ ] Add sleep timer

**Estimated Complexity**: Medium

---

### Phase 5: Navidrome Integration

**Status**: ⏳ Not Started

**Goal**: Integrate Navidrome server support

**Tasks**:
- [ ] Implement Navidrome API client
- [ ] Add server configuration screen
- [ ] Implement authentication flow
- [ ] Fetch library from server
- [ ] Stream music from server
- [ ] Sync favorites and playlists
- [ ] Add offline mode
- [ ] Implement scrobbling

**Estimated Complexity**: High

---

### Phase 6: Polish & Performance

**Status**: ⏳ Not Started

**Goal**: Optimize performance and polish UI/UX

**Tasks**:
- [ ] Add loading states and skeletons
- [ ] Implement error handling and user feedback
- [ ] Add animations and transitions
- [ ] Optimize image caching
- [ ] Implement lazy loading for large lists
- [ ] Add keyboard shortcuts (desktop)
- [ ] Optimize database queries
- [ ] Reduce memory footprint
- [ ] Improve battery efficiency

**Estimated Complexity**: Medium

---

## Technical Tasks by Category

### Data Layer

- [ ] Create Hive adapters for all models
- [ ] Implement repository pattern
- [ ] Create database migrations
- [ ] Add data validation
- [ ] Implement backup/restore functionality

### Services

- [ ] AudioService implementation
- [ ] LibraryService implementation
- [ ] PlaylistService implementation
- [ ] NavidromeService implementation
- [ ] MetadataExtractor implementation
- [ ] AlbumArtExtractor implementation

### Presentation Layer

- [ ] Create reusable widget library
- [ ] Build all page routes
- [ ] Implement navigation system
- [ ] Create loading states
- [ ] Add error dialogs
- [ ] Build settings pages

### Providers (Riverpod)

- [ ] PlaybackController
- [ ] QueueController
- [ ] LibraryController
- [ ] PlaylistController
- [ ] SearchController
- [ ] SettingsController

### Platform Integration

**Android**:
- [ ] Foreground service for playback
- [ ] Media session integration
- [ ] Audio focus handling
- [ ] Notification controls
- [ ] Request storage permissions

**Windows**:
- [ ] Media transport controls
- [ ] System tray integration
- [ ] File association (.mp3, etc.)
- [ ] MPRIS support (if applicable)

**Linux**:
- [ ] MPRIS DBus interface
- [ ] System tray integration
- [ ] File association

---

## Priority Matrix

### High Priority (Must Have for MVP)
1. ✅ Project structure and dependencies
2. ⏳ Basic audio playback
3. ⏳ Local music scanning
4. ⏳ Queue management
5. ⏳ Basic UI (home, library, player)

### Medium Priority (Important for Good UX)
1. ⏳ Metadata extraction
2. ⏳ Album art display
3. ⏳ Search functionality
4. ⏳ Playlists
5. ⏳ Favorites and history

### Low Priority (Nice to Have)
1. ⏳ Equalizer
2. ⏳ Navidrome integration
3. ⏳ Advanced features
4. ⏳ Custom themes
5. ⏳ Social features

---

## Dependencies Status

| Dependency | Status | Notes |
|------------|--------|-------|
| flutter_riverpod | ✅ Configured | Need to create providers |
| hive | ✅ Configured | Need to initialize and register adapters |
| just_audio | ✅ Configured | Need to implement service |
| audio_service | ✅ Configured | Need to configure platform code |
| id3_ffi | ✅ Configured | Need to implement metadata extraction |
| file_picker | ✅ Configured | Ready to use |
| permission_handler | ✅ Configured | Need to request permissions |
| flutter_animate | ✅ Configured | Ready to use |
| phosphor_flutter | ✅ Configured | Ready to use |

---

## Known Issues & blockers

None currently.

---

## Next Steps (Immediate)

1. Complete Hive initialization in main.dart
2. Create basic AudioService implementation
3. Build mini player widget
4. Implement file picker for music import
5. Create metadata extractor wrapper

---

## Notes

- This roadmap is subject to change based on user feedback
- Priority can be adjusted as development progresses
- Some features may be moved to later phases depending on complexity
- The goal is to have a working MVP (Phase 1-3) as soon as possible

---

## Version History

- **v0.1.0** (Current) - Project foundation, basic structure
- **v0.2.0** (Planned) - Basic playback and library
- **v0.3.0** (Planned) - Enhanced features
- **v1.0.0** (Target) - Full MVP with Navidrome support
