# Game Flow Guide

## 🎮 Complete Game Flow

### 1️⃣ Home Screen
```
┌─────────────────────────────────┐
│     🧠 UNDERCOVER                │
│   A Social Deduction Game       │
│                                 │
│  ┌───────────────────────────┐ │
│  │  How to Play              │ │
│  │  👥 Civilians             │ │
│  │  👁️  Spies                │ │
│  │  ❓ Mr. White             │ │
│  └───────────────────────────┘ │
│                                 │
│      [START GAME]               │
│      View Complete Rules        │
└─────────────────────────────────┘
```

### 2️⃣ Setup Screen
```
┌─────────────────────────────────┐
│        Game Setup               │
│                                 │
│  Number of Players: [6]         │
│  ━━━━━━━●━━━━━━                │
│  4    6    8    10   12        │
│                                 │
│  Number of Spies: [1]           │
│  ━●━━━━━━━━                    │
│  1  2  3                       │
│                                 │
│  Include Mr. White: [✓]         │
│                                 │
│  ┌─────────────────────────┐   │
│  │ Role Distribution       │   │
│  │ • Civilians: 4          │   │
│  │ • Spies: 1              │   │
│  │ • Mr. White: 1          │   │
│  └─────────────────────────┘   │
│                                 │
│      [START GAME]               │
└─────────────────────────────────┘
```

### 3️⃣ Player Names Screen
```
┌─────────────────────────────────┐
│     ← Add Players               │
│   Select 6 players              │
│   ━━━━━━━━━━━━━━━━━━━         │
│   4 / 6 selected                │
│                                 │
│  [Saved Players] [Enter Manually]│
│                                 │
│  🔍 Search players...           │
│                                 │
│  ➕ Add new player... [+]       │
│                                 │
│  ┌─────────────────────────┐   │
│  │ ✅ Alice                │🗑  │
│  └─────────────────────────┘   │
│  ┌─────────────────────────┐   │
│  │ ✅ Bob                  │🗑  │
│  └─────────────────────────┘   │
│  ┌─────────────────────────┐   │
│  │ ✅ Charlie              │🗑  │
│  └─────────────────────────┘   │
│  ┌─────────────────────────┐   │
│  │ ✅ Diana                │🗑  │
│  └─────────────────────────┘   │
│  ┌─────────────────────────┐   │
│  │ ⭕ Eve                  │🗑  │
│  └─────────────────────────┘   │
│                                 │
│  [Continue to Role Selection]   │
└─────────────────────────────────┘

Manual Entry Mode:
┌─────────────────────────────────┐
│     ← Add Players               │
│   Enter 6 player names          │
│                                 │
│  [Saved Players] [Enter Manually]│
│                                 │
│  👤 Player 1: ___________       │
│  👤 Player 2: ___________       │
│  👤 Player 3: ___________       │
│  👤 Player 4: ___________       │
│  👤 Player 5: ___________       │
│  👤 Player 6: ___________       │
│                                 │
│  [Continue to Role Selection]   │
└─────────────────────────────────┘
```

### 4️⃣ Role Selection Screen (Card Picking)
```
┌─────────────────────────────────┐
│     ← Pick Your Cards           │
│   Each player picks one card    │
│   ━━━━━━━━━━━━━━━━━━━         │
│   4 / 6 picked                  │
│                                 │
│  ┌─────────┐  ┌─────────┐      │
│  │    👆   │  │    ✓    │      │
│  │  ALICE  │  │SELECTED!│      │
│  └─────────┘  └─────────┘      │
│                                 │
│  ┌─────────┐  ┌─────────┐      │
│  │    👆   │  │    👆   │      │
│  │  BOB    │  │ CHARLIE │      │
│  └─────────┘  └─────────┘      │
│                                 │
│  ┌─────────┐  ┌─────────┐      │
│  │    ✓    │  │    👆   │      │
│  │SELECTED!│  │  DIANA  │      │
│  └─────────┘  └─────────┘      │
│                                 │
│      [Start Game] (grayed)      │
└─────────────────────────────────┘

After Card Pick:
┌─────────────────────────────────┐
│         Your Word               │
│                                 │
│      🟣 COFFEE                  │
│                                 │
│  Remember your word! Don't      │
│  share it with anyone else!     │
│                                 │
│      [Got it!]                  │
└─────────────────────────────────┘
```

### 5️⃣ Game Screen
```
┌─────────────────────────────────┐
│        Round 1              ℹ️  │
│                                 │
│  👥 Alive  👥 Civilians         │
│   6/6        4                  │
│  👁️ Spies   ❓ Mr. White       │
│    1          1                 │
│                                 │
│  ┌─────────────────────────┐   │
│  │ 🔵 Alice                │   │
│  │                    🗳️   │   │
│  └─────────────────────────┘   │
│  ┌─────────────────────────┐   │
│  │ 🔵 Bob                  │   │
│  │                    🗳️   │   │
│  └─────────────────────────┘   │
│  ┌─────────────────────────┐   │
│  │ 🔴 Charlie              │   │
│  │                    🗳️   │   │
│  └─────────────────────────┘   │
│                                 │
│  [💡 Mr. White Guess]           │
│  [🏠 End Game]                  │
└─────────────────────────────────┘
```

