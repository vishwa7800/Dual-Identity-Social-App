# AGENTS.md — Project Brief for Shrowd

Read this in full before making any code changes. This file defines what
the app is, what it must do, and the hard constraints that override any
convenience shortcut an agent might otherwise take.

## What this app is

Shrowd is a mobile-first social app (Flutter — iOS, Android, Web from one
codebase) built around one core idea: every account has two separate,
linked identities under a single login.

- **Public identity** — a normal social profile. User picks the
  username, avatar, banner, bio. Fully searchable by others. Has full
  Direct Message access. Full social features: post, comment, like,
  follow.
- **Wanderer identity** — auto-generated at signup (e.g.
  `Wanderer#102`), anonymous. User can edit its bio and banner, but
  **cannot change its avatar** — it is permanently locked to a default
  masked icon. Completely unsearchable by anyone, anywhere in the app.
  **Has no Direct Message access at all.** Can post, comment, and like.

A single global toggle (present in the top nav on every screen) switches
which identity is "active." Whatever the user does next — post, like,
comment, follow — is attributed to whichever identity is active at that
moment. Switching must be instant: no screen reload, no lost in-progress
input (e.g. a comment being typed stays in the text field and is simply
sent under the new identity after a switch).

## The one rule that overrides everything else

**Public and Wanderer must never be linkable to each other anywhere in
the UI, the API responses, or the data layer**, except internally via the
shared `account_id` used strictly for login/billing/moderation — never
exposed to any client-facing endpoint. If a feature request or a
convenient shortcut would require showing, querying, or inferring both
identities together in a user-facing context, stop and flag it instead of
implementing it. This is not a UI preference — treat it as a security
requirement with the same seriousness as password handling.

Concretely, this means:
- Public and Wanderer have **completely separate follow/follower
  graphs** — never merged, never cross-referenced in any screen.
- Search only ever queries Public profiles. Wanderer is structurally
  absent from search — not filtered out at query time, but never
  indexed in the first place.
- DMs are Public-only, enforced server-side, not just hidden in the UI.
- Post/comment/like authorship uses a polymorphic author reference
  (author_type + author_id resolving to either a public or wanderer
  profile row) rather than always joining through the shared account.

## Who this is for

Primarily 16–28 year olds already used to running multiple personas
across different apps (a curated main account + an anonymous "Finsta" or
similar) — Shrowd's pitch is collapsing that behavior into one app with
real structural separation, instead of two apps or two manually-managed
accounts.

## Final outcome / what "done" looks like

A working mobile app where a user can:
1. Sign up and immediately have both identities active.
2. Switch identities instantly from anywhere in the app.
3. Post, comment, and like from either identity, with Ghost Likes (like
   counts are public, the list of who liked is never shown to anyone,
   including the post's own author).
4. Browse a Wire feed (text/photo/carousel posts) and swipe into a
   Reels-style vertical video feed.
5. Search for and follow/unfollow Public profiles (from either identity)
   — Wanderer can follow Public profiles anonymously, the reverse is
   never possible.
6. Message other Public profiles via DM, with all messages auto-deleted
   after 24 hours (hard delete, not a hidden/flag-based delete).
7. Join or host live voice/music "Galaxy Hub" rooms — Public Hubs (max 5
   people, auto-close after 2 hours) and Private Hubs (unlimited
   size/duration, invite-only via a Public DM link).
8. Post and complete "Quests" (community challenges with photo-proof
   submissions, verified by the quest creator) to earn "Essence," an
   in-app currency, and spend it in a cosmetic "Matrix Shop" or to open
   new Hubs (0.5 Essence per Hub).
9. Manage account safety: block/report, view/edit both profiles
   separately, log out.


## Tech stack (do not substitute without discussion)

- **Client:** Flutter (Dart), Riverpod for state management.
- **Backend:** Node.js (NestJS).
- **Primary database:** PostgreSQL.
- **Cache / ephemeral store:** Valkey (not Redis — Redis's license
  changed in 2024; Valkey is the BSD-licensed, drop-in-compatible fork).
- **Realtime:** Socket.IO for general app realtime (DMs, notifications);
  LiveKit (self-hosted) for Hub voice — it has an official Flutter SDK.
- **Media storage:** local filesystem for now (project is in local/trial
  phase, not publicly hosted — see below).
- **Music integration:** deliberately deferred. Spotify/Apple Music SDKs
  prohibit broadcasting one user's stream to other listeners through a
  third-party app's servers — that's exactly what the Hub music feature
  would do. Use local test audio for now; do not wire up a real
  streaming SDK without revisiting this.

## Current phase: local build & trial only

This app is **not publicly hosted** right now — it's being built and
tested locally. Prefer free, self-hostable, zero-billing tools and
approaches at every step (this shaped the tech stack choices above).
Don't introduce a paid service, cloud dependency, or anything requiring
billing details without flagging it first — note it as a "needed before
public launch" item instead and keep building with a local/free
substitute.

## Visual design system

Dark-first UI. Near-black background (#0F0E13). Two-mode accent color
system tied to active identity — this is a deliberate design signal, not
just a toggle color:
- **Public mode:** electric indigo accent (#5B6CFF), brighter/more open
  feeling.
- **Wanderer mode:** deep violet/magenta accent (#8B2AC2 family), dimmer,
  slightly more shadowed background.
Rounded 16-20px cards, soft glow instead of hard borders, Inter (or
similar geometric sans-serif) typography. Bottom navigation is a
floating, pill-shaped glassmorphic bar (frosted translucent background),
not a flat tab bar.

## Naming

The app is called **Shrowd** — that spelling is intentional, not a typo.
Never "auto-correct" it to "Shroud" anywhere in code, copy, or file names.
