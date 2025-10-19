# 📍 Location Data App

A **full-stack project** to manage and visualize location data using a **Flutter frontend** and a **JSON Server backend**.

---

## ✅ Features

- 📌 List, add, edit, and delete locations
- 🗺️ View locations on a map (OpenStreetMap integration)
- 📱 Responsive UI built with Flutter
- 🌐 Backend powered by JSON Server (Node.js)
- 🔁 Easy navigation between list view and map view

---

## 🗂 Project Structure

```
Backend/                 # Node.js / JSON Server backend
├── LocationData.json    # Sample location data

location_data_app/       # Flutter frontend application
├── lib/
    ├── models/          # Data models (Location, etc.)
    ├── services/        # API service layer
    ├── presentation/    # UI pages/screens
```

---

## 🚀 Getting Started

### 🛠 Backend (JSON Server)

1️⃣ Install **Node.js**  
2️⃣ Install JSON Server globally:
```bash
npm install -g json-server
```

3️⃣ Start the server:
```bash
json-server --watch LocationData.json --port 3000
```

---

### 💙 Flutter App

1️⃣ Install **Flutter SDK**  
2️⃣ Get dependencies:
```bash
flutter pub get
```

3️⃣ Run the app:
```bash
flutter run
```

## Map Integration

- Uses [flutter_map](https://pub.dev/packages/flutter_map) and [OpenStreetMap](https://www.openstreetmap.org/)
- No API key required

## How to Contribute

1. Fork the repository
2. Create a new branch
3. Make your changes
4. Submit a pull request

## License

MIT License

---

**Author:** Vaishnav Ravindran

This project is for learning/demo purposes. Add a license if needed.
