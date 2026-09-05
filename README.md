# Shrowd — Dual-Identity Social App

> **One account. Two distinct, unlinked worlds.**  
> A mobile-first social platform collapsing curated public presence and authentic anonymity into a single seamless experience.

---

## 🌌 What is Shrowd?

**Shrowd** is a mobile-first social application (built with Flutter for iOS, Android, and Web) designed around one foundational concept: **every account has two separate, linked identities under a single login**, with a strict privacy firewall between them.

### 1. 🌐 Public Identity
- **Your Curated Social Profile**: Choose your own username, profile avatar, banner, and bio.
- **Full Social Graph**: Publicly searchable, can follow and be followed openly.
- **Direct Messaging**: Full access to 24-hour ephemeral Direct Messages with other Public profiles.
- **Social Actions**: Post, comment, and like with public attribution.

### 2. 🎭 Wanderer Identity
- **Anonymous Persona**: Auto-generated handle upon signup (e.g. `Wanderer#102`).
- **Locked Masked Avatar**: Custom bio and banner are editable, but avatar is permanently locked to a default masked icon.
- **Zero Search Presence**: Structurally absent from search indexes — cannot be looked up by anyone.
- **No Direct Messages**: Strictly disabled at both UI and server levels for privacy safety.
- **Separate Social Graph**: Independent follower list; can follow Public profiles anonymously.

### ⚡ Instant Global Identity Switch
A top-navigation toggle is accessible across every screen in the app. Tapping it switches your active identity instantly:
- **Zero screen reload.**
- **Zero lost input** (e.g., text being typed in a comment field remains intact and is simply posted under the newly toggled identity).

---

## 🔒 The Core Privacy Rule

> **Public and Wanderer identities must NEVER be linkable anywhere in the UI, API responses, or data layer.**

- **Independent Graphs**: Follower/following networks are completely segregated.
- **Polymorphic Authoring**: Posts, comments, and interactions reference polymorphic author profiles rather than a shared user account.
- **Structural Anonymity**: Wanderer profiles are not indexed in search databases, preventing accidental data leaks.

---

## ✨ Features & What's Being Built

### 📰 1. The Wire & Media Feed
- Text, high-res photos, and carousel posts.
- Seamless swipe into a vertical Reels-style video feed.
- Mode-aware feeds tailored to active identity context.

### 👻 2. Ghost Likes
- Like counts are public, but the list of who liked a post is **completely hidden from everyone**, including the post's author.
- Eliminates social anxiety and clout-chasing around likes.

### ⏳ 3. 24-Hour Ephemeral DMs
- Direct messaging between Public profiles.
- All messages are **hard-deleted after 24 hours** from server storage, not just hidden by flags.
- Completely blocked for Wanderer mode.

### 🎙️ 4. Galaxy Hubs (Live Audio & Music Rooms)
- **Public Hubs**: Casual drop-in audio lounges for up to 5 participants, auto-closing after 2 hours.
- **Private Hubs**: Unlimited capacity, invite-only rooms accessible via one-time Public DM links.
- Real-time voice channels powered by LiveKit.

### 🏆 5. Quests & "Essence" Economy
- Community challenges created by users with photo-proof submissions.
- Quest creators verify submissions and reward participants with **"Essence"** (in-app currency).
- Spend Essence in the cosmetic **Matrix Shop** or use it to unlock new Galaxy Hub sessions (0.5 Essence per Hub).

### 🛡️ 6. Safety & Account Controls
- Independent profile management for both Public and Wanderer identities.
- Granular block and report mechanisms to maintain community health.

---

## 🎨 Visual Design System

- **Dark-First Palette**: Near-black background (`#0F0E13`) with subtle glows and glassmorphism.
- **Dual-Mode Dynamic Accents**:
  - 🔵 **Public Mode**: Electric Indigo (`#5B6CFF`) — vibrant, open, and clear.
  - 🟣 **Wanderer Mode**: Deep Violet / Magenta (`#8B2AC2`) — moody, shadowed, and covert.
- **Floating Glassmorphic Navigation**: Frosted translucent floating pill nav bar with real-time blur backdrop.

---

## 🛠️ Technology Stack

| Layer | Technology |
|---|---|
| **Client** | Flutter (Dart), State Management with Riverpod |
| **Backend** | Node.js (NestJS) |
| **Database** | PostgreSQL |
| **Cache / Ephemeral** | Valkey (BSD-licensed Redis fork) |
| **Realtime** | Socket.IO (DMs, notifications) & LiveKit (Hub Voice) |
| **Media** | Local file storage (Trial/Dev Phase) |

---

## 🎯 The Final Outcome

A high-performance, mobile-first social ecosystem where users seamlessly navigate between their public, curated presence and their private, anonymous self without juggling multiple apps or accounts — protected by mathematical and architectural separation at every layer.