### 6️⃣ Game Over Screen
```
┌─────────────────────────────────┐
│          🏆                      │
│       GAME OVER                 │
│                                 │
│  ┌─────────────────────────┐   │
│  │  Civilians win!         │   │
│  │  All spies eliminated!  │   │
│  │                         │   │
│  │  Final Roles:           │   │
│  │  Player 1: Civilian     │   │
│  │           (Coffee)      │   │
│  │  Player 2: Civilian     │   │
│  │           (Coffee)      │   │
│  │  Player 3: Spy ✗        │   │
│  │           (Tea)         │   │
│  │  Player 4: Mr. White ✗  │   │
│  │           (No word)     │   │
│  └─────────────────────────┘   │
│                                 │
│      [Back to Home]             │
└─────────────────────────────────┘
```

## 🎯 Gameplay Steps

### Phase 0: Setup (1-2 minutes)
1. Host opens the app on their device
2. Configure game settings (player count, spies, Mr. White)
3. Enter or select player names from saved list
4. Each player picks their card to reveal their word privately
5. Everyone memorizes their word (or Mr. White status)

### Phase 1: Discussion (5-10 minutes)
1. Players take turns describing their word
   - "Mine is something you drink in the morning"
   - "Mine is hot and energizing"
   - "Mine is a popular beverage"
2. Players ask questions
   - "Is yours usually served hot?"
   - "Can you add milk to yours?"
3. Players observe reactions and descriptions

### Phase 2: Voting (2-3 minutes)
1. Discuss who seems suspicious
2. Vote by tapping the vote icon (🗳️)
3. Confirm elimination
4. Eliminated player's role is NOT revealed
5. Continue discussion

### Phase 3: Resolution
**If Mr. White Suspects They're Caught:**
- Tap "Mr. White Guess" button
- Enter guess for civilian word
- Correct = Mr. White wins
- Incorrect = Others win

**If All Eliminated:**
- Game automatically ends
- Shows winner and all roles

## 🎨 Color Legend

- 🔵 Blue Circle = Civilian (or unknown)
- 🔴 Red Circle = Spy (or unknown)
- 🟠 Orange Circle = Mr. White (or unknown)
- ⚫ Gray Circle = Eliminated

*Note: Colors are only shown in game over screen!*

## 💡 Pro Tips

### For Civilians:
✅ Be specific but not obvious
✅ Ask targeted questions
✅ Watch for vague answers
✅ Trust your instincts

### For Spies:
✅ Listen before speaking
✅ Mirror civilian descriptions
✅ Stay vague but confident
✅ Don't overact

### For Mr. White:
✅ Stay VERY vague
✅ Ask open questions
✅ Listen carefully
✅ Guess only when confident

## 🏆 Win Conditions

### Civilians Win When:
- All Spies eliminated AND
- Mr. White eliminated (if included) OR
- Mr. White guesses wrong

### Spies Win When:
- All Civilians eliminated OR
- Only 2 players remain (with spy alive)

### Mr. White Wins When:
- Survives to guess AND
- Guesses civilian word correctly

## 📊 Recommended Setups

### Beginner (6 players):
- 4 Civilians
- 1 Spy
- 1 Mr. White

### Standard (8 players):
- 5 Civilians
- 2 Spies
- 1 Mr. White

### Advanced (10 players):
- 6 Civilians
- 3 Spies
- 1 Mr. White

### Expert (12 players):
- 8 Civilians
- 3 Spies
- 1 Mr. White

## ⏱️ Time Estimates

- Setup: 1 minute
- Word Revelation: 2 minutes
- Round 1 Discussion: 5-10 minutes
- Voting: 2 minutes
- Round 2+ Discussion: 3-5 minutes each
- Resolution: 1 minute

**Total Game Time: 15-30 minutes**

## 🎭 Example Round

**Players: 6 (4 Civilians get "Coffee", 1 Spy gets "Tea", 1 Mr. White)**

**Round 1 - Descriptions:**
- P1 (Civilian): "Mine is brown and has caffeine"
- P2 (Spy): "Mine is a morning drink" ← vague!
- P3 (Mr. White): "Mine is popular worldwide" ← very vague!
- P4 (Civilian): "Mine comes from beans"
- P5 (Civilian): "Mine can be iced or hot"
- P6 (Civilian): "Mine is often served at Starbucks"

**Observation:** P2 and P3 were vague, but P3 was MORE vague!

**Voting:** Group votes out P3 (Mr. White)

**Result:** Game continues, Spy still hidden!

Enjoy your game! 🎉
