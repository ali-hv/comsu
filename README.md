<h1 align="center">
  <br>
  <a href="https://github.com/ali-hv/comsu/blob/main/assets/logo.png">
      <img src="https://github.com/ali-hv/comsu/blob/main/assets/logo.png" alt="Comsu" width="400">
  </a>
</h1>

<h3 align="center">🚀 AI-Powered(wrapper) Commit Message Generator</h3>

<p align="center">
    <a href="https://img.shields.io/badge/License-GPLv3-blue.svg">
        <img src="https://img.shields.io/badge/License-GPLv3-blue.svg" />
    </a>
    <a href="https://img.shields.io/badge/Shell-Bash-green.svg">
        <img src="https://img.shields.io/badge/Shell-Bash-green.svg" />
    </a>
    <a href="https://img.shields.io/badge/AI-Google%20Generative%20AI-yellow.svg">
        <img src="https://img.shields.io/badge/AI-Google%20Generative%20AI-yellow.svg" />
    </a>
</p>

**Comsu** is a simple yet powerful command-line tool that leverages Google Generative AI to suggest high-quality, concise commit messages based on your staged changes in Git. Automate the process of writing meaningful commit messages and ensure consistency across your project.

---

## Table of Contents

* [Features](#-features)
* [Installation](#-installation)
* [Usage](#-usage)
* [Contributing](#-contributing)
* [Show your support](#-show-your-support)

---

## 🌟 Features

- **Automated Commit Messages**: Generate commit messages based on your staged changes using Google's AI model.
- **Supports Conventional Commit Types**: Suggestions follow the standard commit types (`feat`, `fix`, `build`, `chore`, etc.).
- **Easy Setup**: One-command installation to get started.
- **Customizable Prompts**: Modify the prompt file to tailor the AI suggestions to your specific project needs.

---

## 📦 Installation

To set up **Comsu** on your Linux system, follow these steps:

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/ali-hv/comsu.git
    cd comsu
    ```

2. **Run the Installation Script**:
    ```bash
    chmod +x install.sh
    sudo ./install.sh
    ```

3. **Set Your API Key**:

    Make sure you have your Google AI Studio API key set as an environment variable. If you don’t have one, you can create a free API key [here](https://aistudio.google.com/app/apikey).
    ```bash
    export GOOGLE_AI_STUDIO_API_KEY="your_api_key_here"
    ```

   You can add this line to your `~/.bashrc` or `~/.zshrc` to make it persistent.

---

## 🚀 Usage

Once installed, you can run **Comsu** from any directory where you have staged changes:

```bash
comsu
```

This will generate a list of suggested commit messages based on your changes.

**Example**

```bash
git add .
comsu
```

**Output**:

```bash
Suggested Commit Messages:

- "ref: Refactor the get_staged_changes function for efficiency"
- "ref: Update the get_staged_changes to reduce processing time"
- "feat: Use new method for getting the changes in get_staged_changes"

```

---

## ⚙️ Configuration


The prompt used to generate the commit messages is stored in a file named prompt located at /usr/local/share/comsu/prompt. You can modify this file to change the way AI generates the commit messages.

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the issues page.

1. Fork the repository.
2. Create your feature branch (git checkout -b feature/new-feature).
3. Commit your changes (git commit -m 'Add some feature').
4. Push to the branch (git push origin feature/new-feature).
5. Open a Pull Request.

---

## 🌟 Show your support

If you find this tool helpful, please give a ⭐ to the repository!
