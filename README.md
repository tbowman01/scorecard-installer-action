# OpenSSF Scorecard Installer Action

[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/tbowman01/scorecard-installer-action/badge)](https://securityscorecards.dev/viewer/?uri=github.com/tbowman01/scorecard-installer-action)

---

## 🚀 What It Does

This GitHub Action installs the [OpenSSF Scorecard](https://github.com/ossf/scorecard) workflow and badge into a target repository. It automates:

* Adding the Scorecard GitHub Action workflow to `.github/workflows/scorecards.yml`
* Injecting the OpenSSF badge into the top of `README.md`
* Creating a pull request with the changes (unless `dry_run` is enabled)

---

## 📦 Usage

```yaml
name: Install OpenSSF Scorecard

on:
  workflow_dispatch:

jobs:
  install-scorecard:
    runs-on: ubuntu-latest
    steps:
      - name: Use Scorecard Installer
        uses: ./.github/actions/scorecard-installer
        with:
          repo_url: https://github.com/YOUR_ORG/YOUR_REPO
          branch: main
          github_token: ${{ secrets.GITHUB_TOKEN }}
          dry_run: false
          cron: "15 14 * * 5"
```

---

## 🎛 Inputs

| Name           | Required | Default         | Description                                      |
| -------------- | -------- | --------------- | ------------------------------------------------ |
| `repo_url`     | ✅ Yes    | —               | URL of the target GitHub repository              |
| `branch`       | ❌ No     | `main`          | Branch to base the PR from                       |
| `github_token` | ✅ Yes    | —               | Token with `repo` and `workflow` scopes          |
| `dry_run`      | ❌ No     | `false`         | If `true`, simulates changes without creating PR |
| `cron`         | ❌ No     | `'15 14 * * 5'` | Custom cron for the scheduled Scorecard scan     |

---

## ✅ Example Badge Added to README

```
[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/tbowman01/scorecard-installer-action/badge)](https://securityscorecards.dev/viewer/?uri=github.com/tbowman01/scorecard-installer-action)
```

---

## 🧪 Test Locally with `act`

```bash
act -j install-scorecard
```

### 🔧 How to Install `act`

If `act` is not already installed, follow these steps:

**For macOS (Homebrew):**

```bash
brew install act
```

**For Linux:**

```bash
curl -s https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash
```

**For Windows (Scoop):**

```powershell
scoop install act
```

Or download from the [releases page](https://github.com/nektos/act/releases) and place it in your system's PATH.

---

## 📌 Notes

* Requires a GitHub token with write access to the target repo
* Will skip PR creation if no changes are detected
* Can be reused in org-wide workflows

---

## 📥 Coming Soon

* GitHub Marketplace listing
* Scorecard dashboard link
* Multi-repo install orchestrator

---

## 👤 Author

**Trevor Bowman** — [github.com/tbowman01](https://github.com/tbowman01)
