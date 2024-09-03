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
    <br>
    <a href="https://github.com/ali-hv/comsu/blob/main/assets/screenshot-1.png">
      <img src="https://github.com/ali-hv/comsu/blob/main/assets/screenshot-1.png" alt="Comsu" width="700"/>
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
- **Auto Commit**: It can automatically commit your changes with your selected commit message. 
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
git comsu
```

This will generate a list of suggested commit messages based on your changes and you can choose the message you want, then it will automatically commit your changes with that message. If you don't like any of the messages, you can type 'x' to exit.

**Example**

```bash
git add .
git comsu
```

**Output**:

```
Generating the commit messages based on your changes ...

1. ref: Refactor the send_email function for efficiency
2. ref: Update the send_email to reduce processing time
3. feat: Use new method for getting the changes in send_email

Write the message number you want to use (write 'x' to exit): 1

[main 6b25961] ref: Refactor the send_email function for efficiency
 1 file changed, 1 deletion(-)

Committed successfully.
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
