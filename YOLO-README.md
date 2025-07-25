## 📦 YOLO GUIDE

```yaml
name: Install OpenSSF Scorecard

on:
  workflow_dispatch:

jobs:
  install-scorecard:
    runs-on: ubuntu-latest
    steps:
      - name: Use Scorecard Installer
-       uses: ./.github/actions/scorecard-installer
+       uses: tbowman01/scorecard-installer-action@v1
        with:
          repo_url: https://github.com/tbowman01/scorecard-installer-action
          branch: main
          github_token: ${{ secrets.GITHUB_TOKEN }}
          dry_run: false
          cron: "15 14 * * 5"

---
## ✅ Example Badge Added to README

```
[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/tbowman01/scorecard-installer-action/badge)](https://securityscorecards.dev/viewer/?uri=github.com/tbowman01/scorecard-installer-action)
```
