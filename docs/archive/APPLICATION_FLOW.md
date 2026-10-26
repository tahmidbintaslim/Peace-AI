# Peace AI - Application Flow

This document illustrates the flow of the Peace AI application.

## User Journey Flow

```
┌─────────────────────────────────────────────┐
│                                             │
│         User Launches Peace AI             │
│                                             │
└──────────────────┬──────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────┐
│                                             │
│          Splash Screen                      │
│                                             │
│  • Shows app logo and name                  │
│  • Displays loading animation               │
│  • 3-second delay with fade animation       │
│                                             │
└──────────────────┬──────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────┐
│                                             │
│          Chat Screen                        │
│                                             │
│  • Welcome message displayed                │
│  • "Assalamu Alaikum! ..."                 │
│  • Instructions and suggestions             │
│                                             │
└──────────────────┬──────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────┐
│                                             │
│      User Types a Question                  │
│                                             │
│  Examples:                                  │
│  • "Tell me about Allah"                    │
│  • "What is prayer?"                        │
│  • "Teach me about mercy"                   │
│                                             │
└──────────────────┬──────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────┐
│                                             │
│      User Presses Send Button               │
│                                             │
│  • Input validation                         │
│  • Message created with timestamp           │
│  • Added to chat history                    │
│                                             │
└──────────────────┬──────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────┐
│                                             │
│      AI Processing (500ms delay)            │
│                                             │
│  • Loading indicator shown                  │
│  • "Peace AI is thinking..."                │
│                                             │
└──────────────────┬──────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────┐
│                                             │
│      Query Analysis                         │
│                                             │
│  1. Convert query to lowercase              │
│  2. Check for keywords                      │
│  3. Match against topics:                   │
│     - Greetings (peace, salam)              │
│     - Allah/God (allah, creator)            │
│     - Prayer (salah, namaz)                 │
│     - Mercy (merciful, compassion)          │
│     - General questions                     │
│                                             │
└──────────────────┬──────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────┐
│                                             │
│      Search Islamic Knowledge               │
│                                             │
│  • Search Quran verses                      │
│  • Search Hadith collections                │
│  • Retrieve relevant content                │
│  • Collect references                       │
│                                             │
└──────────────────┬──────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────┐
│                                             │
│      Generate Response                      │
│                                             │
│  • Format response text                     │
│  • Include Arabic text                      │
│  • Include English translation              │
│  • Add source references                    │
│  • Create Message object                    │
│                                             │
└──────────────────┬──────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────┐
│                                             │
│      Display AI Response                    │
│                                             │
│  • Response added to chat                   │
│  • Message bubble rendered                  │
│  • References shown as tags                 │
│  • Timestamp displayed                      │
│  • Auto-scroll to bottom                    │
│                                             │
└──────────────────┬──────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────┐
│                                             │
│      User Reads Response                    │
│                                             │
│  • View Arabic text                         │
│  • Read translation                         │
│  • See source references                    │
│  • Learn Islamic knowledge                  │
│                                             │
└──────────────────┬──────────────────────────┘
                   │
                   ▼
        ┌──────────┴──────────┐
        │                     │
        ▼                     ▼
   Ask Another          Read More
   Question             Responses
        │                     │
        └──────────┬──────────┘
                   │
                   ▼
              (Loop back to "User Types a Question")
```

## Technical Data Flow

```
User Input
    │
    ▼
ChatInput Widget
    │
    ├─> Validate input
    ├─> Create user Message object
    │   • id: timestamp
    │   • text: user input
    │   • isUser: true
    │   • timestamp: now
    │
    ▼
ChatScreen State
    │
    ├─> Add user message to _messages list
    ├─> Set _isLoading = true
    ├─> Update UI (setState)
    │
    ▼
AIResponseService.generateResponse()
    │
    ├─> Analyze query keywords
    ├─> Determine query category
    │
    ▼
IslamicKnowledgeService
    │
    ├─> searchQuran(query)
    │   • Filter verses by keywords
    │   • Return matching QuranVerse objects
    │
    ├─> searchHadith(query)
    │   • Filter hadiths by keywords
    │   • Return matching Hadith objects
    │
    ├─> getRandomVerse() [if needed]
    ├─> getRandomHadith() [if needed]
    │
    ▼
Response Generation
    │
    ├─> Format response text
    ├─> Combine Quran + Hadith if applicable
    ├─> Collect references
    ├─> Create AI Message object
    │   • id: timestamp
    │   • text: formatted response
    │   • isUser: false
    │   • timestamp: now
    │   • references: [sources]
    │
    ▼
ChatScreen State
    │
    ├─> Add AI message to _messages list
    ├─> Set _isLoading = false
    ├─> Update UI (setState)
    │
    ▼
MessageBubble Widget
    │
    ├─> Render message bubble
    ├─> Show avatar icon
    ├─> Display text
    ├─> Show reference tags (if any)
    ├─> Display timestamp
    │
    ▼
User sees response in chat interface
```

## Component Interaction Diagram

