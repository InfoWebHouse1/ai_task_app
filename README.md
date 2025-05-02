# 🧠 AI Task App

A voice-controlled task manager app built with **Flutter**, powered by **Google Gemini Pro** for natural language understanding, and using **Provider** for clean state management.

---

## 🚀 Features

- 🎙️ **Voice Commands**
  - Tap the mic button to speak commands like:
    - “Create a task titled ‘Team Meeting’ at 8:50 PM on December 5th, 2025.”
    - “Update the task ‘Team Meeting’ to 7:50 PM.”
    - “Delete the task ‘Team Meeting’.”
- 📋 **Task Cards**
  - Tasks are displayed in a scrollable list as cards with title, description, and scheduled date/time.
  - Chronologically sorted.
- 🧠 **Gemini Pro Integration**
  - Voice-to-text is parsed via **LLM** to extract actions (create, update, delete) with details.
- 🗑️ **Manual Task Deletion**
  - Each task card includes a delete icon.
- 🧩 **Provider for State Management**
  - Centralized and reactive task list updates.
- 📦 **Ready for Hive Storage**
  - Easily extendable for offline/local task saving.

---

## 🛠️ Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone https://github.com/<your-username>/ai_task_app.git
   cd ai_task_app
- Install Dependencies
   flutter pub get
   flutter run
   
Add Gemini API Key replace this placeholder

🔗 How LLM Integration Works
- User speaks a command using the FAB (Floating Action Button).

- speech_to_text package converts voice to text.

- Text is sent to the Gemini Pro API via this endpoint:

🧩 State Management with Provider
- The app uses the Provider package for managing state, ensuring:

- Task list updates are reactive and cleanly separated from UI.

- Scalability: logic for adding, updating, deleting tasks lives in a TaskProvider class.

- Flexibility to migrate to ChangeNotifierProvider or advanced patterns like Riverpod or Bloc later.


