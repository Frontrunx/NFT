#!/bin/bash
echo "Setting up Git config and creating commits..."

# Set Git config for this repo
git config user.name "Frontrunx"
git config user.email "your-email@used-on-github.com"

echo "Git config set to:"
git config user.name
git config user.email

echo "Creating commits across 2019-2025..."

for i in {1..200}; do
    # Random date between 2019-2025 (all years!)
    year=$((2019 + RANDOM % 7))  # 2019-2025 = 7 years
    month=$((1 + RANDOM % 12))
    day=$((1 + RANDOM % 28))
    commit_date="$year-$month-$day 12:00:00"
    
    # Create realistic file change
    echo "Update #$i - Date: $commit_date" >> development_log.txt
    git add .
    
    # Commit with proper date
    GIT_COMMITTER_DATE="$commit_date" git commit -m "dev: update for $year-$month-$day" --date="$commit_date" --no-edit
    
    echo "Created commit $i for: $commit_date"
    sleep 1
done

echo "Pushing to GitHub..."
git push origin main
echo "Done! Commits created across 2019-2025."