```
┌─────────────────────────────────────────────────────────┐
│                      PeaceAIApp                         │
│  (MaterialApp with routing and theming)                 │
└────────────────┬───────────────────┬────────────────────┘
                 │                   │
         ┌───────┴────────┐  ┌──────┴─────────┐
         │                │  │                 │
         ▼                │  ▼                 │
┌─────────────────┐       │  ┌─────────────────┐
│  SplashScreen   │       │  │   ChatScreen    │
│                 │       │  │                 │
│ • Animation     │       │  │ • Message List  │
│ • Timer (3s)    │       │  │ • Chat Input    │
│ • Navigate      │───────┘  │ • AI Service    │
└─────────────────┘          └────────┬────────┘
                                      │
                    ┌─────────────────┼─────────────────┐
                    │                 │                 │
                    ▼                 ▼                 ▼
          ┌──────────────┐  ┌──────────────┐  ┌──────────────┐
          │ MessageBubble│  │  ChatInput   │  │ AIResponse   │
          │              │  │              │  │   Service    │
          │ • Display    │  │ • TextField  │  │              │
          │ • Avatar     │  │ • Send Btn   │  │ • Process    │
          │ • References │  │ • Validation │  │ • Generate   │
          └──────────────┘  └──────────────┘  └──────┬───────┘
                                                      │
                                                      ▼
                                              ┌──────────────┐
                                              │  Islamic     │
                                              │  Knowledge   │
                                              │  Service     │
                                              │              │
                                              │ • Search     │
                                              │ • Retrieve   │
                                              └──────┬───────┘
                                                      │
                                    ┌─────────────────┼─────────────────┐
                                    │                 │                 │
                                    ▼                 ▼                 ▼
                            ┌──────────────┐  ┌──────────────┐  ┌──────────────┐
                            │   Message    │  │  QuranVerse  │  │    Hadith    │
                            │    Model     │  │    Model     │  │    Model     │
                            │              │  │              │  │              │
                            │ • Serialize  │  │ • Reference  │  │ • Reference  │
                            │ • Timestamp  │  │ • Text       │  │ • Text       │
                            └──────────────┘  └──────────────┘  └──────────────┘
```

## State Flow Diagram

```
Initial State
     │
     ▼
┌──────────────────┐
│ Splash Screen    │
│ State: Loading   │
└────────┬─────────┘
         │ 3 seconds
         ▼
┌──────────────────┐
│ Chat Screen      │
│ State: Ready     │
│ Messages: [      │
│   Welcome Msg    │
│ ]                │
└────────┬─────────┘
         │ User types
         ▼
┌──────────────────┐
│ State: Ready     │
│ Input: "query"   │
└────────┬─────────┘
         │ User sends
         ▼
┌──────────────────┐
│ State: Loading   │
│ Messages: [      │
│   Welcome Msg,   │
│   User Msg       │
│ ]                │
│ Loading: true    │
└────────┬─────────┘
         │ AI processes
         ▼
┌──────────────────┐
│ State: Ready     │
│ Messages: [      │
│   Welcome Msg,   │
│   User Msg,      │
│   AI Response    │
│ ]                │
│ Loading: false   │
└────────┬─────────┘
         │
         └─> (Loop back for next question)
```

## Message Flow Example

**User Query:** "Tell me about mercy"

```
1. User Input: "Tell me about mercy"
   │
   ▼
2. Message Created:
   {
     id: "1700189123456",
     text: "Tell me about mercy",
     isUser: true,
     timestamp: 2025-11-17 03:00:00
   }
   │
   ▼
3. Query Analysis:
   - Lowercase: "tell me about mercy"
   - Keywords found: ["mercy"]
   - Category: Mercy/Compassion
   │
   ▼
4. Knowledge Search:
   - searchQuran("mercy") → 1 verse found
   - searchHadith("mercy") → 1 hadith found
   │
   ▼
5. Response Generated:
   "Allah is the Most Merciful...
    
    الرَّحْمَٰنِ الرَّحِيمِ
    
    ...the Entirely Merciful, the Especially Merciful.
    
    The Prophet Muhammad (pbuh) said:
    Show mercy to others and you will receive mercy."
   │
   ▼
6. AI Message Created:
   {
     id: "1700189124000",
     text: "[response above]",
     isUser: false,
     timestamp: 2025-11-17 03:00:01,
     references: ["Al-Fatihah 1:1", "Sahih Bukhari 78:651"]
   }
   │
   ▼
7. Display in Chat:
   [User Message Bubble]
   "Tell me about mercy"
   
   [AI Message Bubble with references]
   "Allah is the Most Merciful..."
   [Tag: Al-Fatihah 1:1] [Tag: Sahih Bukhari 78:651]
```

---

## Navigation Flow

```
App Launch
    │
    ▼
Route: '/' ──────> SplashScreen
                        │
                        │ 3 seconds + animation
                        │
                        ▼
Route: '/chat' ────> ChatScreen
                        │
                        │ Info button pressed
                        │
                        ▼
                   About Dialog
                        │
                        │ Close button
                        │
                        ▼
                   Back to ChatScreen
```

---

This flow diagram illustrates how Peace AI processes user queries and delivers Islamic knowledge through an intuitive chat interface.
