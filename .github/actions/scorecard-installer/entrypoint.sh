#!/bin/bash
set -e

REPO_URL=$INPUT_REPO_URL
BRANCH=${INPUT_BRANCH:-main}
GITHUB_TOKEN=$INPUT_GITHUB_TOKEN
DRY_RUN=$INPUT_DRY_RUN
CRON=${INPUT_CRON:-'15 14 * * 5'}

if [ -z "$REPO_URL" ] || [ -z "$GITHUB_TOKEN" ]; then
  echo "❌ Missing required inputs: repo_url and github_token."
  exit 1
fi

REPO_NAME=$(basename -s .git "$REPO_URL")
CLONE_DIR="/tmp/$REPO_NAME"

git clone --depth 1 --branch "$BRANCH" "$REPO_URL" "$CLONE_DIR"
cd "$CLONE_DIR"

mkdir -p .github/workflows
TEMPLATE="/app/scorecards.yml"
TARGET=".github/workflows/scorecards.yml"

# Inject custom cron
sed "s|'15 14 \* \* 5'|$CRON|" "$TEMPLATE" > "$TARGET.new"

if [ -f "$TARGET" ] && diff -q "$TARGET" "$TARGET.new" > /dev/null; then
  echo "✅ Existing workflow is identical, skipping update."
else
  mv "$TARGET.new" "$TARGET"
  echo "✅ Scorecard workflow updated."
fi

# Add badge
if ! grep -q "OpenSSF Scorecard" README.md 2>/dev/null; then
  ORG_NAME=$(git remote get-url origin | sed -E "s|.*github.com[:/](.*)/$REPO_NAME.git||")
  BADGE="[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/${ORG_NAME}/${REPO_NAME}/badge)](https://securityscorecards.dev/viewer/?uri=github.com/${ORG_NAME}/${REPO_NAME})"
  echo -e "$BADGE\n\n$(cat README.md)" > README.md
  echo "✅ Badge added to README.md."
else
  echo "✅ Badge already present."
fi

if [[ "$DRY_RUN" == "true" ]]; then
  echo "🧪 Dry run mode: showing git diff"
  git --no-pager diff
  exit 0
fi

git config user.email "bot@openssf.dev"
git config user.name "OpenSSF Installer Bot"
git checkout -b scorecard-setup || git checkout scorecard-setup
git add .github README.md
git commit -m "Add OpenSSF Scorecard workflow and badge" || echo "No changes to commit"
git push origin scorecard-setup

export GH_TOKEN="$GITHUB_TOKEN"
gh pr create --title "Add OpenSSF Scorecard" --body "This PR installs the Scorecard GitHub Action and adds the badge." --base "$BRANCH" --head scorecard-setup || echo "PR already exists."

echo "🎉 Done."
