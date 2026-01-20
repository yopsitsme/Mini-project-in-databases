// src/App.jsx
import { useState } from "react";
import { HomePage } from "./pages/HomePage";
import { TeacherPage } from "./pages/TeacherPage";
import { StudentPage } from "./pages/StudentPage";
import { SecretaryPage } from "./pages/SecretaryPage";
import { RevenuePage } from "./pages/RevenuePage";
import { RegisterStudentPage } from "./pages/RegisterStudentPage";
import { RegisterTeacherPage } from "./pages/RegisterTeacherPage";
import ResultMessage from "./components/ResultMessage";

const App = () => {
  const [currentScreen, setCurrentScreen] = useState("home");
  const [resultMessage, setResultMessage] = useState("");
  const [resultType, setResultType] = useState("");
  const [resultTitle, setResultTitle] = useState("");

  const handleShowResult = (type, title, message) => {
    setResultType(type);
    setResultTitle(title);
    setResultMessage(message);
    setCurrentScreen("result");
  };

  const handleCloseResult = () => {
    setCurrentScreen("home");
    setResultMessage("");
    setResultType("");
    setResultTitle("");
  };

  const handleGoBack = (screen = "secretary") => {
    setCurrentScreen(screen);
  };

  const renderScreen = () => {
    switch (currentScreen) {
      case "home":
        return <HomePage onSelectScreen={setCurrentScreen} />;

      case "teacher":
        return (
          <TeacherPage
            onGoHome={() => setCurrentScreen("home")}
            onShowResult={handleShowResult}
          />
        );

      case "student":
        return <StudentPage onGoHome={() => setCurrentScreen("home")} />;

      case "secretary":
        return (
          <SecretaryPage
            onGoHome={() => setCurrentScreen("home")}
            onSelectScreen={setCurrentScreen}
          />
        );

      case "revenue":
        return <RevenuePage onGoBack={() => handleGoBack("secretary")} />;

      case "register-student":
        return (
          <RegisterStudentPage
            onGoBack={() => handleGoBack("secretary")}
            onShowResult={handleShowResult}
          />
        );

      case "register-teacher":
        return (
          <RegisterTeacherPage
            onGoBack={() => handleGoBack("secretary")}
            onShowResult={handleShowResult}
          />
        );

      case "result":
        return (
          <ResultMessage
            type={resultType}
            title={resultTitle}
            message={resultMessage}
            onClose={handleCloseResult}
          />
        );

      default:
        return <HomePage onSelectScreen={setCurrentScreen} />;
    }
  };

  return renderScreen();
};

export default App;
